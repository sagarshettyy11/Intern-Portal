import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/common_widgets/common_widgets.dart';

class InternshipReviewPage extends StatelessWidget {
  const InternshipReviewPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Student Internship Review", showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(icon: Icons.person_outline, title: 'Student Profile'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: const Color(0xFFEFF6FF),
                        child: Text(
                          'JD',
                          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF2563EB)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Johnnathan Doe',
                            style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                          ),
                          Text('ID: STU-2024-0891', style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500])),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFFF4F6FB), borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PROGRAM & YEAR',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'B.S. Computer Science',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87),
                        ),
                        Text(
                          'Academic Year: 2023-2024',
                          style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.mail_outline, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 6),
                      Text(
                        'johnnathan.doe@university.edu',
                        style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.phone_outlined, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 6),
                      Text('+1 (555) 234-5678', style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600])),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SectionHeader(icon: Icons.business_outlined, title: 'Company Details'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F6FB),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            'T',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xFF2563EB),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'TechVision Systems Inc.',
                            style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                          ),
                          Text(
                            'Software Development & AI Solutions',
                            style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOCATION',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                          Text(
                            'Palo Alto, California, USA',
                            style: GoogleFonts.inter(fontSize: 13, color: Colors.black87),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFFF4F6FB), borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SUPERVISOR CONTACT',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: const Color(0xFF2563EB),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Sarah Mitchell',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87),
                        ),
                        Text(
                          'Engineering Manager | s.mitchell@techvision.com',
                          style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SectionHeader(icon: Icons.work_outline, title: 'Role Specifications'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'JOB TITLE',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Backend Intern',
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WORK MODE',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: Colors.grey[500],
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.3,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF8E1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Hybrid',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFFB7950B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 6),
                      Text(
                        'DURATION',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Jun 01, 2024 — Aug 31, 2024 (12 Weeks)',
                    style: GoogleFonts.inter(fontSize: 13, color: Colors.black87),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SectionHeader(icon: Icons.format_list_bulleted, title: 'Job Description'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Text(
                'As a Backend Engineering Intern, the candidate will be responsible for assisting the core platform team in developing scalable microservices using Go and Node.js. Key responsibilities include optimizing database queries for PostgreSQL, implementing RESTful API endpoints, and contributing to the containerization strategy using Docker. The intern will participate in daily stand-ups and bi-weekly sprint planning sessions.',
                style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700], height: 1.6),
              ),
            ),
            const SizedBox(height: 20),
            SectionHeader(icon: Icons.attach_file, title: 'Attachments'),
            const SizedBox(height: 12),
            _AttachmentRow(
              icon: Icons.picture_as_pdf_outlined,
              iconColor: Colors.red,
              fileName: 'Internship_Offer_Letter.pdf',
              trailingIcon: Icons.download_outlined,
            ),
            const SizedBox(height: 8),
            _AttachmentRow(
              icon: Icons.description_outlined,
              iconColor: const Color(0xFF2563EB),
              fileName: 'NOC_Form_Signed.pdf',
              trailingIcon: Icons.download_outlined,
            ),
            const SizedBox(height: 8),
            _AttachmentRow(
              icon: Icons.link,
              iconColor: Colors.teal,
              fileName: 'Portfolio_Link.web',
              trailingIcon: Icons.open_in_new,
            ),
            const SizedBox(height: 20),
            SectionHeader(icon: Icons.history, title: 'Audit Trail'),
            const SizedBox(height: 12),
            _AuditRow(
              dotColor: const Color(0xFF2563EB),
              title: 'Internship Registered',
              date: 'May 12, 2024 • 10:45 AM',
              sub: 'Submitted by Johnnathan Doe',
              isLast: false,
            ),
            _AuditRow(
              dotColor: Colors.grey,
              title: 'Pending Faculty Approval',
              date: 'May 13, 2024 • 09:15 AM',
              sub: '',
              isLast: true,
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
                child: Text(
                  'Reject Registration',
                  style: GoogleFonts.inter(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 14),
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
                child: Text(
                  'Approve Internship',
                  style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AttachmentRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String fileName;
  final IconData trailingIcon;
  const _AttachmentRow({
    required this.icon,
    required this.iconColor,
    required this.fileName,
    required this.trailingIcon,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 18),
          const SizedBox(width: 10),
          Expanded(
            child: Text(fileName, style: GoogleFonts.inter(fontSize: 13, color: Colors.black87)),
          ),
          Icon(trailingIcon, color: Colors.grey[400], size: 18),
        ],
      ),
    );
  }
}

class _AuditRow extends StatelessWidget {
  final Color dotColor;
  final String title;
  final String date;
  final String sub;
  final bool isLast;
  const _AuditRow({
    required this.dotColor,
    required this.title,
    required this.date,
    required this.sub,
    required this.isLast,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 20,
          child: Column(
            children: [
              Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
              ),
              if (!isLast) Container(width: 2, height: 48, color: Colors.grey[200]),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87),
                ),
                const SizedBox(height: 2),
                Text(date, style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[400])),
                if (sub.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(sub, style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[500])),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}
