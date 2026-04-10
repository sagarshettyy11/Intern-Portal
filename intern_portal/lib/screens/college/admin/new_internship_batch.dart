import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/models/admin/department_model.dart';
import 'package:intern_portal/models/admin/internship_model.dart';
import 'package:intern_portal/services/users/admin_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

class NewBatchDetailsScreen extends StatefulWidget {
  final Internship? internship; // 👈 ADD THIS

  const NewBatchDetailsScreen({super.key, this.internship});
  @override
  State<NewBatchDetailsScreen> createState() => _NewBatchDetailsScreenState();
}

class _NewBatchDetailsScreenState extends State<NewBatchDetailsScreen> {
  final TextEditingController _internshipNameController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  List<Department> departments = [];
  List<int> selectedDepartmentIds = [];
  String _selectedAcademicYear = '2024 - 2025';
  String _internshipMode = 'Online';
  String status = "Active";
  final List<String> _academicYears = ['2023 - 2024', '2024 - 2025', '2025 - 2026'];

  String _mapMode(InternshipMode mode) {
    switch (mode) {
      case InternshipMode.online:
        return "Online";
      case InternshipMode.offline:
        return "Offline";
      case InternshipMode.hybrid:
        return "Hybrid";
    }
  }

  String _mapYear(String year) {
    for (var y in _academicYears) {
      if (y.contains(year)) return y;
    }
    return _academicYears.last;
  }

  Future<void> loadDepartments() async {
    final data = await AdminServices.fetchDepartments();
    setState(() {
      departments = data;
    });
  }

  @override
  void initState() {
    super.initState();
    loadDepartments();
    if (widget.internship != null) {
      final i = widget.internship!;
      _internshipNameController.text = i.name;
      _durationController.text = i.duration;
      _internshipMode = _mapMode(i.mode);
      _selectedAcademicYear = _mapYear(i.year);
      selectedDepartmentIds = List.from(widget.internship!.departments);
      status = widget.internship!.status == InternshipStatus.active ? "Active" : "Inactive";
    }
  }

