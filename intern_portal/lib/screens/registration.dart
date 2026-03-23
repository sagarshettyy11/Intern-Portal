import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/widgets/app_bar.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Internship Registration", showBack: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color(0xFFBDD4FF)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Color(0xFF3B6EF0), size: 18),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "You can track approval status in the Requests Status section after submitting.",
                      style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF3B6EF0), height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 22),
            _SectionHeader(icon: Icons.grid_view_rounded, title: "Company Details"),
            SizedBox(height: 14),
            _FieldLabel("COMPANY NAME"),
            _TextField(hint: "e.g. Acme Corp"),
            SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FieldLabel("SELECT CATEGORY"),
                      _DropdownField(hint: "Choose..."),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FieldLabel("INDUSTRY"),
                      _DropdownField(hint: "Choose..."),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 14),
            _FieldLabel("PHONE"),
            _TextField(hint: "+1 (555) 000-0000"),
            SizedBox(height: 14),
            _FieldLabel("ADDRESS"),
            _TextField(hint: "Full office address"),
            SizedBox(height: 14),
            _FieldLabel("COMPANY DESCRIPTION"),
            SizedBox(
              height: 90,
              child: TextField(
                maxLines: null,
                expands: true,
                decoration: InputDecoration(
                  hintText: "Briefly describe what the company does",
                  hintStyle: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13),
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
            ),
            SizedBox(height: 24),
            _SectionHeader(icon: Icons.person_outline_rounded, title: "Industry Guide Details"),
            SizedBox(height: 14),
            _FieldLabel("GUIDE NAME"),
            _TextField(hint: "John Doe"),
            SizedBox(height: 14),
            _FieldLabel("EMAIL ADDRESS"),
            _TextField(hint: "john.doe@company.com"),
            SizedBox(height: 14),
            _FieldLabel("PHONE"),
            _TextField(hint: "+1 (555) 000-0000"),
            SizedBox(height: 24),
            _SectionHeader(icon: Icons.description_outlined, title: "Documentation"),
            SizedBox(height: 14),
            _FieldLabel("OFFER LETTER"),
            Container(
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.cloud_upload_outlined, color: Color(0xFF3B6EF0), size: 36),
                  SizedBox(height: 8),
                  Text(
                    "Click or drag and drop to upload",
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87),
                  ),
                  SizedBox(height: 4),
                  Text("PDF, PNG, JPG (Max 5MB)", style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500])),
                ],
              ),
            ),
            SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      side: BorderSide(color: Colors.grey[400]!),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Text(
                      "Save Draft",
                      style: GoogleFonts.inter(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3B6EF0),
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 0,
                    ),
                    child: Text(
                      "Submit Application",
                      style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
                ),
              ],
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

class _SectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionHeader({required this.icon, required this.title});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Color(0xFF3B6EF0), size: 22),
        SizedBox(width: 8),
        Text(
          title,
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
      ],
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel(this.label);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: Colors.grey[500],
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  final String hint;
  const _TextField({required this.hint});
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13),
        contentPadding: EdgeInsets.symmetric(vertical: 13, horizontal: 14),
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
    );
  }
}

class _DropdownField extends StatelessWidget {
  final String hint;
  const _DropdownField({required this.hint});
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
          Text(hint, style: TextStyle(color: Colors.grey[400], fontSize: 13)),
          Icon(Icons.keyboard_arrow_down, color: Colors.grey[500], size: 20),
        ],
      ),
    );
  }
}
