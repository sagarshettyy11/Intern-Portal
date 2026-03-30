import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/common_widgets/common_widgets.dart';

class ReportDetailsPage extends StatelessWidget {
  const ReportDetailsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Student Report Details", showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'REPORTING PERIOD',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Week 12: System\nIntegration',
                        style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Text('Oct 24 - Oct 30, 2023', style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500])),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: const Color(0xFFB7950B), borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    'PENDING\nREVIEW',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(color: const Color(0xFFF4F6FB), borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      width: 40,
                      height: 40,
                      color: const Color(0xFFD0E8F0),
                      child: Icon(Icons.person, color: Colors.blueGrey[700], size: 24),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Alex Johnston',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87),
                      ),
                      Text(
                        'Junior Software Engineer Intern',
                        style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SectionHeader(icon: Icons.description_outlined, title: 'Activity Description'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Text(
                'This week focused primarily on the final integration of the payment gateway microservice. I spent Monday and Tuesday debugging the webhook listener that handles asynchronous transaction updates. On Wednesday, I collaborated with the QA team to draft a regression testing suite for the checkout flow. Thursday and Friday were dedicated to documentation and peer-reviewing code for the upcoming sprint.',
                style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700], height: 1.6),
              ),
            ),
            const SizedBox(height: 20),
            SectionHeader(icon: Icons.lightbulb_outline, title: 'Learning Outcomes'),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  _OutcomeRow(text: 'Mastered asynchronous webhook handling using Node.js.', isLast: false),
                  _OutcomeRow(
                    text: 'Gained proficiency in writing Unit Tests with Jest for critical flows.',
                    isLast: false,
                  ),
                  _OutcomeRow(text: 'Improved technical writing skills through system documentation.', isLast: true),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SectionHeader(icon: Icons.attach_file, title: 'Attachments'),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _FileChip(
                    icon: Icons.code,
                    iconColor: Colors.grey[600]!,
                    fileName: 'PR-442.log',
                    fileSize: '12 KB',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _FileChip(
                    icon: Icons.image_outlined,
                    iconColor: Colors.grey[600]!,
                    fileName: 'Flow_Diagram.png',
                    fileSize: '1.4 MB',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFF4F6FB), borderRadius: BorderRadius.circular(12)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.assessment_outlined, color: const Color(0xFF2563EB), size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Evaluation',
                            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '85',
                              style: GoogleFonts.inter(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2563EB),
                              ),
                            ),
                            TextSpan(
                              text: ' /100',
                              style: GoogleFonts.inter(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'GUIDE FEEDBACK',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 90,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Text(
                      'Provide constructive feedback for Alex...',
                      style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[400]),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFFFFF8E1), borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline, size: 14, color: Colors.amber[700]),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Feedback will be visible to the student once the report is approved or returned for revision.',
                            style: GoogleFonts.inter(fontSize: 11, color: Colors.amber[800], height: 1.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey[200]!)),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(color: Colors.grey[300]!),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'Return for Revision',
                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                child: const Text(
                  'Save Evaluation',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OutcomeRow extends StatelessWidget {
  final String text;
  final bool isLast;
  const _OutcomeRow({required this.text, required this.isLast});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.check_circle_outline, color: Color(0xFF2563EB), size: 18),
              const SizedBox(width: 10),
              Expanded(
                child: Text(text, style: GoogleFonts.inter(fontSize: 13, color: Colors.black87, height: 1.4)),
              ),
            ],
          ),
        ),
        if (!isLast) Divider(height: 1, color: Colors.grey[100], indent: 14),
      ],
    );
  }
}

class _FileChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String fileName;
  final String fileSize;
  const _FileChip({required this.icon, required this.iconColor, required this.fileName, required this.fileSize});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF4F6FB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(fileSize, style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[500])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
