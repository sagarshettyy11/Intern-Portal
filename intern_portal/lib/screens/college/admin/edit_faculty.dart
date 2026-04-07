import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

class EditFacultyPage extends StatelessWidget {
  const EditFacultyPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: CommonAppBar(title: "Edit Faculty Details", showBack: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(color: const Color(0xFF374151), borderRadius: BorderRadius.circular(18)),
                    child: ClipRRect(borderRadius: BorderRadius.circular(18)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: Color(0xFF1A56DB), shape: BoxShape.circle),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 14),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'EDITING FACULTY MEMBER',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9CA3AF),
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Dr. Sarah Jenkins',
              style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF111827)),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'ROLE ASSIGNMENT',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF9CA3AF),
                          letterSpacing: 1.1,
                        ),
                      ),
                      Icon(Icons.info_outline, size: 18, color: Color(0xFF1A56DB)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const _EditFacultyRoleToggle(),
                  const SizedBox(height: 24),
                  _EditFacultyFieldLabel(
                    'Full Name',
                    leading: const Icon(Icons.person_outline, size: 16, color: Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 8),
                  _EditFacultyTextField(
                    hint: 'Full Name',
                    controller: TextEditingController(text: 'Dr. Sarah Jenkins'),
                  ),
                  const SizedBox(height: 16),
                  _EditFacultyFieldLabel(
                    'Email Address',
                    leading: const Icon(Icons.mail_outline, size: 16, color: Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 8),
                  _EditFacultyTextField(
                    hint: 'Email',
                    controller: TextEditingController(text: 's.jenkins@scholarflow.edu'),
                    readOnly: true,
                    suffix: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Icon(Icons.lock_outline, size: 18, color: Color(0xFF9CA3AF)),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Email cannot be changed after registration.',
                    style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF)),
                  ),
                  const SizedBox(height: 16),
                  _EditFacultyFieldLabel(
                    'Contact Number',
                    leading: const Icon(Icons.phone_outlined, size: 16, color: Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 8),
                  _EditFacultyTextField(
                    hint: 'Contact Number',
                    controller: TextEditingController(text: '+1 (555) 012-3456'),
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  _EditFacultyFieldLabel(
                    'Designation',
                    leading: const Icon(Icons.badge_outlined, size: 16, color: Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 8),
                  _EditFacultyTextField(
                    hint: 'Designation',
                    controller: TextEditingController(text: 'Senior Professor'),
                  ),
                  const SizedBox(height: 16),
                  _EditFacultyFieldLabel(
                    'Department',
                    leading: const Icon(Icons.grid_view_rounded, size: 16, color: Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 8),
                  const _EditFacultyDropdown(
                    hint: 'Select Department',
                    value: 'Computer Science & Engineering',
                    items: [
                      'Computer Science & Engineering',
                      'Information Science Engineering',
                      'Mechanical Engineering',
                    ],
                  ),
                  const SizedBox(height: 16),
                  _EditFacultyFieldLabel(
                    'Employment Status',
                    leading: const Icon(Icons.circle_outlined, size: 16, color: Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 8),
                  const _EditFacultyDropdown(hint: 'Select Status', value: 'Active', items: ['Active', 'Inactive']),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  side: const BorderSide(color: Color(0xFFD1D5DB)),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  backgroundColor: const Color(0xFFF9FAFB),
                ),
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(color: Color(0xFF374151), fontWeight: FontWeight.w600, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              flex: 3,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A56DB),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
                child: Text(
                  'Save Changes',
                  style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EditFacultyFieldLabel extends StatelessWidget {
  final String text;
  final Widget? leading;
  const _EditFacultyFieldLabel(this.text, {this.leading});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (leading != null) ...[leading!, const SizedBox(width: 6)],
        Text(
          text,
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
        ),
      ],
    );
  }
}

class _EditFacultyTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final bool readOnly;
  final Widget? suffix;
  final TextInputType? keyboardType;
  const _EditFacultyTextField({
    required this.hint,
    this.controller,
    this.readOnly = false,
    this.suffix,
    this.keyboardType,
  });
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: Color(0xFFB0B8C9), fontSize: 14),
        suffixIcon: suffix,
        filled: true,
        fillColor: const Color(0xFFF3F5F9),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF1A56DB), width: 1.5),
        ),
      ),
    );
  }
}

class _EditFacultyRoleToggle extends StatefulWidget {
  const _EditFacultyRoleToggle();
  @override
  State<_EditFacultyRoleToggle> createState() => _EditFacultyRoleToggleState();
}

class _EditFacultyRoleToggleState extends State<_EditFacultyRoleToggle> {
  int _selected = 0;
  final List<String> _labels = const ['GUIDE', 'HOD'];
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF3F5F9), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: List.generate(2, (i) {
          final isSelected = _selected == i;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selected = i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                child: Text(
                  _labels[i],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? const Color(0xFF1A56DB) : const Color(0xFF9CA3AF),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _EditFacultyDropdown extends StatefulWidget {
  final String hint;
  final String? value;
  final List<String> items;
  const _EditFacultyDropdown({required this.hint, this.value, required this.items});
  @override
  State<_EditFacultyDropdown> createState() => _EditFacultyDropdownState();
}

class _EditFacultyDropdownState extends State<_EditFacultyDropdown> {
  String? _selected;
  @override
  void initState() {
    super.initState();
    _selected = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF3F5F9), borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selected,
          hint: Text(widget.hint, style: GoogleFonts.inter(color: Color(0xFF9CA3AF), fontSize: 14)),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF6B7280)),
          items: widget.items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(e, style: GoogleFonts.inter(fontSize: 14, color: Color(0xFF111827))),
                ),
              )
              .toList(),
          onChanged: (v) => setState(() => _selected = v),
        ),
      ),
    );
  }
}
