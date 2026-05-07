import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/admin/department_model.dart';
import 'package:intern_portal/screens/college/admin/add_department.dart';
import 'package:intern_portal/screens/college/admin/admin_profile.dart';
import 'package:intern_portal/services/users/admin_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class DepartmentMasterPage extends StatefulWidget {
  const DepartmentMasterPage({super.key});
  @override
  State<DepartmentMasterPage> createState() => _DepartmentMasterPageState();
}

class _DepartmentMasterPageState extends State<DepartmentMasterPage> {
  List<Department> departments = [];
  bool isLoading = true;
  int currentIndex = 3;
  bool showFilters = false;
  String statusFilter = 'all';
  String search = '';

  @override
  void initState() {
    super.initState();
    loadDepartments();
  }

  void loadDepartments() async {
    final data = await AdminServices.fetchDepartments();
    List<Department> filtered = data;
    if (search.isNotEmpty) {
      filtered = filtered.where((d) => d.name.toLowerCase().contains(search.toLowerCase())).toList();
    }
    if (statusFilter == 'active') {
      filtered = filtered.where((d) => d.isActive).toList();
    } else if (statusFilter == 'inactive') {
      filtered = filtered.where((d) => !d.isActive).toList();
    }
    setState(() {
      departments = filtered;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }
    if (departments.isEmpty) {
      return Scaffold(body: Center(child: Text("No departments found")));
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: CommonAppBar(
        showLogo: true,
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminProfileScreen()));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircleAvatar(radius: 16, child: Icon(Icons.person, size: 18, color: Colors.black)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'ACADEMIC MANAGEMENT',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Colors.grey[900],
                        letterSpacing: 0.8,
                      ),
                    ),
                    Text(
                      'Department Master',
                      style: GoogleFonts.inter(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildActionRow(),
                    if (showFilters) ...[
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                        child: DropdownButtonFormField<String>(
                          initialValue: statusFilter,
                          isExpanded: true,
                          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                          decoration: InputDecoration(
                            labelText: "Status",
                            labelStyle: GoogleFonts.inter(
                              fontSize: 13,
                              fontWeight: FontWeight.w800,
                              color: Colors.grey[900],
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          ),
                          items: [
                            DropdownMenuItem(
                              value: 'all',
                              child: Text('All', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800)),
                            ),
                            DropdownMenuItem(
                              value: 'active',
                              child: Text(
                                'Active',
                                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'inactive',
                              child: Text(
                                'Inactive',
                                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                          onChanged: (val) {
                            setState(() => statusFilter = val!);
                            loadDepartments();
                          },
                        ),
                      ),
                    ],
                    const SizedBox(height: 10),
                    ...departments.map(
                      (dept) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: DepartmentMasterCard(department: dept),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AdminAppBottomNav(
        currentIndex: 3,
        onTap: (index) => AdminBottomNavController.onItemTapped(context, index),
      ),
    );
  }

  Widget _buildActionRow() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddDepartmentPage()),
              );
              if (result == true) {
                loadDepartments();
              }
            },
            icon: const Icon(Icons.add_circle, size: 20, color: Colors.white),
            label: Text(
              'Add Department',
              style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A56DB),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () {
            setState(() => showFilters = !showFilters);
          },
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: const Color(0xFF1A56DB).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.tune, color: Color(0xFF1A56DB)),
          ),
        ),
      ],
    );
  }
}

class DepartmentMasterCard extends StatelessWidget {
  final Department department;
  const DepartmentMasterCard({super.key, required this.department});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: department.isActive ? const Color(0xFFEFF6FF) : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    department.icon,
                    color: department.isActive ? const Color(0xFF1A56DB) : const Color(0xFF94A3B8),
                    size: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        department.name,
                        style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: department.isActive ? const Color(0xFF0F172A) : const Color(0xFF94A3B8),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'CODE: ${department.code}',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                          color: department.isActive ? Colors.grey[800] : const Color(0xFFB0BFCC),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    DepartmentMasterStatusBadge(isActive: department.isActive),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => AddDepartmentPage(department: department)),
                            );
                            if (result == true) {
                              (context.findAncestorStateOfType<_DepartmentMasterPageState>())?.loadDepartments();
                            }
                          },
                          child: const Icon(Icons.edit_outlined, color: Color(0xFF1F2937), size: 18),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () async {
                            if (department.isActive) {
                              final success = await AdminServices.deactivateDepartment(department.id);
                              if (success) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(SnackBar(content: Text("Department deactivated")));
                              }
                            } else {
                              final success = await AdminServices.editDepartment(
                                id: department.id,
                                name: department.name,
                                code: department.code,
                              );
                              if (success) {
                                ScaffoldMessenger.of(
                                  context,
                                ).showSnackBar(SnackBar(content: Text("Department activated")));
                              }
                            }
                            (context.findAncestorStateOfType<_DepartmentMasterPageState>())?.loadDepartments();
                          },
                          child: Icon(
                            Icons.power_settings_new,
                            color: department.isActive ? const Color(0xFF1F2937) : const Color(0xFFEF4444),
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: DepartmentMasterInfoCell(
                    label: 'HOD NAME',
                    value: department.hodName,
                    isActive: department.isActive,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DepartmentMasterInfoCell(
                    label: 'FACULTY COUNT',
                    value: '${department.facultyCount} Members',
                    isActive: department.isActive,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DepartmentMasterStatusBadge extends StatelessWidget {
  final bool isActive;
  const DepartmentMasterStatusBadge({super.key, required this.isActive});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? const Color(0xFFD4A017) : const Color(0xFFEF4444), width: 1.2),
      ),
      child: Text(
        isActive ? 'ACTIVE' : 'INACTIVE',
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: isActive ? const Color(0xFFD4A017) : const Color(0xFFEF4444),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class DepartmentMasterInfoCell extends StatelessWidget {
  final String label;
  final String value;
  final bool isActive;
  const DepartmentMasterInfoCell({super.key, required this.label, required this.value, required this.isActive});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w800,
              color: Color(0xFF374151),
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isActive ? const Color(0xFF0F172A) : const Color(0xFF94A3B8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
