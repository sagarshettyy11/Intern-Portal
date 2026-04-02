import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/models/guide/guide_internship_model.dart';
import 'package:intern_portal/services/users/guide_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/common_widgets/common_widgets.dart';

class InternshipReviewPage extends StatefulWidget {
  final int internshipId;
  const InternshipReviewPage({super.key, required this.internshipId});
  @override
  State<InternshipReviewPage> createState() => _InternshipReviewPageState();
}

class _InternshipReviewPageState extends State<InternshipReviewPage> {
  InternshipReviewModel? data;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  Future<void> loadDetails() async {
    final res = await GuideServices.fetchRequestDetails(widget.internshipId);
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
    if (data == null) {
      return const Scaffold(body: Center(child: Text("Failed to load data")));
    }
    final d = data!;
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
                          (d.studentName).split(' ').map((e) => e.isNotEmpty ? e[0] : '').take(2).join(),
                          style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF2563EB)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            d.studentName,
                            style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 16, color: Colors.black87),
                          ),
                          Text(
                            "ID: ${d.regNo}",
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Colors.grey[700],
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFFF4F6FB), borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'PROGRAM & YEAR',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.black87,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          d.department,
                          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.grey[800]),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Academic Year: ${d.year}",
                          style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[800], fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.mail_outline, size: 14, color: Colors.grey[800], fontWeight: FontWeight.bold),
                            const SizedBox(width: 6),
                            Text(
                              d.email,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.phone_outlined, size: 14, color: Colors.grey[800]),
                            const SizedBox(width: 6),
                            Text(
                              d.phone,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
                            (d.companyName).substring(0, 1).toUpperCase(),
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w800,
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
                            d.companyName,
                            style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14, color: Colors.black87),
                          ),
                          Text(
                            d.companyIndustry,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 14, color: Colors.grey[800], fontWeight: FontWeight.w800),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'LOCATION',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.3,
                            ),
                          ),
                          Text(
                            d.companyAddress,
                            style: GoogleFonts.inter(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: const Color(0xFFF4F6FB), borderRadius: BorderRadius.circular(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SUPERVISOR CONTACT',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: const Color(0xFF2563EB),
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          d.supervisorName,
                          style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 13, color: Colors.black87),
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.mail_outline, size: 14, color: Colors.grey[800], fontWeight: FontWeight.bold),
                            const SizedBox(width: 6),
                            Text(d.supervisorEmail, style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[800],fontWeight: FontWeight.w700)),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Icon(Icons.phone_outlined, size: 14, color: Colors.grey[800]),
                            const SizedBox(width: 6),
                            Text(d.supervisorPhone, style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[800],fontWeight: FontWeight.w700)),
                          ],
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
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.4,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              d.jobTitle,
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w800,
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
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.4,
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
                              d.workMode,
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFFB7950B),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey[800]),
                      const SizedBox(width: 6),
                      Text(
                        'DURATION',
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${d.startDate} — ${d.endDate} d.duration",
                    style: GoogleFonts.inter(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SectionHeader(icon: Icons.format_list_bulleted, title: 'Job Description'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Text(d.description, style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[800], fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 10),
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
                onPressed: () async {
                  final success = await GuideServices.updateRequestStatus(
                    id: widget.internshipId,
                    action: "reject",
                    feedback: "Reason here",
                  );
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Rejected successfully")));
                    Navigator.pop(context);
                  }
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  side: BorderSide(color: Colors.grey[300]!),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  'Reject Registration',
                  style: GoogleFonts.inter(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  final success = await GuideServices.updateRequestStatus(id: widget.internshipId, action: "approve");
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Approved successfully")));
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 0,
                ),
                child: Text(
                  'Approve Internship',
                  style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14),
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