  @override
  void dispose() {
    _internshipNameController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F2F5),
      appBar: CommonAppBar(title: "Internship Batch", showBack: true),
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
                          'ADMINISTRATIVE TOOL',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A56DB),
                            letterSpacing: 1.1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          widget.internship == null ? 'New Batch Details' : 'Edit Batch Details',
                          style: GoogleFonts.inter(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF0F172A),
                            letterSpacing: -0.4,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Organize your next academic cohort by filling in the\ninstitutional parameters below.',
                          style: GoogleFonts.inter(fontSize: 13.5, color: Color(0xFF64748B), height: 1.55),
                        ),
                        const SizedBox(height: 28),
                        _FieldLabel(label: 'Internship Name'),
                        const SizedBox(height: 8),
                        _OutlinedInput(
                          controller: _internshipNameController,
                          hintText: 'e.g. Summer 2024 Product Design',
                        ),
                        const SizedBox(height: 20),
                        _FieldLabel(label: 'Academic Year'),
                        const SizedBox(height: 8),
                        _DropdownField(
                          value: _selectedAcademicYear,
                          items: _academicYears,
                          onChanged: (v) {
                            if (v != null) {
                              setState(() => _selectedAcademicYear = v);
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        _FieldLabel(label: 'Duration'),
                        const SizedBox(height: 8),
                        _OutlinedInput(
                          controller: _durationController,
                          hintText: 'e.g. 6 Months',
                          suffixIcon: const Icon(Icons.access_time_rounded, color: Color(0xFF94A3B8), size: 20),
                        ),
                        const SizedBox(height: 20),
                        _FieldLabel(label: 'Eligible Departments'),
                        const SizedBox(height: 12),
                        Column(
                          children: departments.map((dept) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: _DepartmentCheckbox(
                                label: dept.name,
                                value: selectedDepartmentIds.contains(dept.id),
                                onChanged: (v) {
                                  setState(() {
                                    if (v == true) {
                                      selectedDepartmentIds.add(dept.id);
                                    } else {
                                      selectedDepartmentIds.remove(dept.id);
                                    }
                                  });
                                },
                              ),
                            );
                          }).toList(),
                        ),
                        if (widget.internship != null) ...[
                          const SizedBox(height: 20),
                          _FieldLabel(label: 'Status'),
                          const SizedBox(height: 8),
                          _DropdownField(
                            value: status,
                            items: ['Active', 'Inactive'],
                            onChanged: (v) {
                              if (v != null) {
                                setState(() => status = v);
                              }
                            },
                          ),
                        ],
                        const SizedBox(height: 20),
                        _FieldLabel(label: 'Internship Mode'),
                        const SizedBox(height: 10),
                        _ModeToggle(
                          selected: _internshipMode,
                          onSelect: (mode) => setState(() => _internshipMode = mode),
                        ),
                        const SizedBox(height: 28),
                        _AcademicPolicyCard(),
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
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final departments = selectedDepartmentIds;
                      bool success;
                      if (widget.internship == null) {
                        success = await AdminServices.addInternship(
                          name: _internshipNameController.text,
                          year: _selectedAcademicYear,
                          duration: _durationController.text,
                          mode: _internshipMode,
                          departments: departments,
                        );
                      } else {
                        success = await AdminServices.editInternship(
                          id: widget.internship!.id,
                          name: _internshipNameController.text,
                          year: _selectedAcademicYear,
                          duration: _durationController.text,
                          mode: _internshipMode,
                          status: status,
                          departments: departments,
                        );
                      }
                      if (success) {
                        Navigator.pop(context, true);
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong")));
                      }
                    },
                    icon: const SizedBox.shrink(),
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.internship == null ? 'Create Batch' : 'Update Batch',
                          style: GoogleFonts.inter(color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 20),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A56DB),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});
  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: GoogleFonts.inter(fontSize: 13.5, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
    );
  }
}

class _OutlinedInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  const _OutlinedInput({required this.controller, required this.hintText, this.suffixIcon});
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.inter(fontSize: 14, color: Color(0xFF1E293B)),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.inter(color: Color(0xFFCBD5E1), fontSize: 14),
        suffixIcon: suffixIcon,
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

class _DropdownField extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const _DropdownField({required this.value, required this.items, required this.onChanged});
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
          value: items.contains(value) ? value : null,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF64748B)),
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF1E293B)),
          items: items.map((y) => DropdownMenuItem(value: y, child: Text(y))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _DepartmentCheckbox extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool?> onChanged;
  const _DepartmentCheckbox({required this.label, required this.value, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 22,
              height: 22,
              child: Checkbox(
                value: value,
                onChanged: onChanged,
                activeColor: const Color(0xFF1A56DB),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
            ),
          ],
        ),
      ),
    );
  }
}

class _ModeToggle extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelect;
  const _ModeToggle({required this.selected, required this.onSelect});
  static const _modes = ['Online', 'Offline', 'Hybrid'];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: const Color(0xFFE8EDF5), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: _modes.map((mode) {
          final isActive = selected == mode;
          return Expanded(
            child: GestureDetector(
              onTap: () => onSelect(mode),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 11),
                decoration: BoxDecoration(
                  color: isActive ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: Text(
                  mode,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isActive ? const Color.fromARGB(255, 26, 86, 219) : const Color(0xFF64748B),
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

class _AcademicPolicyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(14)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(color: const Color(0xFF1A56DB), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.info_outline_rounded, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Academic Policy',
                  style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
                ),
                SizedBox(height: 5),
                Text(
                  'Batches created under this academic year will automatically follow the 2024 AICTE guideline for credits.',
                  style: GoogleFonts.inter(fontSize: 12.5, color: Color(0xFF475569), height: 1.55),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
