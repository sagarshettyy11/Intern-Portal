import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

class EditStudentDetailsScreen extends StatefulWidget {
  const EditStudentDetailsScreen({super.key});
  @override
  State<EditStudentDetailsScreen> createState() => _EditStudentDetailsScreenState();
}

class _EditStudentDetailsScreenState extends State<EditStudentDetailsScreen> {
  final TextEditingController _fullNameController = TextEditingController(text: 'Rakesh');
  final TextEditingController _studentIdController = TextEditingController(text: 'SF-2024-0892');
  final TextEditingController _emailController = TextEditingController(text: 'rakesh.v@scholarflow.edu');
  final TextEditingController _phoneController = TextEditingController(text: '+91 98765 43210');
  String _selectedMajor = 'Information Technology';
  final List<String> _majors = [
    'Information Technology',
    'Computer Science',
    'Bio-Engineering',
    'Economics',
    'Business Administration',
    'Electrical Engineering',
  ];

  @override
  void dispose() {
    _fullNameController.dispose();
    _studentIdController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: CommonAppBar(title: "Edit Student", showBack: true),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EDITING PROFILE',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A56DB),
                            letterSpacing: 1.1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Student Details',
                          style: GoogleFonts.inter(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 28),
                        Center(child: _AvatarPicker()),
                        const SizedBox(height: 32),
                        _EditFieldLabel(label: 'Full Name'),
                        const SizedBox(height: 8),
                        _ProfileTextField(
                          controller: _fullNameController,
                          prefixIcon: Icons.person_outline,
                          readOnly: false,
                        ),
                        const SizedBox(height: 18),
                        _EditFieldLabel(label: 'Student ID'),
                        const SizedBox(height: 8),
                        _ProfileTextField(
                          controller: _studentIdController,
                          prefixIcon: Icons.badge_outlined,
                          readOnly: true,
                        ),
                        const SizedBox(height: 18),
                        _EditFieldLabel(label: 'Email Address'),
                        const SizedBox(height: 8),
                        _ProfileTextField(
                          controller: _emailController,
                          prefixIcon: Icons.email_outlined,
                          readOnly: false,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 18),
                        _EditFieldLabel(label: 'Primary Major'),
                        const SizedBox(height: 8),
                        _MajorDropdown(
                          value: _selectedMajor,
                          items: _majors,
                          onChanged: (v) {
                            if (v != null) {
                              setState(() => _selectedMajor = v);
                            }
                          },
                        ),
                        const SizedBox(height: 18),
                        _EditFieldLabel(label: 'Phone Number'),
                        const SizedBox(height: 8),
                        _ProfileTextField(
                          controller: _phoneController,
                          prefixIcon: Icons.phone_outlined,
                          readOnly: false,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 24),
                        _InternshipStatusCard(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A56DB),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: Text(
                      'Save Changes',
                      style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => Navigator.maybePop(context),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF1A56DB)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AvatarPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 110,
          height: 110,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFBFDBFE), width: 3),
          ),
          child: ClipOval(
            child: Container(
              color: const Color(0xFFCBD5E1),
              child: const Icon(Icons.person, size: 60, color: Colors.white),
            ),
          ),
        ),
        Positioned(
          bottom: 4,
          right: 4,
          child: Container(
            width: 30,
            height: 30,
            decoration: const BoxDecoration(color: Color(0xFF1A56DB), shape: BoxShape.circle),
            child: const Icon(Icons.edit, color: Colors.white, size: 15),
          ),
        ),
      ],
    );
  }
}

class _EditFieldLabel extends StatelessWidget {
  final String label;
  const _EditFieldLabel({required this.label});
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.inter(fontSize: 13.5, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
    );
  }
}

class _ProfileTextField extends StatelessWidget {
  final TextEditingController controller;
  final IconData prefixIcon;
  final bool readOnly;
  final TextInputType? keyboardType;
  const _ProfileTextField({
    required this.controller,
    required this.prefixIcon,
    required this.readOnly,
    this.keyboardType,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B)),
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: const Color(0xFF94A3B8), size: 20),
        filled: true,
        fillColor: readOnly ? const Color(0xFFF8FAFC) : Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF1A56DB), width: 1.5),
        ),
      ),
    );
  }
}

class _MajorDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const _MajorDropdown({required this.value, required this.items, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          const Icon(Icons.school_outlined, color: Color(0xFF94A3B8), size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF64748B)),
                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B)),
                items: items.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InternshipStatusCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(14)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(9)),
            child: const Icon(Icons.work_outline_rounded, color: Color(0xFF1A56DB), size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Internship Status',
                  style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'IN PROGRESS',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF92400E),
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Started Jan 2024',
                      style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF64748B), fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
