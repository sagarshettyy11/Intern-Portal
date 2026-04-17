import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/services/users/student_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';
import 'package:intern_portal/widgets/common_widgets/common_widgets.dart';

class SubmitReportPage extends StatefulWidget {
  const SubmitReportPage({super.key});
  @override
  SubmitReportPageState createState() => SubmitReportPageState();
}

class SubmitReportPageState extends State<SubmitReportPage> {
  final descController = TextEditingController();
  final learningController = TextEditingController();
  final challengesController = TextEditingController();
  PlatformFile? selectedFile;
  String? selectedReportType;
  DateTime? startDate;
  DateTime? endDate;
  final List<String> types = ['Daily', 'Weekly', 'Monthly', 'Final', 'Other'];
  @override
  void initState() {
    super.initState();
    descController.addListener(() {});
  }

  @override
  void dispose() {
    descController.dispose();
    learningController.dispose();
    challengesController.dispose();
    super.dispose();
  }

  Future<void> pickStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        startDate = picked;
      });
    }
  }

  Future<void> pickEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: startDate ?? DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        endDate = picked;
      });
    }
  }

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'csv', 'doc', 'docx'],
    );
    if (result != null) {
      final file = result.files.first;
      if (file.size > 25 * 1024 * 1024) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("File too large (Max 25MB)")));
        return;
      }
      setState(() {
        selectedFile = file;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Submit New Report", showBack: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PageHeader(
              title: "Submit New Report",
              subtitle: "Complete the fields below finalize your official reporting documentation.",
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(14),
              decoration: BoxDecoration(color: Color(0xFFEFF4FF), borderRadius: BorderRadius.circular(12)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(color: Color(0xFF3B6EF0), shape: BoxShape.circle),
                    child: Icon(Icons.notifications_outlined, color: Colors.white, size: 18),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Submission Deadline Approaching",
                          style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                        ),
                        SizedBox(height: 4),
                        RichText(
                          text: TextSpan(
                            text: "This report must be filed by ",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.grey[600],
                              height: 1.4,
                              fontWeight: FontWeight.bold,
                            ),
                            children: [
                              TextSpan(
                                text: "October 25th, 2023",
                                style: GoogleFonts.inter(color: Color(0xFF3B6EF0), fontWeight: FontWeight.bold),
                              ),
                              TextSpan(
                                text: ". Late entries are subject to penalty fees.",
                                style: GoogleFonts.inter(color: Colors.grey[600], fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    "View Calendar →",
                    style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF3B6EF0), fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FieldLabel(label: "REPORT TYPE", icon: Icons.work_outline),
                      CustomDropdown(
                        value: selectedReportType,
                        hint: "Select report type",
                        items: types,
                        onChanged: (value) {
                          setState(() {
                            selectedReportType = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: CustomDateField(
                    label: "PERIOD START DATE",
                    icon: Icons.calendar_today_outlined,
                    value: startDate,
                    onTap: pickStartDate,
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: CustomDateField(
                    label: "PERIOD END DATE",
                    icon: Icons.calendar_today_outlined,
                    value: endDate,
                    onTap: pickEndDate,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            FormTextArea(
              label: "DETAILED DESCRIPTION",
              icon: Icons.description_outlined,
              controller: descController,
              hint: "Provide a comprehensive summary...",
            ),
            SizedBox(height: 20),
            FormTextArea(
              label: "LEARNING OUTCOMES",
              icon: Icons.school_outlined,
              controller: learningController,
              hint: "What did you learn?",
            ),
            SizedBox(height: 20),
            FormTextArea(
              label: "CHALLENGES",
              icon: Icons.warning_amber_outlined,
              controller: challengesController,
              hint: "Challenges faced...",
            ),
            SizedBox(height: 20),
            FieldLabel(label: "SUPPORTING ATTACHMENTS", icon: Icons.attach_file),
            FileUploadBox(file: selectedFile, onTap: pickFile),
            SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () async {
                  if (selectedReportType == null || startDate == null || endDate == null) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Please fill all required fields")));
                    return;
                  }
                  if (descController.text.length < 20) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Description must be at least 20 characters")));
                    return;
                  }
                  String format(DateTime d) => d.toString().split(" ")[0];
                  final res = await StudentServices.submitReport(
                    reportType: selectedReportType!,
                    periodStart: format(startDate!),
                    periodEnd: format(endDate!),
                    description: descController.text,
                    learningOutcomes: learningController.text,
                    challenges: challengesController.text,
                    file: selectedFile,
                  );
                  if (res['success'] == true) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text("Report submitted successfully")));
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(res['message'] ?? "Failed")));
                  }
                },
                icon: Icon(Icons.send, color: Colors.white, size: 18),
                label: Text(
                  "Submit Report",
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0000FF),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  elevation: 0,
                ),
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.save_outlined, color: Colors.black87, size: 18),
                label: Text(
                  "Save as Draft",
                  style: GoogleFonts.inter(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey[300]!),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),
            SizedBox(height: 10),
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
