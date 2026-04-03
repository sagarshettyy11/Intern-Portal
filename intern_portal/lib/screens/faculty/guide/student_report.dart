import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/guide/guide_report_model.dart';
import 'package:intern_portal/screens/faculty/guide/faculty_profile.dart';
import 'package:intern_portal/screens/faculty/guide/report_review.dart';
import 'package:intern_portal/services/users/guide_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class StudentReportsPage extends StatefulWidget {
  const StudentReportsPage({super.key});
  @override
  State<StudentReportsPage> createState() => _StudentReportsPageState();
}

class _StudentReportsPageState extends State<StudentReportsPage> {
  int _selectedTab = 0;
  bool isLoading = true;
  ReportListResponse? response;
  final tabs = ["Daily", "Weekly", "Monthly"];
  @override
  void initState() {
    super.initState();
    loadReports();
  }

  Future<void> loadReports() async {
    setState(() => isLoading = true);
    final res = await GuideServices.fetchReports(tab: tabs[_selectedTab], page: 1);
    setState(() {
      response = res;
      isLoading = false;
    });
  }

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFF2563EB);
      case 'rejected':
        return Colors.red;
      default:
        return Colors.orange;
    }
  }

  Color getStatusBg(String status) {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFFEFF6FF);
      case 'rejected':
        return const Color(0xFFFFF1F1);
      default:
        return const Color(0xFFFFF8E1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
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
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ACADEMIC INSIGHTS',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0000EF),
                      letterSpacing: 0.8,
                    ),
                  ),
                  Text(
                    'Student Reports',
                    style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.black87),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _ReportStatCard(
                          icon: Icons.pending_actions_outlined,
                          iconColor: Colors.orange,
                          label: 'PENDING',
                          value: "${response?.stats.pending ?? 0}",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _ReportStatCard(
                          icon: Icons.verified_outlined,
                          iconColor: const Color(0xFF2563EB),
                          label: 'APPROVED',
                          value: "${response?.stats.approved ?? 0}",
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: _ReportStatCard(
                          icon: Icons.cancel_outlined,
                          iconColor: Colors.red,
                          label: 'REJECTED',
                          value: "${response?.stats.rejected ?? 0}",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(color: const Color(0xFF2563EB), borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AVERAGE SCORE',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: Colors.white.withValues(alpha: 0.8),
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${response?.stats.avgScore ?? 0}",
                              style: GoogleFonts.inter(
                                fontSize: 38,
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                height: 1,
                              ),
                            ),
                            Text(
                              '%',
                              style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _TabItem(
                        label: 'Daily Reports',
                        isSelected: _selectedTab == 0,
                        onTap: () {
                          setState(() => _selectedTab = 0);
                          loadReports();
                        },
                      ),
                      const SizedBox(width: 20),
                      _TabItem(
                        label: 'Weekly Summaries',
                        isSelected: _selectedTab == 1,
                        onTap: () {
                          setState(() => _selectedTab = 1);
                          loadReports();
                        },
                      ),
                      const SizedBox(width: 20),
                      _TabItem(
                        label: 'Monthly Reviews',
                        isSelected: _selectedTab == 2,
                        onTap: () {
                          setState(() => _selectedTab = 2);
                          loadReports();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : response == null || response!.reports.isEmpty
                      ? const Center(child: Text("No reports found"))
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: response!.reports.length,
                          itemBuilder: (context, index) {
                            final r = response!.reports[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (_) => ReportDetailsPage(reportId: r.reportId)),
                                  );
                                },
                                child: _ReportRow(
                                  name: r.studentName,
                                  role: r.jobTitle ?? r.reportType,
                                  time: r.submittedOn ?? '',
                                  status: r.statusLabel,
                                  statusColor: getStatusColor(r.status),
                                  statusBg: getStatusBg(r.status),
                                ),
                              ),
                            );
                          },
                        ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GuideAppBottomNav(
        currentIndex: 2,
        onTap: (index) => GuideBottomNavController.onItemTapped(context, index),
      ),
    );
  }
}

class _ReportStatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  const _ReportStatCard({required this.icon, required this.iconColor, required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: Colors.grey[700],
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  const _TabItem({required this.label, required this.isSelected, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w700,
              color: isSelected ? const Color(0xFF0000FF) : Colors.grey[700],
            ),
          ),
          const SizedBox(height: 4),
          if (isSelected) Container(height: 2, width: label.length * 7.2, color: const Color(0xFF2563EB)),
        ],
      ),
    );
  }
}

class _ReportRow extends StatelessWidget {
  final String name;
  final String role;
  final String time;
  final String status;
  final Color statusColor;
  final Color statusBg;
  const _ReportRow({
    required this.name,
    required this.role,
    required this.time,
    required this.status,
    required this.statusColor,
    required this.statusBg,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 48,
              height: 48,
              color: const Color(0xFFD0E8F0),
              child: Icon(Icons.person, color: Colors.blueGrey[700], size: 28),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14, color: Colors.black87),
                ),
                Text(
                  '$role • $time',
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(20)),
            child: Text(
              status.toUpperCase(),
              style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w800, color: statusColor),
            ),
          ),
        ],
      ),
    );
  }
}
