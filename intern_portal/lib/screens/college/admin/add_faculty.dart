import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/services/users/admin_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

class AddFacultyPage extends StatefulWidget {
  const AddFacultyPage({super.key});

  @override
  State<AddFacultyPage> createState() => _AddFacultyPageState();
}

class _AddFacultyPageState extends State<AddFacultyPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final designationController = TextEditingController();
  String role = "Guide";
  int? departmentId;
  bool isLoading = false;
  List departments = [];

  @override
  void initState() {
    super.initState();
    loadDepartments();
  }

  Future<void> loadDepartments() async {
    final data = await AdminServices.fetchDepartments();
    setState(() {
      departments = data;
    });
  }

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
                    _AddFacultyRoleToggle(
                      selected: role,
                      onChanged: (value) {
                        setState(() {
                          role = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                    const _AddFacultyFieldLabel('Full Name'),
                    const SizedBox(height: 8),
                    _AddFacultyTextField(hint: 'e.g. Dr. Robert Wilson', controller: nameController),
                    const SizedBox(height: 16),
                    const _AddFacultyFieldLabel('Academic Email'),
                    const SizedBox(height: 8),
                    _AddFacultyTextField(hint: 'robert.w@university.edu', controller: emailController),
                    const SizedBox(height: 16),
                    const _AddFacultyFieldLabel('Contact Number'),
                    const SizedBox(height: 8),
                    _AddFacultyTextField(
                      hint: '+1 (555) 000-0000',
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                    ),
                    const SizedBox(height: 16),
                    const _AddFacultyFieldLabel('Current Designation'),
                    const SizedBox(height: 8),
                    _AddFacultyTextField(hint: 'e.g. Associate Professor', controller: designationController),
                    const SizedBox(height: 16),
                    const _AddFacultyFieldLabel('Department'),
                    const SizedBox(height: 8),
                    _AddFacultyDropdown<int>(
                      hint: "Select Department",
                      value: departmentId,
                      items: departments.map<DropdownMenuItem<int>>((d) {
                        return DropdownMenuItem<int>(value: d.id, child: Text(d.name));
                      }).toList(),
                      onChanged: (v) => setState(() => departmentId = v),
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
                      onPressed: () async {
                        setState(() => isLoading = true);
                        final success = await AdminServices.addFaculty(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          designation: designationController.text,
                          departmentId: departmentId!,
                          role: role,
                        );
                        setState(() => isLoading = false);
                        if (success) {
                          Navigator.pop(context, true); // return success
                        }
                      },
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
  final TextEditingController controller;
  const _AddFacultyTextField({required this.hint, this.keyboardType, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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

class _AddFacultyRoleToggle extends StatelessWidget {
  final String selected;
  final Function(String) onChanged;

  const _AddFacultyRoleToggle({required this.selected, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final roles = ['Guide', 'HOD'];

    return Container(
      decoration: BoxDecoration(color: const Color(0xFFF3F5F9), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: roles.map((role) {
          final isSelected = selected == role;

          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(role),
              child: Container(
                margin: const EdgeInsets.all(4),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text(
                  role.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? const Color(0xFF1A56DB) : const Color(0xFF9CA3AF),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _AddFacultyDropdown<T> extends StatefulWidget {
  final String hint;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final Function(T?) onChanged;

  const _AddFacultyDropdown({required this.hint, required this.items, required this.onChanged, this.value});

  @override
  State<_AddFacultyDropdown<T>> createState() => _AddFacultyDropdownState<T>();
}

class _AddFacultyDropdownState<T> extends State<_AddFacultyDropdown<T>> {
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
          hint: Text(widget.hint, style: GoogleFonts.inter(color: const Color(0xFF9CA3AF), fontSize: 14)),
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
