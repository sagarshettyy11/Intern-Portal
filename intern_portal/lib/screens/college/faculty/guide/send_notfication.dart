import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:intern_portal/models/guide/guide_notification_model.dart';
import 'package:intern_portal/services/users/guide_services.dart';

class SendNotificationPage extends StatefulWidget {
  const SendNotificationPage({super.key});
  @override
  State<SendNotificationPage> createState() => _SendNotificationPageState();
}

class _SendNotificationPageState extends State<SendNotificationPage> {
  final TextEditingController _messageController = TextEditingController();
  int _charCount = 0;
  StudentModel? _selectedStudent;
  List<StudentModel> students = [];
  File? selectedFile;
  bool isLoadingStudents = true;
  bool isSending = false;

  @override
  void initState() {
    super.initState();
    loadStudents();
    _messageController.addListener(() {
      setState(() {
        _charCount = _messageController.text.length;
      });
    });
  }

  Future<void> loadStudents() async {
    final response = await GuideServices.fetchNotifications();
    if (response != null) {
      setState(() {
        students = response.myStudents;
        isLoadingStudents = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Send Notifications", showBack: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildHeader(),
                    const SizedBox(height: 28),
                    _buildSelectStudentSection(),
                    const SizedBox(height: 28),
                    _buildMessageContentSection(),
                    const SizedBox(height: 28),
                    _buildAttachmentsSection(),
                    const SizedBox(height: 32),
                    _buildSendButton(),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Send Notification',
          style: GoogleFonts.inter(color: Color(0xFF111827), fontSize: 28, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 2),
        Text(
          'Direct message a student regarding their internship placement or status.',
          style: GoogleFonts.inter(color: Color(0xFF6B7280), fontSize: 14, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildSelectStudentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.school, color: Color(0xFF1A56DB), size: 20),
            SizedBox(width: 8),
            Text(
              'Select Student',
              style: GoogleFonts.inter(color: Color(0xFF111827), fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD1D5DB)),
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<StudentModel>(
              value: _selectedStudent,
              isExpanded: true,
              hint: Text('Choose a student...', style: GoogleFonts.inter(color: Color(0xFF9CA3AF), fontSize: 15)),
              icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF374151)),
              items: students.map((student) {
                return DropdownMenuItem<StudentModel>(
                  value: student,
                  child: Text(student.name, style: GoogleFonts.inter(color: const Color(0xFF111827), fontSize: 15)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedStudent = value;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMessageContentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.chat, color: Color(0xFF1A56DB), size: 20),
            SizedBox(width: 8),
            Text(
              'Message Content',
              style: GoogleFonts.inter(color: Color(0xFF111827), fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFD1D5DB)),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              TextField(
                controller: _messageController,
                maxLines: 8,
                maxLength: 2000,
                decoration: InputDecoration(
                  hintText: 'Write your message here...',
                  hintStyle: GoogleFonts.inter(color: Color(0xFFD1D5DB), fontSize: 15),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                  counterText: '',
                ),
                style: GoogleFonts.inter(color: Color(0xFF111827), fontSize: 15),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                  color: Color(0xFFF9FAFB),
                  border: Border(top: BorderSide(color: Color(0xFFE5E7EB))),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Markdown supported', style: GoogleFonts.inter(color: Color(0xFF9CA3AF), fontSize: 12)),
                    Text('$_charCount / 2000', style: GoogleFonts.inter(color: Color(0xFF9CA3AF), fontSize: 12)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAttachmentsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.attach_file, color: Color(0xFF1A56DB), size: 20),
            SizedBox(width: 8),
            Text(
              'Attachments',
              style: GoogleFonts.inter(color: Color(0xFF111827), fontSize: 16, fontWeight: FontWeight.w700),
            ),
          ],
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: _pickFile,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 28),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFB),
              border: Border.all(color: const Color(0xFFD1D5DB), style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Color(0x1A000000), blurRadius: 4, offset: Offset(0, 2))],
                  ),
                  child: const Icon(Icons.cloud_upload_outlined, color: Color(0xFF1A56DB), size: 24),
                ),
                const SizedBox(height: 12),
                Text(
                  'Click to upload or drag and drop',
                  style: GoogleFonts.inter(color: Color(0xFF111827), fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text('PDF, DOCX, or PNG (Max 10MB)', style: GoogleFonts.inter(color: Color(0xFF9CA3AF), fontSize: 12)),
              ],
            ),
          ),
        ),
        // Attached file
        if (selectedFile != null) ...[
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                const Icon(Icons.description, color: Color(0xFF1A56DB), size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        selectedFile!.path.split('/').last,
                        style: GoogleFonts.inter(
                          color: const Color(0xFF111827),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "${(selectedFile!.lengthSync() / 1024).toStringAsFixed(1)} KB • Ready to send",
                        style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 12),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedFile = null;
                    });
                  },
                  child: const Icon(Icons.close, color: Color(0xFFEF4444), size: 20),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSendButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: _sendNotification,
        icon: const Icon(Icons.send, color: Colors.white, size: 20),
        label: Text(
          'Send Notification',
          style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1A56DB),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          elevation: 0,
        ),
      ),
    );
  }


  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.single.path != null) {
      setState(() {
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _sendNotification() async {
  if (_selectedStudent == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please select a student'),
      ),
    );
    return;
  }

  if (_messageController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please write a message'),
      ),
    );
    return;
  }

  setState(() {
    isSending = true;
  });

  bool success;

  if (selectedFile != null) {
    success =
        await GuideServices.sendNotificationWithAttachment(
      studentId: _selectedStudent!.studentId,
      description: _messageController.text.trim(),
      file: selectedFile!,
    );
  } else {
    success = await GuideServices.sendNotification(
      studentId: _selectedStudent!.studentId,
      description: _messageController.text.trim(),
    );
  }

  setState(() {
    isSending = false;
  });

  if (success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Notification sent to ${_selectedStudent!.name}',
        ),
        backgroundColor: const Color(0xFF1A56DB),
      ),
    );

    Navigator.pop(context, true);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Failed to send notification'),
      ),
    );
  }
}
}
