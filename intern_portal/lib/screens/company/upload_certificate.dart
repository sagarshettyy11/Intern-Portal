import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

class UploadCertificateScreen extends StatefulWidget {
  const UploadCertificateScreen({super.key});

  @override
  State<UploadCertificateScreen> createState() => _UploadCertificateScreenState();
}

class _UploadCertificateScreenState extends State<UploadCertificateScreen> {
  final TextEditingController _serialCtrl = TextEditingController();
  final bool _isDragOver = false;
  String? _fileName;

  @override
  void dispose() {
    _serialCtrl.dispose();
    super.dispose();
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
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: Color(0xFF1A56DB),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFFEF3C7), borderRadius: BorderRadius.circular(20)),
                child: Text(
                  'ACTIVE',
                  style: GoogleFonts.inter(color: Color(0xFFB45309), fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Benjamin Thorne',
            style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 22, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _profileField('DEPARTMENT', 'Digital Product\nDesign')),
              Expanded(child: _profileField('INTERNSHIP ID', 'SF-2024-8842')),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(color: Color(0xFFF3F4F6), thickness: 1),
          const SizedBox(height: 10),
          // Duration
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 16, color: Color(0xFF6B7280)),
              SizedBox(width: 8),
              Text(
                'DURATION',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: Color(0xFF9CA3AF),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.7,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.only(left: 24),
            child: Text(
              'Jan 15, 2024 — Apr 15, 2024',
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
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
          style: GoogleFonts.inter(
            fontSize: 10,
            color: Color(0xFF9CA3AF),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.7,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
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
          style: GoogleFonts.inter(
            fontSize: 11,
            color: Color(0xFF111827),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _serialCtrl,
          style: GoogleFonts.inter(fontSize: 14, color: Color(0xFF111827)),
          decoration: InputDecoration(
            hintText: 'Enter certificate serial number',
            hintStyle: GoogleFonts.inter(color: Color(0xFFD1D5DB), fontSize: 14),
            suffixIcon: const Icon(Icons.fingerprint_rounded, color: Color(0xFF9CA3AF), size: 22),
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
          style: GoogleFonts.inter(
            fontSize: 11,
            color: Color(0xFF111827),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: _pickFile,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            width: double.infinity,
            decoration: BoxDecoration(
              color: _isDragOver ? const Color(0xFFEEF2FF) : const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: _isDragOver ? const Color(0xFF1A56DB) : const Color(0xFFD1D5DB),
                width: 2,
                style: BorderStyle.solid,
              ),
            ),
            padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Upload icon in circle
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8)],
                  ),
                  child: const Icon(Icons.upload_file_outlined, color: Color(0xFF1A56DB), size: 28),
                ),
                const SizedBox(height: 14),
                if (_fileName != null) ...[
                  Text(
                    _fileName!,
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14, color: Color(0xFF1A56DB)),
                  ),
                  const SizedBox(height: 4),
                  Text('File selected', style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF6B7280))),
                ] else ...[
                  Text(
                    'Drop file here',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF111827)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'or click to browse from device',
                    style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF6B7280)),
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
                      Icon(Icons.info_outline, size: 13, color: Color(0xFF9CA3AF)),
                      SizedBox(width: 4),
                      Text(
                        'PDF, JPG UP TO 10MB',
                        style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF6B7280), fontWeight: FontWeight.w500),
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

  void _pickFile() {
    setState(() {
      _fileName = 'certificate_benjamin.pdf';
    });
  }

  Widget _buildUploadButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A56DB),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
        child: Text(
          'Upload Certificate',
          style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
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
          style: GoogleFonts.inter(color: Color(0xFF374151), fontWeight: FontWeight.w600, fontSize: 15),
        ),
      ),
    );
  }
}
