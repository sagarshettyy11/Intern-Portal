import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/models/company/certificate_model.dart';
import 'package:intern_portal/services/users/company_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

class UploadCertificateScreen extends StatefulWidget {
  final CertificateModel record;

  const UploadCertificateScreen({super.key, required this.record});
  @override
  State<UploadCertificateScreen> createState() => _UploadCertificateScreenState();
}

class _UploadCertificateScreenState extends State<UploadCertificateScreen> {
  final TextEditingController _serialCtrl = TextEditingController();
  final bool _isDragOver = false;
  File? _selectedFile;
  String? _fileName;

  @override
  void dispose() {
    _serialCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
        allowMultiple: false,
        withData: false,
      );
      if (result != null && result.files.isNotEmpty) {
        final pickedFile = result.files.first;
        debugPrint("Picked file name: ${pickedFile.name}");
        debugPrint("Picked file path: ${pickedFile.path}");
        if (pickedFile.path != null) {
          final file = File(pickedFile.path!);
          setState(() {
            _selectedFile = file;
            _fileName = pickedFile.name;
          });
        } else {
          debugPrint("File path is null");
        }
      } else {
        debugPrint("User cancelled picker");
      }
    } catch (e) {
      debugPrint("File picker error: $e");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unable to pick file: $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: CommonAppBar(title: "Upload Certificate", showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          children: [
            _buildStudentProfileCard(),
            const SizedBox(height: 20),
            _buildVerificationIdField(),
            const SizedBox(height: 20),
            _buildDocumentUploadArea(),
            const SizedBox(height: 28),
            _buildUploadButton(),
            const SizedBox(height: 12),
            _buildCancelButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentProfileCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'STUDENT PROFILE',
                style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF0000FF), fontWeight: FontWeight.w800),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'ACTIVE',
                  style: GoogleFonts.inter(color: Color(0xFFB45309), fontSize: 11, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          Text(
            widget.record.studentName,
            style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 22, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(child: _profileField('DEPARTMENT', 'Digital Product\nDesign')),
              Expanded(child: _profileField('INTERNSHIP ID', widget.record.internshipId.toString())),
            ],
          ),
          const Divider(color: Color(0xFFF3F4F6), thickness: 1),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 16, color: Colors.grey[800]),
              SizedBox(width: 8),
              Text(
                'DURATION',
                style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[800], fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.only(left: 24),
            child: Text(
              'Jan 15,2024 — Apr 15,2024',
              style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: Color(0xFF111827)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileField(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[700], fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF111827)),
        ),
      ],
    );
  }

  Widget _buildVerificationIdField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'VERIFICATION ID',
          style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF111827), fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4),
        TextField(
          controller: _serialCtrl,
          style: GoogleFonts.inter(fontSize: 14, color: Color(0xFF111827)),
          decoration: InputDecoration(
            hintText: 'Enter certificate serial number',
            hintStyle: GoogleFonts.inter(color: Colors.grey[700], fontSize: 14),
            suffixIcon: Icon(Icons.fingerprint_rounded, color: Colors.grey[700], size: 22),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF1A56DB), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDocumentUploadArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DOCUMENT UPLOAD',
          style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF111827), fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4),
        GestureDetector(
          onTap: _pickFile,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: double.infinity,
            decoration: BoxDecoration(
              color: _isDragOver ? const Color(0xFFEEF2FF) : const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _isDragOver ? const Color(0xFF0000FF) : const Color(0xFFD1D5DB),
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8)],
                  ),
                  child: const Icon(Icons.upload_file_outlined, color: Color(0xFF0000FF), size: 28),
                ),
                const SizedBox(height: 14),
                if (_selectedFile != null &&
                    (_fileName!.endsWith('.jpg') || _fileName!.endsWith('.jpeg') || _fileName!.endsWith('.png'))) ...[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.file(_selectedFile!, height: 100, fit: BoxFit.cover),
                  ),
                ] else ...[
                  Text(
                    'Drop file here',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF111827)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'or click to browse from device',
                    style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[700], fontWeight: FontWeight.w800),
                  ),
                ],
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.info_outline, size: 13, color: Colors.grey[800]),
                      SizedBox(width: 4),
                      Text(
                        'PDF, JPG UP TO 10MB',
                        style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[800], fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUploadButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (_selectedFile == null) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please select a file")));
            return;
          }
          final success = await CompanyService.uploadCertificate(
            internshipId: widget.record.internshipId,
            studentId: widget.record.studentId,
            file: _selectedFile!,
            verificationId: _serialCtrl.text,
          );
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Upload successful")));
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Upload failed")));
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A56DB),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: Text(
          'Upload Certificate',
          style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildCancelButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () => Navigator.of(context).maybePop(),
        child: Text(
          'Cancel',
          style: GoogleFonts.inter(color: Colors.grey[800], fontWeight: FontWeight.w800, fontSize: 16),
        ),
      ),
    );
  }
}
