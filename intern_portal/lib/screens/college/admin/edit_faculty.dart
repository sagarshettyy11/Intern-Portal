import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/models/admin/faculty_model.dart';
import 'package:intern_portal/services/users/admin_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

class EditFacultyPage extends StatefulWidget {
  final Faculty faculty;
  const EditFacultyPage({super.key, required this.faculty});
  @override
  State<EditFacultyPage> createState() => _EditFacultyPageState();
}

class _EditFacultyPageState extends State<EditFacultyPage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController designationController;

  List departments = [];
  String role = "Guide";
  String status = "Active";
  int? departmentId;
  bool isLoading = false;

  Future<void> loadDepartments() async {
    final data = await AdminServices.fetchDepartments();
    setState(() {
      departments = data;
    });
  }

  @override
  void initState() {
    super.initState();
    final f = widget.faculty;
    departmentId = widget.faculty.departmentId;
    nameController = TextEditingController(text: f.name);
    emailController = TextEditingController(text: f.email);
    phoneController = TextEditingController(text: f.phone);
    designationController = TextEditingController(text: f.designation);
    role = f.role;
    status = f.isActive ? "Active" : "Inactive";
    loadDepartments();
  }

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
              widget.faculty.name,
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
                  _EditFacultyTextField(hint: 'Full Name', controller: nameController),
                  const SizedBox(height: 16),
                  _EditFacultyFieldLabel(
                    'Email Address',
                    leading: const Icon(Icons.mail_outline, size: 16, color: Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 8),
                  _EditFacultyTextField(
                    hint: 'Email',
                    controller: emailController,
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
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  _EditFacultyFieldLabel(
                    'Designation',
                    leading: const Icon(Icons.badge_outlined, size: 16, color: Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 8),
                  _EditFacultyTextField(hint: 'Designation', controller: designationController),
                  const SizedBox(height: 16),
                  _EditFacultyFieldLabel(
                    'Department',
                    leading: const Icon(Icons.grid_view_rounded, size: 16, color: Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 8),
                  _EditFacultyDropdown<int>(
                    hint: "Select Department",
                    value: departmentId,
                    items: departments.map<DropdownMenuItem<int>>((d) {
                      return DropdownMenuItem<int>(value: d['department_id'], child: Text(d['department_name']));
                    }).toList(),
                    onChanged: (v) => setState(() => departmentId = v),
                  ),
                  const SizedBox(height: 16),
                  _EditFacultyFieldLabel(
                    'Employment Status',
                    leading: const Icon(Icons.circle_outlined, size: 16, color: Color(0xFF6B7280)),
                  ),
                  const SizedBox(height: 8),
                  _EditFacultyDropdown<String>(
                    hint: "Select Status",
                    value: status,
                    items: [
                      'Active',
                      'Inactive',
                    ].map((e) => DropdownMenuItem<String>(value: e, child: Text(e))).toList(),
                    onChanged: (v) => setState(() => status = v!),
                  ),
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
                onPressed: () async {
                  setState(() => isLoading = true);
                  final success = await AdminServices.editFaculty(
                    facultyId: widget.faculty.id,
                    name: nameController.text,
                    email: widget.faculty.email!,
                    phone: phoneController.text,
                    designation: designationController.text,
                    departmentId: departmentId!,
                    role: role,
                    status: status,
                  );
                  setState(() => isLoading = false);
                  if (success) {
                    Navigator.pop(context, true);
                  }
                },
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

class _EditFacultyDropdown<T> extends StatefulWidget {
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final Function(T?) onChanged;

  const _EditFacultyDropdown({required this.hint, required this.items, required this.onChanged, this.value});

  @override
  State<_EditFacultyDropdown<T>> createState() => _EditFacultyDropdownState<T>();
}

class _EditFacultyDropdownState<T> extends State<_EditFacultyDropdown<T>> {
  T? _selected;

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
        child: DropdownButton<T>(
          value: _selected,
          hint: Text(widget.hint, style: GoogleFonts.inter(color: Color(0xFF9CA3AF), fontSize: 14)),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF6B7280)),
          items: widget.items,
          onChanged: (v) {
            setState(() => _selected = v);
            widget.onChanged(v); // 🔥 important
          },
        ),
      ),
    );
  }
}
