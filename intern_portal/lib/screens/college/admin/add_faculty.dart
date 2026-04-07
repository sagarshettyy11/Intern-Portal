import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

class AddFacultyPage extends StatelessWidget {
  const AddFacultyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Add New Faculty", showBack: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(
                      'New Faculty Member',
                      style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF111827)),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Provide administrative details to register the member and generate secure login credentials.',
                      style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF6B7280), height: 1.5),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Assign Role',
                      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
                    ),
                    const SizedBox(height: 10),
                    const _AddFacultyRoleToggle(),
                    const SizedBox(height: 24),
                    const _AddFacultyFieldLabel('Full Name'),
                    const SizedBox(height: 8),
                    const _AddFacultyTextField(hint: 'e.g. Dr. Robert Wilson'),
                    const SizedBox(height: 16),
                    const _AddFacultyFieldLabel('Academic Email'),
                    const SizedBox(height: 8),
                    const _AddFacultyTextField(hint: 'robert.w@university.edu'),
                    const SizedBox(height: 16),
                    const _AddFacultyFieldLabel('Contact Number'),
                    const SizedBox(height: 8),
                    const _AddFacultyTextField(hint: '+1 (555) 000-0000', keyboardType: TextInputType.phone),
                    const SizedBox(height: 16),
                    const _AddFacultyFieldLabel('Current Designation'),
                    const SizedBox(height: 8),
                    const _AddFacultyTextField(hint: 'e.g. Associate Professor'),
                    const SizedBox(height: 16),
                    const _AddFacultyFieldLabel('Department'),
                    const SizedBox(height: 8),
                    const _AddFacultyDropdown(
                      hint: 'Select Department',
                      items: [
                        'Computer Science Engineering',
                        'Information Science Engineering',
                        'Mechanical Engineering',
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF6FF),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.info_outline, size: 18, color: Color(0xFF1A56DB)),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Once added, a welcome email with secure login credentials will be sent to the academic email address provided above.',
                              style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF1E40AF), height: 1.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A56DB),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person_add_outlined, color: Colors.white, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Add Faculty & Generate Login',
                            style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.inter(color: Color(0xFF374151), fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddFacultyFieldLabel extends StatelessWidget {
  final String text;
  const _AddFacultyFieldLabel(this.text);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
    );
  }
}

class _AddFacultyTextField extends StatelessWidget {
  final String hint;
  final TextInputType? keyboardType;
  const _AddFacultyTextField({required this.hint, this.keyboardType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyboardType,
      style: GoogleFonts.inter(fontSize: 14, color: Color(0xFF111827)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(color: Color(0xFFB0B8C9), fontSize: 14),
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

class _AddFacultyRoleToggle extends StatefulWidget {
  const _AddFacultyRoleToggle();
  @override
  State<_AddFacultyRoleToggle> createState() => _AddFacultyRoleToggleState();
}

class _AddFacultyRoleToggleState extends State<_AddFacultyRoleToggle> {
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
                            // FIX: replaced deprecated withOpacity with withValues
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

class _AddFacultyDropdown extends StatefulWidget {
  final String hint;
  final List<String> items;
  const _AddFacultyDropdown({required this.hint, required this.items});
  @override
  State<_AddFacultyDropdown> createState() => _AddFacultyDropdownState();
}

class _AddFacultyDropdownState extends State<_AddFacultyDropdown> {
  String? _selected;
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
