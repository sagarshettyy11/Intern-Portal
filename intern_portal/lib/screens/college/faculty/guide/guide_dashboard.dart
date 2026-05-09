import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/guide/guide_dashboard_model.dart';
import 'package:intern_portal/screens/college/faculty/guide/faculty_profile.dart';
import 'package:intern_portal/screens/college/faculty/guide/notification.dart';
import 'package:intern_portal/screens/college/faculty/guide/send_notfication.dart';
import 'package:intern_portal/services/users/guide_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class GuideDashboardPage extends StatefulWidget {
  const GuideDashboardPage({super.key});
  @override
  State<GuideDashboardPage> createState() => _GuideDashboardPageState();
}

class _GuideDashboardPageState extends State<GuideDashboardPage> {
  GuideDashboardModel? dashboard;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    final data = await GuideServices.fetchGuideDashboard();
    setState(() {
      dashboard = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (dashboard == null) {
      return Scaffold(body: Center(child: Text("Failed to load")));
    }
    final d = dashboard!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        showLogo: true,
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => FacultyProfilePage()));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircleAvatar(radius: 16, child: Icon(Icons.person, size: 18, color: Colors.black)),
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => GuideNotifications()));
            },
            child: const Icon(Icons.notifications_outlined, color: Colors.black, size: 24),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(color: const Color(0xFFF4F6FB), borderRadius: BorderRadius.circular(30)),
              child: Row(
                children: [
                  Icon(Icons.search, color: Colors.grey[800], size: 20),
                  const SizedBox(width: 10),
                  Text(
                    'Search by student name or company...',
                    style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700]),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: const Color(0xFF2563EB), borderRadius: BorderRadius.circular(14)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(Icons.group, color: Colors.white, size: 22, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        d.totalApproved.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1,
                        ),
                      ),
                      const SizedBox(width: 130),
                      Text(
                        'MENTORSHIP REACH',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: Colors.white.withValues(alpha: 0.85),
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Total Approved Internships',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.85),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: const Color(0xFF2563EB).withValues(alpha: 0.15),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: Color(0xFF2563EB),
                                size: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              d.currentlyActive.toString(),
                              style: GoogleFonts.inter(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'CURRENTLY ACTIVE',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey[500],
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: const Color(0xFFF4F6FB), borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                color: Colors.amber.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.check_circle_outline,
                                color: Colors.amber,
                                size: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              d.completed.toString(),
                              style: GoogleFonts.inter(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'COMPLETED',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey[500],
                            letterSpacing: 0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'YOUR NETWORK',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF2563EB),
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Assigned Mentees',
                      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black87),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'See All',
                      style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF2563EB)),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.arrow_forward, size: 14, color: Color(0xFF0000FF), fontWeight: FontWeight.w800),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            Column(
              children: d.students.map((s) {
                Color statusColor;
                Color statusBg;
                String label;
                switch (s.status.toLowerCase()) {
                  case 'approved':
                    label = "ONGOING";
                    statusColor = Colors.amber;
                    statusBg = Color(0xFFFFF8E1);
                    break;
                  case 'completed':
                    label = "COMPLETED";
                    statusColor = Colors.blueGrey;
                    statusBg = Color(0xFFECEFF1);
                    break;
                  case 'pending':
                    label = "PENDING";
                    statusColor = Colors.orange;
                    statusBg = Color(0xFFFFF3E0);
                    break;
                  default:
                    label = "UNKNOWN";
                    statusColor = Colors.grey;
                    statusBg = Colors.grey.shade200;
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _MenteeCard(
                    name: s.name,
                    email: s.email,
                    internshipId: "#INT-${s.internshipId}",
                    company: s.company,
                    statusLabel: label,
                    statusColor: statusColor,
                    statusBg: statusBg,
                    footerNote: "Internship Active",
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: GuideAppBottomNav(
        currentIndex: 0,
        onTap: (index) => GuideBottomNavController.onItemTapped(context, index),
      ),
    );
  }
}

class _MenteeCard extends StatelessWidget {
  final String name;
  final String email;
  final String internshipId;
  final String company;
  final String statusLabel;
  final Color statusColor;
  final Color statusBg;
  final String footerNote;
  const _MenteeCard({
    required this.name,
    required this.email,
    required this.internshipId,
    required this.company,
    required this.statusLabel,
    required this.statusColor,
    required this.statusBg,
    required this.footerNote,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 48,
                  height: 48,
                  color: const Color(0xFF1A3A5C),
                  child: const Icon(Icons.person, color: Colors.white, size: 28),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 15, color: Colors.black87),
                    ),
                    Text(
                      email,
                      style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(color: const Color(0xFFEFF6FF), shape: BoxShape.circle),
                child: const Icon(
                  Icons.visibility_outlined,
                  color: Color(0xFF0000FF),
                  size: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Divider(height: 1, color: Colors.grey[400]),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'INTERNSHIP ID',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      internshipId,
                      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'COMPANY',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      company,
                      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(20)),
                child: Text(
                  statusLabel,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: statusColor,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              Text(
                footerNote,
                style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[400], fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
