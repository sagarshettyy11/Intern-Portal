import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});
  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _regNoController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _batchController = TextEditingController(text: 'Fall 2024');
  String? _selectedDepartment;
  String _selectedGender = 'Male';
  DateTime? _dob;

  final List<String> _departments = [
    'Computer Science',
    'Information Technology',
    'Bio-Engineering',
    'Economics',
    'Business Administration',
    'Electrical Engineering',
  ];

  final List<String> _genders = ['Male', 'Female', 'Other'];
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2002),
      firstDate: DateTime(1985),
      lastDate: DateTime(2010),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(colorScheme: const ColorScheme.light(primary: Color(0xFF1A56DB))),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _dob = picked);
  }

  String get _dobDisplay {
    if (_dob == null) return 'mm/dd/yyyy';
    final m = _dob!.month.toString().padLeft(2, '0');
    final d = _dob!.day.toString().padLeft(2, '0');
    return '$m/$d/${_dob!.year}';
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _regNoController.dispose();
    _phoneController.dispose();
    _batchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: CommonAppBar(title: "Add New Student", showBack: true),
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
                        Center(
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFEFF6FF),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(color: const Color(0xFFBFDBFE), width: 1.5),
                                  ),
                                  child: const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [Icon(Icons.add_a_photo_outlined, color: Color(0xFF1A56DB), size: 32)],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                'Upload Student Photo',
                                style: GoogleFonts.inter(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1A56DB),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),
                        _AddFieldLabel(label: 'FULL NAME'),
                        const SizedBox(height: 8),
                        _AddTextField(
                          controller: _fullNameController,
                          hintText: 'John Doe',
                          prefixIcon: Icons.person_outline,
                        ),
                        const SizedBox(height: 18),
                        _AddFieldLabel(label: 'EMAIL ADDRESS'),
                        const SizedBox(height: 8),
                        _AddTextField(
                          controller: _emailController,
                          hintText: 'j.doe@university.edu',
                          prefixIcon: Icons.email_outlined,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 18),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _AddFieldLabel(label: 'REG. NO'),
                                  const SizedBox(height: 8),
                                  _AddTextField(controller: _regNoController, hintText: '2024-883'),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _AddFieldLabel(label: 'D.O.B'),
                                  const SizedBox(height: 8),
                                  GestureDetector(
                                    onTap: _pickDate,
                                    child: Container(
                                      height: 50,
                                      padding: const EdgeInsets.symmetric(horizontal: 14),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: const Color(0xFFE2E8F0)),
                                      ),
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        _dobDisplay,
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: _dob == null ? const Color(0xFFCBD5E1) : const Color(0xFF1E293B),
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 18),
                        _AddFieldLabel(label: 'PHONE NUMBER'),
                        const SizedBox(height: 8),
                        _AddTextField(
                          controller: _phoneController,
                          hintText: '+1 (555) 000-0000',
                          prefixIcon: Icons.phone_outlined,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 18),
                        _AddFieldLabel(label: 'DEPARTMENT'),
                        const SizedBox(height: 8),
                        _DepartmentDropdown(
                          value: _selectedDepartment,
                          items: _departments,
                          onChanged: (v) => setState(() => _selectedDepartment = v),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Batch
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _AddFieldLabel(label: 'BATCH'),
                                  const SizedBox(height: 8),
                                  _AddTextField(controller: _batchController, hintText: 'Fall 2024'),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _AddFieldLabel(label: 'GENDER'),
                                  const SizedBox(height: 8),
                                  _GenderDropdown(
                                    value: _selectedGender,
                                    items: _genders,
                                    onChanged: (v) {
                                      if (v != null) {
                                        setState(() => _selectedGender = v);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        _RulesCard(),
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
                      'Add Student',
                      style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: () => Navigator.maybePop(context),
                  child: Text(
                    'Cancel',
                    style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600, color: Color(0xFF1A1A1A)),
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

class _AddFieldLabel extends StatelessWidget {
  final String label;
  const _AddFieldLabel({required this.label});
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.inter(
        fontSize: 11.5,
        fontWeight: FontWeight.w700,
        color: Color(0xFF64748B),
        letterSpacing: 0.8,
      ),
    );
  }
}

class _AddTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  const _AddTextField({required this.controller, required this.hintText, this.prefixIcon, this.keyboardType});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(color: Color(0xFFCBD5E1), fontSize: 14),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: const Color(0xFF94A3B8), size: 20) : null,
        filled: true,
        fillColor: Colors.white,
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

class _DepartmentDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const _DepartmentDropdown({required this.value, required this.items, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          hint: Text('Select Department', style: GoogleFonts.inter(color: Color(0xFFCBD5E1), fontSize: 14)),
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF64748B)),
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B)),
          items: items.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _GenderDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const _GenderDropdown({required this.value, required this.items, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF64748B), size: 20),
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B)),
          items: items.map((g) => DropdownMenuItem(value: g, child: Text(g))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _RulesCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFBEB),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFFDE68A)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline_rounded, color: Color(0xFFB45309), size: 18),
              SizedBox(width: 8),
              Text(
                'IMPORTANT RULES & REGULATIONS',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF92400E),
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Ensure all academic documents are verified before submission. '
            'Changes to Registration No and Department require administrative '
            'override once the profile is created.',
            style: GoogleFonts.inter(fontSize: 12.5, color: Color(0xFFB45309), height: 1.55),
          ),
        ],
      ),
    );
  }
}
