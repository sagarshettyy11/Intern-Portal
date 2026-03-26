import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/services/users/student_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

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
  int _charCount = 0;
  final List<String> types = ['Daily', 'Weekly', 'Monthly', 'Final', 'Other'];
  @override
  void initState() {
    super.initState();
    descController.addListener(() {
      setState(() => _charCount = descController.text.length);
    });
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
    FilePickerResult? result = await FilePicker.platform.pickFiles(
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
            Text(
              "Submit New Report",
              style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 6),
            Text(
              "Complete the fields below finalize your official\nreporting documentation.",
              style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[500], height: 1.5),
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
                            style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600], height: 1.4),
                            children: [
                              TextSpan(
                                text: "October 25th, 2023",
                                style: GoogleFonts.inter(color: Color(0xFF3B6EF0), fontWeight: FontWeight.w600),
                              ),
                              TextSpan(text: ". Late entries are subject to penalty fees."),
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
                      Row(
                        children: [
                          Icon(Icons.work_outline, size: 14, color: Colors.grey[600]),
                          SizedBox(width: 4),
                          Text(
                            "REPORT TYPE",
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[500],
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        isExpanded: true,
                        initialValue: selectedReportType,
                        items: types.map((type) {
                          return DropdownMenuItem(value: type, child: Text(type));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedReportType = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Select report type",
                          contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        icon: Icon(Icons.keyboard_arrow_down),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey[600]),
                          SizedBox(width: 4),
                          Text(
                            "PERIOD START DATE",
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[500],
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: pickStartDate,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey[600]),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  startDate != null ? startDate.toString().split(" ")[0] : "Select date",
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: startDate == null ? Colors.grey : Colors.black,
                                  ),
                                ),
                              ),
                              Icon(Icons.calendar_today_outlined, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.calendar_today_outlined, size: 14, color: Colors.grey[600]),
                          SizedBox(width: 4),
                          Text(
                            "PERIOD END DATE",
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Colors.grey[500],
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: pickEndDate,
                        child: Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[300]!),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey[600]),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  endDate != null ? endDate.toString().split(" ")[0] : "Select date",
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    color: endDate == null ? Colors.grey : Colors.black,
                                  ),
                                ),
                              ),
                              Icon(Icons.calendar_today_outlined, color: Colors.grey),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.description_outlined, size: 14, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      "DETAILED DESCRIPTION",
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[500],
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Text("$_charCount / 2000", style: TextStyle(fontSize: 11, color: Colors.grey[400])),
              ],
            ),
            SizedBox(height: 8),
            TextField(
              controller: descController,
              maxLines: 6,
              maxLength: 2000,
              buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
              decoration: InputDecoration(
                hintText: "Provide a comprehensive summary of findings, data points, and recommendations...",
                hintStyle: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13, height: 1.5),
                contentPadding: EdgeInsets.all(14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF3B6EF0)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.description_outlined, size: 14, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      "LEARNING OUTCOMES",
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[500],
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Text("$_charCount / 2000", style: TextStyle(fontSize: 11, color: Colors.grey[400])),
              ],
            ),
            SizedBox(height: 8),
            TextField(
              controller: learningController,
              maxLines: 6,
              maxLength: 2000,
              buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
              decoration: InputDecoration(
                hintText: "Provide a comprehensive summary of findings, data points, and recommendations...",
                hintStyle: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13, height: 1.5),
                contentPadding: EdgeInsets.all(14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF3B6EF0)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.description_outlined, size: 14, color: Colors.grey[600]),
                    SizedBox(width: 4),
                    Text(
                      "CHALLENGES",
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[500],
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
                Text("$_charCount / 2000", style: TextStyle(fontSize: 11, color: Colors.grey[400])),
              ],
            ),
            SizedBox(height: 8),
            TextField(
              controller: challengesController,
              maxLines: 6,
              maxLength: 2000,
              buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null,
              decoration: InputDecoration(
                hintText: "Provide a comprehensive summary of findings, data points, and recommendations...",
                hintStyle: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13, height: 1.5),
                contentPadding: EdgeInsets.all(14),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFF3B6EF0)),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.description_outlined, size: 14, color: Colors.grey[600]),
                SizedBox(width: 4),
                Text(
                  "SUPPORTING ATTACHMENTS",
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[500],
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            GestureDetector(
              onTap: pickFile,
              child: Container(
                height: 140,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.cloud_upload_outlined, color: Color(0xFF3B6EF0), size: 38),
                    SizedBox(height: 8),
                    Text(
                      selectedFile != null ? selectedFile!.name : "Click to upload file",
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87),
                    ),
                    SizedBox(height: 4),
                    Text(
                      selectedFile != null
                          ? "${(selectedFile!.size / 1024).toStringAsFixed(2)} KB"
                          : "PDF, CSV, PNG (MAX 25MB)",
                      style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ),
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
                  backgroundColor: Color(0xFF3B6EF0),
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
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 1,
        onTap: (index) => BottomNavController.onItemTapped(context, index),
      ),
    );
  }
}