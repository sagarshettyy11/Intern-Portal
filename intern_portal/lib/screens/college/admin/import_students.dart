import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/services/api_endpoints.dart';
import 'package:intern_portal/services/users/admin_services.dart';
import 'package:intern_portal/services/users/auth_headers.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class ImportStudentsScreen extends StatefulWidget {
  const ImportStudentsScreen({super.key});
  @override
  State<ImportStudentsScreen> createState() => _ImportStudentsScreenState();
}

class _ImportStudentsScreenState extends State<ImportStudentsScreen> {
  bool _fileSelected = false;
  String? _fileName;
  File? _selectedFile;

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'csv'],
    );
    if (result != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
        _fileName = result.files.single.name;
        _fileSelected = true;
      });
    }
  }

  Future<void> _importStudents() async {
    if (_selectedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select a file first.')));
      return;
    }
    try {
      final json = await AdminServices.importStudents(_selectedFile!);
      if (json['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(json['message'] ?? "Import successful"), backgroundColor: const Color(0xFF16A34A)),
        );
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(json['message'] ?? "Import failed")));
      }
    } catch (e) {
      debugPrint("IMPORT ERROR: $e");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }

  Future<void> downloadTemplate() async {
    String csv =
        'Name,Email,Registration No,DOB,Phone,Gender,Department,Batch\n'
        'Rahul Sharma,rahul@college.edu,2021CS101,2002-05-15,9876543210,Male,CSE,2021-2027\n'
        'Priya Nair,priya@college.edu,2021CS102,2002-07-20,9222222222,Female,CSE,2021-2027\n';
    await FileSaver.instance.saveFile(name: "student_import_template.csv", bytes: Uint8List.fromList(csv.codeUnits));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: CommonAppBar(
        showLogo: true,
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircleAvatar(radius: 16, child: Icon(Icons.person, size: 18, color: Colors.black)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header
                      Row(
                        children: [
                          Icon(Icons.person_add_outlined, color: Color(0xFF1A56DB), size: 22),
                          SizedBox(width: 8),
                          Text(
                            'ADMINISTRATION',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF64748B),
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Import Students',
                        style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Bulk upload student records using our standard Excel format.',
                        style: GoogleFonts.inter(fontSize: 14, color: Color(0xFF64748B), height: 1.4),
                      ),
                      const SizedBox(height: 24),
                      GestureDetector(
                        onTap: _pickFile,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 36),
                          decoration: BoxDecoration(
                            color: _fileSelected ? const Color(0xFFEFF6FF) : const Color(0xFFF8FAFC),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: _fileSelected ? const Color(0xFF1A56DB) : const Color(0xFFCBD5E1),
                              width: 1.5,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 52,
                                height: 52,
                                decoration: BoxDecoration(
                                  color: _fileSelected ? const Color(0xFFDBEAFE) : Colors.white,
                                  borderRadius: BorderRadius.circular(14),
                                  boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8)],
                                ),
                                child: Icon(
                                  _fileSelected ? Icons.check_circle_outline : Icons.upload_file_outlined,
                                  color: const Color(0xFF1A56DB),
                                  size: 28,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _fileSelected ? _fileName! : 'Drag & drop student list',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _fileSelected ? const Color(0xFF1A56DB) : const Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                _fileSelected ? 'File ready to import' : 'or click to browse from computer',
                                style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF94A3B8)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: OutlinedButton.icon(
                          onPressed: downloadTemplate,
                          icon: const Icon(Icons.download_outlined, size: 16, color: Color(0xFF1A56DB)),
                          label: Text(
                            'Download Excel Template',
                            style: GoogleFonts.inter(color: Color(0xFF1A56DB), fontWeight: FontWeight.w600),
                          ),
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Color(0xFF1A56DB)),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFFBEB),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: const Color(0xFFFDE68A), width: 1),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.info_outline, color: Color(0xFFD97706), size: 18),
                                SizedBox(width: 8),
                                Text(
                                  'Import Rules & Regulations',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF92400E),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _RuleItem(text: 'Files must be in .xlsx or .xls format only.'),
                            _RuleItem(
                              text: 'Ensure Student ID and Email columns are not empty and follow unique formats.',
                            ),
                            _RuleItem(text: 'Header names must strictly match the provided Excel template.'),
                            _RuleItem(text: 'Maximum batch size per upload is limited to 500 student records.'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _importStudents,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A56DB),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                            elevation: 0,
                          ),
                          child: Text(
                            'Import Students',
                            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: TextButton(
                          onPressed: () => Navigator.pop(context),
                          style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFFF1F5F9),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          ),
                          child: Text(
                            'Cancel',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AdminAppBottomNav(
        currentIndex: 2,
        onTap: (index) => AdminBottomNavController.onItemTapped(context, index),
      ),
    );
  }
}

class _RuleItem extends StatelessWidget {
  final String text;
  const _RuleItem({required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 5),
            child: CircleAvatar(radius: 3.5, backgroundColor: Color(0xFFD97706)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(text, style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF78350F), height: 1.4)),
          ),
        ],
      ),
    );
  }
}
