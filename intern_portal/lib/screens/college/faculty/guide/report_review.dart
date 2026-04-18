import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/models/guide/guide_report_model.dart';
import 'package:intern_portal/screens/college/faculty/guide/student_report.dart';
import 'package:intern_portal/services/users/guide_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/common_widgets/common_widgets.dart';

class ReportDetailsPage extends StatefulWidget {
  final int reportId;
  const ReportDetailsPage({super.key, required this.reportId});
  @override
  State<ReportDetailsPage> createState() => _ReportDetailsPageState();
}

class _ReportDetailsPageState extends State<ReportDetailsPage> {
  bool isEditing = false;
  final TextEditingController feedbackController = TextEditingController();
  final TextEditingController scoreController = TextEditingController();
  bool isLoading = true;
  ReportDetailsModel? report;
  bool get isEvaluateMode => report!.canEvaluate;
  bool get isEditMode => report!.canEdit && isEditing;
  @override
  void initState() {
    super.initState();
    loadDetails();
  }

  Future<void> loadDetails() async {
    final res = await GuideServices.fetchReportDetails(widget.reportId);
    setState(() {
      report = res;
      isLoading = false;
      feedbackController.text = report?.feedback ?? '';
      scoreController.text = report?.score?.toString() ?? '';
    });
  }

  Future<void> submitEvaluation(String action) async {
    final score = double.tryParse(scoreController.text);
    if (score == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please enter a valid score")));
      return;
    }

    final success = await GuideServices.evaluateReport(
      reportId: widget.reportId,
      action: action,
      score: score,
      feedback: feedbackController.text,
    );
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Evaluation saved successfully")));
      setState(() {
        isEditing = false;
      });
      loadDetails();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (report == null) {
      return const Scaffold(body: Center(child: Text("Failed to load report")));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Student Report Review", showBack: true),
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
                          fontSize: 12,
                          color: Colors.grey[900],
                          fontWeight: FontWeight.w900,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        report!.reportLabel,
                        style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        report!.submittedDate ?? '',
                        style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[800], fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(color: const Color(0xFFB7950B), borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    report!.statusLabel.toUpperCase(),
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
                        report!.studentName,
                        style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14, color: Colors.black87),
                      ),
                      Text(
                        report!.companyName ?? '',
                        style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.w800),
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
                report!.activityDescription ?? "No description",
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.grey[900],
                  height: 1.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SectionHeader(icon: Icons.lightbulb_outline, title: 'Learning Outcomes'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Text(
                report!.learningOutcomes ?? "No learning outcomes",
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.grey[900],
                  height: 1.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SectionHeader(icon: Icons.warning_amber_outlined, title: 'Challenges'),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Text(
                report!.challenges ?? "No challenges",
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: Colors.grey[900],
                  height: 1.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SectionHeader(icon: Icons.attach_file, title: 'Attachments'),
            const SizedBox(height: 12),
            Row(
              children: [
                Row(
                  children: [
                    if (report!.attachmentPath != null)
                      _FileChip(icon: Icons.attach_file, iconColor: Colors.grey, fileName: "Attachment", fileSize: "")
                    else
                      Text("No attachments", style: GoogleFonts.inter(color: Colors.grey)),
                  ],
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
                      (isEvaluateMode || isEditMode)
                          ? SizedBox(
                              width: 90,
                              child: TextField(
                                controller: scoreController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2563EB),
                                ),
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(vertical: 6),
                                  hintText: "0",
                                  suffixText: "/100",
                                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                              ),
                            )
                          : RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: "${report!.score ?? 0}",
                                    style: GoogleFonts.inter(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF2563EB),
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' /100',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
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
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    height: 250,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: (isEvaluateMode || isEditMode)
                        ? TextField(
                            controller: feedbackController,
                            maxLines: null,
                            expands: true,
                            textAlignVertical: TextAlignVertical.top,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Colors.grey[800],
                              height: 1.6,
                              fontWeight: FontWeight.w700,
                            ),
                            decoration: const InputDecoration(hintText: "Enter feedback...", border: InputBorder.none),
                          )
                        : Text(
                            report!.feedback ?? "No feedback provided",
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: Colors.grey[800],
                              height: 1.6,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                            ),
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
          ],
        ),
      ),
      bottomNavigationBar: buildBottomBar(),
    );
  }

  Widget actionContainer({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: Row(children: children),
    );
  }

  ButtonStyle outlinedStyle() {
    return OutlinedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 14),
      side: BorderSide(color: Colors.grey[300]!),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }

  ButtonStyle elevatedStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF2563EB),
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0,
    );
  }

  Widget buildBottomBar() {
    final d = report!;
    if (d.canEvaluate) {
      return actionContainer(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => submitEvaluation("reject"),
              style: outlinedStyle(),
              child: Text(
                'Reject',
                style: GoogleFonts.inter(color: Colors.red, fontWeight: FontWeight.w800, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () => submitEvaluation("approve"),
              style: elevatedStyle(),
              child: Text(
                'Approve',
                style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14),
              ),
            ),
          ),
        ],
      );
    }
    if (d.canEdit) {
      // 👉 editing ON
      if (isEditing) {
        return actionContainer(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => setState(() => isEditing = false),
                style: outlinedStyle(),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(color: Colors.black87, fontWeight: FontWeight.w800, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () => submitEvaluation(d.status.toLowerCase() == "approved" ? "approve" : "reject"),
                style: elevatedStyle(),
                child: Text(
                  'Update Evaluation',
                  style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14),
                ),
              ),
            ),
          ],
        );
      }
      return actionContainer(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: outlinedStyle(),
              child: Text(
                'Back',
                style: GoogleFonts.inter(color: Colors.black87, fontWeight: FontWeight.w800, fontSize: 14),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton(
              onPressed: () => setState(() => isEditing = true),
              style: elevatedStyle(),
              child: Text(
                'Edit Evaluation',
                style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14),
              ),
            ),
          ),
        ],
      );
    }

    // 🔒 3. VIEW ONLY (no edit, no evaluate)
    return actionContainer(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: outlinedStyle(),
            child: Text(
              'Back',
              style: GoogleFonts.inter(color: Colors.black87, fontWeight: FontWeight.w800, fontSize: 14),
            ),
          ),
        ),
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
                Text(fileSize, style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[700])),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
