import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/models/hod/student_report_model.dart';
import 'package:intern_portal/services/users/hod_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

class StudentReviewScreen extends StatefulWidget {
  final int studentId;
  const StudentReviewScreen({super.key, required this.studentId});
  @override
  State<StudentReviewScreen> createState() => _StudentReviewScreenState();
}

class _StudentReviewScreenState extends State<StudentReviewScreen> {
  StudentReportResponse? data;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final res = await HodServices.fetchStudentReports(studentId: widget.studentId);
    setState(() {
      data = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F8),
      appBar: CommonAppBar(title: "Report Details", showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStudentProfileCard(),
            const SizedBox(height: 14),
            _buildStatsRow(),
            const SizedBox(height: 14),
            _buildProgressCard(),
            const SizedBox(height: 20),
            _buildReportsHeader(),
            const SizedBox(height: 14),
            ...(data?.reports ?? []).map(
              (r) => Padding(padding: const EdgeInsets.only(bottom: 14), child: _buildReportCard(r)),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentProfileCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'STUDENT PROFILE',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[500],
                    letterSpacing: 0.8,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(color: const Color(0xFFE8EDF2), borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    data?.internship?.status ?? 'N/A',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              data?.student.name ?? '',
              style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'USN: ${data?.student.registrationNo ?? ''}',
                  style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w700),
                ),
                SizedBox(width: 12),
                Text(
                  'Batch: ${data?.student.batch ?? ''}',
                  style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 8),
            _buildContactRow(Icons.email_outlined, data?.student.email ?? ''),
            const SizedBox(height: 4),
            _buildContactRow(Icons.phone_outlined, data?.student.phone ?? ''),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: const Color(0xFFEFF4FF), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.business_outlined, color: Color(0xFF0000FF), size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data?.internship?.company ?? 'Not Assigned',
                      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF0000FF)),
                    ),
                    Text(
                      '${data?.internship?.startDate ?? ''} - ${data?.internship?.endDate ?? ''}',
                      style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ROLE',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Colors.grey[700],
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  data?.internship?.role ?? 'Not Assigned',
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700], fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 8),
                Text(
                  'GUIDE',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: Colors.grey[700],
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  data?.internship?.guide ?? 'Not Assigned',
                  style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[700], fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[700]),
        const SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    final stats = [
      {'label': 'TOTAL', 'value': data?.stats.total.toString() ?? '0', 'color': const Color(0xFF1565C0)},
      {'label': 'COMPLETED', 'value': data?.stats.approved.toString() ?? '0', 'color': const Color(0xFF2E7D32)},
      {'label': 'PENDING', 'value': data?.stats.pending.toString() ?? '0', 'color': const Color(0xFFF57C00)},
      {'label': 'REJECTED', 'value': data?.stats.rejected.toString() ?? '0', 'color': const Color(0xFFC62828)},
    ];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          children: List.generate(stats.length, (i) {
            return Expanded(
              child: Column(
                children: [
                  Text(
                    stats[i]['label'] as String,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: Colors.grey[700],
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    stats[i]['value'] as String,
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: stats[i]['color'] as Color,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildProgressCard() {
    final internship = data?.internship;
    if (internship == null || internship.startDate.isEmpty || internship.endDate.isEmpty) {
      return const SizedBox();
    }
    DateTime? start = DateTime.tryParse(internship.startDate);
    DateTime? end = DateTime.tryParse(internship.endDate);
    DateTime now = DateTime.now();
    double progress = 0;
    int daysLeft = 0;
    if (start != null && end != null) {
      final totalDays = end.difference(start).inDays;
      final completedDays = now.difference(start).inDays;
      progress = (completedDays / totalDays).clamp(0, 1);
      daysLeft = end.difference(now).inDays;
    }
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'INTERNSHIP PROGRESS',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF0000FF),
                    letterSpacing: 0.6,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: const Color(0xFFEFF4FF), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.calendar_today_outlined, color: Color(0xFF0000FF), size: 16),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${(progress * 100).toInt()}%',
                  style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.black87),
                ),
                Text(
                  daysLeft > 0 ? '$daysLeft Days Left' : 'Completed',
                  style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 10,
                backgroundColor: const Color(0xFFE0E7F5),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF0000FF)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'All Reports',
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        /* GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              Text(
                'Sort by',
                style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF1565C0), fontWeight: FontWeight.w600),
              ),
              SizedBox(width: 4),
              Icon(Icons.filter_list, color: Color(0xFF1565C0), size: 18),
            ],
          ),
        ), */
      ],
    );
  }

  Widget _buildReportCard(Report report) {
    final statusConfig = _statusConfig(report.status);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'REPORT #${report.id}',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0000FF),
                    letterSpacing: 0.4,
                  ),
                ),
                _buildStatusBadge(report.status, statusConfig['bg'] as Color, statusConfig['text'] as Color),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              report.title,
              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black87),
            ),
            const SizedBox(height: 6),
            Text(
              report.description,
              style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700], height: 1.4, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Text(
                    report.date,
                    style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.bold),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(color: const Color(0xFFF3F5F8), borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.download_outlined, color: Colors.black, size: 20),
                  ),
                ),
                const SizedBox(width: 8),
                // View button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0000FF),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    textStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
                    elevation: 0,
                  ),
                  child: Text(
                    'View',
                    style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBadge(String label, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(
        label,
        style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: textColor, letterSpacing: 0.4),
      ),
    );
  }

  Map<String, Color> _statusConfig(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return {'bg': const Color(0xFFFFF3E0), 'text': const Color(0xFFE65100)};
      case 'APPROVED':
        return {'bg': const Color(0xFFE8F5E9), 'text': const Color(0xFF2E7D32)};
      case 'REJECTED':
        return {'bg': const Color(0xFFFFEBEE), 'text': const Color(0xFFC62828)};
      default:
        return {'bg': const Color(0xFFEEEEEE), 'text': Colors.grey};
    }
  }
}
