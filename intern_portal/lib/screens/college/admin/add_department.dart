import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/models/admin/department_model.dart';
import 'package:intern_portal/screens/college/admin/department_master.dart';
import 'package:intern_portal/services/users/admin_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/common_widgets/common_widgets.dart';
import 'package:intern_portal/widgets/custom_snackbar.dart';

class AddDepartmentPage extends StatefulWidget {
  final Department? department;
  const AddDepartmentPage({super.key, this.department});
  @override
  State<AddDepartmentPage> createState() => _AddDepartmentPageState();
}

class _AddDepartmentPageState extends State<AddDepartmentPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController codeController = TextEditingController();
  List<dynamic> hodList = [];
  int? selectedHodId;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadHods();
    if (widget.department != null) {
      final d = widget.department!;
      nameController.text = d.name;
      codeController.text = d.code;
      selectedHodId = d.hodId;
    }
  }

  void loadHods() async {
    final data = await AdminServices.fetchHodList();
    setState(() {
      hodList = data;
    });
    debugPrint("HOD LIST: $hodList");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: CommonAppBar(title: "Add Department", showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.grid_view_rounded, size: 16, color: Color(0xFF1A56DB)),
                SizedBox(width: 6),
                Text(
                  'DEPARTMENT MANAGEMENT',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A56DB),
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.department == null ? 'Add Department' : 'Edit Department',
              style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.w800, color: Color(0xFF111827)),
            ),
            const SizedBox(height: 6),
            Text(
              'Establish a new academic unit within the Central University registry.',
              style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF6B7280), height: 1.5),
            ),
            const SizedBox(height: 28),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 3)),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Department Name",
                    style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 6),
                  CustomTextField(controller: nameController, hint: "e.g Computer Science"),
                  const SizedBox(height: 20),
                  Text(
                    "Department Code",
                    style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 6),
                  CustomTextField(controller: codeController, hint: "e.g DEPT001"),
                  const SizedBox(height: 20),
                  Text(
                    "Head of Department",
                    style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 6),
                  CustomDropdown(
                    value: selectedHodId,
                    hint: "Select HOD",
                    items: hodList,
                    isMap: true, // 🔥 IMPORTANT
                    onChanged: (value) {
                      setState(() {
                        selectedHodId = value;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline, size: 18, color: Color(0xFF1A56DB)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'All new departments are automatically assigned to the current 2024-2025 Academic Year. You can modify this in Audit Logs later.',
                            style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF1E40AF), height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final name = nameController.text.trim();
                  final code = codeController.text.trim();

                  if (name.isEmpty || code.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please fill all fields")));
                    return;
                  }

                  setState(() => isLoading = true);

                  final success = widget.department == null
                      ? await AdminServices.addDepartment(
                          name: name,
                          code: code,
                          hodId: selectedHodId, // ✅ IMPORTANT
                        )
                      : await AdminServices.editDepartment(
                          id: widget.department!.id,
                          name: name,
                          code: code,
                          hodId: selectedHodId, // ✅ IMPORTANT
                        );

                  setState(() => isLoading = false);

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          widget.department == null
                              ? "Department added successfully"
                              : "Department updated successfully",
                        ),
                      ),
                    );
                    Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          widget.department == null ? "Failed to add department" : "Failed to update department",
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A56DB),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: Text(
                  widget.department == null ? 'Add Department' : 'Update Department',
                  style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DepartmentMasterPage()));
                },
                child: Text(
                  'Cancel',
                  style: GoogleFonts.inter(color: Color(0xFF374151), fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
