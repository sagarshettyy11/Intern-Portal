import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/student/internship_models.dart';
import 'package:intern_portal/screens/college/students/notifications.dart';
import 'package:intern_portal/screens/college/students/profile.dart';
import 'package:intern_portal/services/users/student_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';
import 'package:intern_portal/widgets/common_widgets/common_widgets.dart';

class InternshipsPage extends StatefulWidget {
  const InternshipsPage({super.key});
  @override
  State<InternshipsPage> createState() => _InternshipsPageState();
}

class _InternshipsPageState extends State<InternshipsPage> {
  InternshipModel? data;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final res = await StudentServices.fetchInternship();
    setState(() {
      data = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (data == null) {
      return Scaffold(body: Center(child: Text("Failed to load")));
    }
    final d = data!;
    final milestones = d.milestones;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CommonAppBar(
        showLogo: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationsScreen()));
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
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(color: const Color(0xFF1A1A2E), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(Icons.work_outline, color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        d.internship.jobTitle ?? "Intern",
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            d.internship.company ?? "No Company",
                            style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600]),
                          ),
                          Text(" · ", style: GoogleFonts.inter(color: Colors.grey[400])),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F1FF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              d.internship.status.toUpperCase(),
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                color: Color(0xFF3B6EF0),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: _StatBox(
                      label: "OVERALL COMPLETION",
                      value: "${d.progress.completion}%",
                      sub: "+1%",
                      subColor: Colors.green,
                      showProgress: true,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _StatBox(
                      label: "REPORTS SUBMITTED",
                      value: "${d.reports.approved}/${d.reports.total}",
                      sub: "Due in 2 days",
                      subColor: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _StatBox(
                      label: "DAYS REMAINING",
                      value: "${d.progress.daysRemaining ?? 0} Days",
                      sub: "End Nov 15, 2024",
                      subColor: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                const Icon(Icons.show_chart, color: Color(0xFF3B6EF0), size: 20),
                const SizedBox(width: 6),
                Text(
                  "Internship Milestones",
                  style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const SizedBox(height: 16),

            Column(
              children: List.generate(milestones.length, (index) {
                final m = milestones[index];

                final isDone = m.status == "done";
                final isActive = m.status == "active";
                final isFuture = m.status == "pending";

                return _MilestoneItem(
                  isDone: isDone,
                  isFuture: isFuture,
                  isActive: isActive,
                  title: m.title,
                  date: m.date,
                  isLast: index == milestones.length - 1,
                );
              }),
            ),
            const SizedBox(height: 22),
            Text(
              "Your Mentors",
              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Column(
              children: d.mentors.map((mentor) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _MentorCard(name: mentor.name, role: mentor.role),
                );
              }).toList(),
            ),
            const SizedBox(height: 22),
            Text(
              "Helpful Resources",
              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                children: [
                  ResourceItem(
                    icon: Icons.description_outlined,
                    title: "Internship Guidelines",
                    trailing: Icons.chevron_right,
                  ),
                  Divider(height: 1, indent: 50, color: Colors.grey[200]),
                  ResourceItem(
                    icon: Icons.description_outlined,
                    title: "Support Contects",
                    trailing: Icons.chevron_right,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 1,
        onTap: (index) => StudentBottomNavController.onItemTapped(context, index),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label, value, sub;
  final Color subColor;
  final bool showProgress;
  const _StatBox({
    required this.label,
    required this.value,
    required this.sub,
    required this.subColor,
    this.showProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: Colors.grey[700],
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          if (showProgress) ...[
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: 0.65,
                backgroundColor: Colors.grey[200],
                color: const Color(0xFF3B6EF0),
                minHeight: 4,
              ),
            ),
          ],
          const SizedBox(height: 4),
          Text(
            sub,
            style: GoogleFonts.inter(fontSize: 12, color: subColor, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _MilestoneItem extends StatelessWidget {
  final bool isDone;
  final bool isFuture;
  final bool isActive;
  final String title;
  final String? date;
  final bool isLast;

  const _MilestoneItem({
    required this.isDone,
    required this.isFuture,
    required this.isActive,
    required this.title,
    this.date,
    required this.isLast,
  });
  @override
  Widget build(BuildContext context) {
    String subtitle;
    if (isDone && date != null) {
      subtitle = "Completed on $date";
    } else if (isActive) {
      subtitle = "In progress";
    } else if (date != null) {
      subtitle = "Scheduled for $date";
    } else {
      subtitle = "";
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          child: Column(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isDone ? const Color(0xFF3B6EF0) : Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isDone ? Icons.check : Icons.circle,
                  size: isDone ? 14 : 8,
                  color: isDone ? Colors.white : Colors.grey[400],
                ),
              ),
              if (!isFuture)
                Container(width: 2, height: 52, color: isDone ? const Color(0xFF3B6EF0) : Colors.grey[300]),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isFuture ? 0 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: isFuture ? Colors.grey[400] : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(subtitle, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500])),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MentorCard extends StatelessWidget {
  final String name, role;
  const _MentorCard({required this.name, required this.role});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, color: Colors.grey[800], fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                ),
                Text(
                  role,
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: const Color(0xFFF0F5FF), borderRadius: BorderRadius.circular(8)),
            child: const Icon(
              Icons.chat_bubble_outline,
              color: Color(0xFF3B6EF0),
              size: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
