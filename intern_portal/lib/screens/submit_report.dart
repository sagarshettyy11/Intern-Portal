import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class SubmitReportPage extends StatefulWidget {
  const SubmitReportPage({super.key});
  @override
  SubmitReportPageState createState() => SubmitReportPageState();
}

class SubmitReportPageState extends State<SubmitReportPage> {
  final _descController = TextEditingController();
  int _charCount = 0;
  @override
  void initState() {
    super.initState();
    _descController.addListener(() {
      setState(() => _charCount = _descController.text.length);
    });
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
                      _DropdownBox(hint: "Select the type of", hasIcon: true),
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
                            "REPORTING PERIOD",
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
                      _DropdownBox(hint: "October 2023", hasCalendarIcon: true),
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
              controller: _descController,
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
            Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined, color: Color(0xFF3B6EF0), size: 38),
                  SizedBox(height: 8),
                  Text(
                    "Drag and drop files here",
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87),
                  ),
                  SizedBox(height: 4),
                  Text(
                    "or click to browse from your computer",
                    style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500]),
                  ),
                  SizedBox(height: 4),
                  Text("PDF, CSV, PNG (MAX 25MB)", style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[400])),
                ],
              ),
            ),
            SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {},
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

class _DropdownBox extends StatelessWidget {
  final String hint;
  final bool hasIcon;
  final bool hasCalendarIcon;
  const _DropdownBox({required this.hint, this.hasIcon = false, this.hasCalendarIcon = false});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              hint,
              style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          hasCalendarIcon
              ? Icon(Icons.calendar_today_outlined, color: Colors.grey[400], size: 16)
              : Icon(Icons.keyboard_arrow_down, color: Colors.grey[400], size: 20),
        ],
      ),
    );
  }
}
