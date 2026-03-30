import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/screens/faculty/guide/faculty_profile.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class InternshipRequestsPage extends StatelessWidget {
  const InternshipRequestsPage({super.key});
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _SummaryBox(label: 'TOTAL', value: '12', valueColor: Colors.black87),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _SummaryBox(label: 'PENDING', value: '4', valueColor: const Color(0xFF2563EB)),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _SummaryBox(label: 'APPROVED', value: '6', valueColor: Colors.green),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey[400], size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Search students or companies...',
                          style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[400]),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Icon(Icons.tune, color: Colors.grey[600], size: 20),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MANAGEMENT PORTAL',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2563EB),
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Internship Requests',
                      style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey[600]),
                      const SizedBox(width: 5),
                      Text('Oct 2023', style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700])),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _RequestCard(
              companyIconBg: const Color(0xFFEFF6FF),
              companyIcon: Icons.business_outlined,
              companyIconColor: const Color(0xFF2563EB),
              companyName: 'Nova Dynamics',
              studentName: 'Student: Sarah Jenkins',
              status: 'APPROVED',
              statusColor: const Color(0xFF2563EB),
              statusBg: const Color(0xFFEFF6FF),
              submittedDate: 'Oct 12, 2023',
              mentor: 'Prof. Miller',
            ),
            const SizedBox(height: 12),
            _RequestCard(
              companyIconBg: const Color(0xFFFFF8E1),
              companyIcon: Icons.rocket_launch_outlined,
              companyIconColor: Colors.amber,
              companyName: 'Stellar Labs',
              studentName: 'Student: Marcus Thorne',
              status: 'PENDING',
              statusColor: Colors.white,
              statusBg: const Color(0xFFB7950B),
              submittedDate: 'Oct 14, 2023',
              mentor: 'Dr. Aris',
            ),
            const SizedBox(height: 12),
            _RequestCard(
              companyIconBg: const Color(0xFFF4F4F4),
              companyIcon: Icons.architecture,
              companyIconColor: Colors.grey,
              companyName: 'Apex Design',
              studentName: 'Student: Chloe Varga',
              status: 'REJECTED',
              statusColor: Colors.red,
              statusBg: const Color(0xFFFFF1F1),
              submittedDate: 'Oct 09, 2023',
              mentor: 'Prof. Miller',
            ),
            const SizedBox(height: 12),
            _RequestCard(
              companyIconBg: const Color(0xFFEFF6FF),
              companyIcon: Icons.biotech_outlined,
              companyIconColor: const Color(0xFF2563EB),
              companyName: 'BioGenics',
              studentName: "Student: Liam O'Connor",
              status: 'APPROVED',
              statusColor: const Color(0xFF2563EB),
              statusBg: const Color(0xFFEFF6FF),
              submittedDate: 'Oct 16, 2023',
              mentor: 'Dr. Aris',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: GuideAppBottomNav(
        currentIndex: 1,
        onTap: (index) => GuideBottomNavController.onItemTapped(context, index),
      ),
    );
  }
}

class _SummaryBox extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  const _SummaryBox({required this.label, required this.value, required this.valueColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: Colors.grey[500],
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: valueColor),
          ),
        ],
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  final Color companyIconBg;
  final IconData companyIcon;
  final Color companyIconColor;
  final String companyName;
  final String studentName;
  final String status;
  final Color statusColor;
  final Color statusBg;
  final String submittedDate;
  final String mentor;
  const _RequestCard({
    required this.companyIconBg,
    required this.companyIcon,
    required this.companyIconColor,
    required this.companyName,
    required this.studentName,
    required this.status,
    required this.statusColor,
    required this.statusBg,
    required this.submittedDate,
    required this.mentor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey[200]!),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(color: companyIconBg, borderRadius: BorderRadius.circular(10)),
                  child: Icon(companyIcon, color: companyIconColor, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        companyName,
                        style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                      ),
                      Text(studentName, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500])),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    status,
                    style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: statusColor),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            Divider(height: 1, color: Colors.grey[100]),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SUBMITTED DATE',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        submittedDate,
                        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ASSIGNED MENTOR',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        mentor,
                        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
