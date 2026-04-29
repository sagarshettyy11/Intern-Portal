import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

class ReportModel {
  final String reportNumber;
  final String title;
  final String description;
  final String submitted;
  final String status;

  const ReportModel({
    required this.reportNumber,
    required this.title,
    required this.description,
    required this.submitted,
    required this.status,
  });
}

class StudentReviewScreen extends StatefulWidget {
  const StudentReviewScreen({super.key});
  @override
  State<StudentReviewScreen> createState() => _StudentReviewScreenState();
}

class _StudentReviewScreenState extends State<StudentReviewScreen> {
  final List<ReportModel> _reports = const [
    ReportModel(
      reportNumber: 'REPORT #24',
      title: 'Weekly Progress #3',
      description: 'Completed the integration of OAuth2 authentication and started working on the...',
      submitted: 'Submitted: 12 Oct 2023',
      status: 'PENDING',
    ),
    ReportModel(
      reportNumber: 'REPORT #23',
      title: 'Backend API Documentation',
      description: 'Detailed documentation of all REST endpoints including request/response schemas and...',
      submitted: 'Submitted: 05 Oct 2023',
      status: 'APPROVED',
    ),
    ReportModel(
      reportNumber: 'REPORT #22',
      title: 'Weekly Progress #2',
      description: 'Finalized the database schema migrations and implemented the initial CRUD operations for...',
      submitted: 'Submitted: 28 Sep 2023',
      status: 'APPROVED',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F8),
      appBar: CommonAppBar(title: "Guide Workload", showBack: true),
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
            ..._reports.map((r) => Padding(padding: const EdgeInsets.only(bottom: 14), child: _buildReportCard(r))),
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
                    'ACTIVE',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.black54,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Alex Johnson',
              style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('USN: 4SF21CS001', style: GoogleFonts.inter(fontSize: 13, color: Colors.black54)),
                SizedBox(width: 12),
                Text('Batch: 2024', style: GoogleFonts.inter(fontSize: 13, color: Colors.black54)),
              ],
            ),
            const SizedBox(height: 8),
            _buildContactRow(Icons.email_outlined, 'alex.j@university.edu'),
            const SizedBox(height: 4),
            _buildContactRow(Icons.phone_outlined, '+1 (555) 012-3456'),
            const SizedBox(height: 16),
            Divider(color: Colors.grey[200], height: 1),
            const SizedBox(height: 14),
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(color: const Color(0xFFEFF4FF), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.business_outlined, color: Color(0xFF1565C0), size: 20),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'COMPANY',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[500],
                        letterSpacing: 0.6,
                      ),
                    ),
                    Text(
                      'TechCorp Solutions Inc',
                      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF1565C0)),
                    ),
                    Text('01 Feb 2026 - 30 May 2026', style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500])),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ROLE',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[500],
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'FullStack developer',
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
                        'GUIDE',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[500],
                          letterSpacing: 0.6,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Dr. Sarah Miller',
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

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[500]),
        const SizedBox(width: 6),
        Text(text, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700])),
      ],
    );
  }

  Widget _buildStatsRow() {
    final stats = [
      {'label': 'TOTAL', 'value': '24', 'color': const Color(0xFF1565C0)},
      {'label': 'DONE', 'value': '18', 'color': const Color(0xFF2E7D32)},
      {'label': 'PEND', 'value': '04', 'color': const Color(0xFFF57C00)},
      {'label': 'REJ', 'value': '02', 'color': const Color(0xFFC62828)},
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
                      fontWeight: FontWeight.w700,
                      color: Colors.grey[500],
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
                    color: const Color(0xFF1565C0),
                    letterSpacing: 0.6,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(color: const Color(0xFFEFF4FF), borderRadius: BorderRadius.circular(8)),
                  child: const Icon(Icons.calendar_today_outlined, color: Color(0xFF1565C0), size: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '75%',
                  style: GoogleFonts.inter(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                Text(
                  '90 Days Left',
                  style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600], fontWeight: FontWeight.w500),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: 0.75,
                minHeight: 10,
                backgroundColor: const Color(0xFFE0E7F5),
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF1565C0)),
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
        GestureDetector(
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
        ),
      ],
    );
  }

  Widget _buildReportCard(ReportModel report) {
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
                  report.reportNumber,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1565C0),
                    letterSpacing: 0.4,
                  ),
                ),
                _buildStatusBadge(report.status, statusConfig['bg'] as Color, statusConfig['text'] as Color),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              report.title,
              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 6),
            Text(report.description, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600], height: 1.4)),
            const SizedBox(height: 14),
            Divider(color: Colors.grey[200], height: 1),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Text(report.submitted, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500])),
                ),
                // Download button
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(color: const Color(0xFFF3F5F8), borderRadius: BorderRadius.circular(8)),
                    child: Icon(Icons.download_outlined, color: Colors.grey[600], size: 20),
                  ),
                ),
                const SizedBox(width: 8),
                // View button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1565C0),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    textStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
                    elevation: 0,
                  ),
                  child: const Text('View'),
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
    switch (status) {
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
