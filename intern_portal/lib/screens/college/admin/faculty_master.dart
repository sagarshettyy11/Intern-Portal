import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/admin/department_model.dart';
import 'package:intern_portal/models/admin/faculty_model.dart';
import 'package:intern_portal/screens/college/admin/add_faculty.dart';
import 'package:intern_portal/screens/college/admin/admin_profile.dart';
import 'package:intern_portal/screens/college/admin/edit_faculty.dart';
import 'package:intern_portal/services/users/admin_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class FacultyMasterPage extends StatefulWidget {
  const FacultyMasterPage({super.key});
  @override
  State<FacultyMasterPage> createState() => _FacultyMasterPageState();
}

class _FacultyMasterPageState extends State<FacultyMasterPage> {
  int selectedIndex = 1;
  List<Faculty> facultyList = [];
  List<Department> departments = [];
  bool showFilters = false;
  int? selectedDept;
  bool isLoading = false;
  String search = '';
  String filter = 'all';

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  Future<void> loadInitialData() async {
    setState(() => isLoading = true);
    final deptData = await AdminServices.fetchDepartments();
    final data = await AdminServices.fetchFaculty(search: search, status: filter, deptId: selectedDept);
    setState(() {
      departments = deptData;
      facultyList = (data['faculty'] as List).map((e) => Faculty.fromJson(e)).toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
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
      body: _buildBody(),
      bottomNavigationBar: AdminAppBottomNav(
        currentIndex: 1,
        onTap: (index) => AdminBottomNavController.onItemTapped(context, index),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ADMINISTRATION',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A56DB),
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    'Faculty Master',
                    style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF111827)),
                  ),
                  Text(
                    'Manage institutional human resources and roles.',
                    style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[800]),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, 2)),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search faculty...',
                      hintStyle: GoogleFonts.inter(color: Colors.grey[800], fontSize: 14),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[800]),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    onChanged: (value) {
                      search = value;
                      loadInitialData();
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      showFilters = !showFilters;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A56DB).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.tune, color: const Color(0xFF1A56DB)),
                  ),
                ),
              ],
            ),
          ),
          if (showFilters) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      initialValue: filter,
                      decoration: InputDecoration(
                        labelText: "Status",
                        labelStyle: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey[900],
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                      items: [
                        DropdownMenuItem(
                          value: 'all',
                          child: Text('All', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800)),
                        ),
                        DropdownMenuItem(
                          value: 'active',
                          child: Text('Active', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800)),
                        ),
                        DropdownMenuItem(
                          value: 'inactive',
                          child: Text('Inactive', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800)),
                        ),
                      ],
                      onChanged: (val) {
                        setState(() => filter = val!);
                        loadInitialData();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<int>(
                      isExpanded: true,
                      initialValue: selectedDept,
                      decoration: InputDecoration(
                        labelText: "Department",
                        labelStyle: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.grey[900],
                        ),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      ),
                      style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
                      items: [
                        DropdownMenuItem<int>(
                          value: null,
                          child: Text('All', style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800)),
                        ),
                        ...departments.map((dept) {
                          return DropdownMenuItem<int>(
                            value: dept.id,
                            child: Text(dept.name, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800)),
                          );
                        }),
                      ],
                      onChanged: (val) {
                        setState(() => selectedDept = val);
                        loadInitialData();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 20),
          ...facultyList.map((f) => _FacultyCard(faculty: f, onDeactivate: () => _showDeactivateDialog(f))),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AddFacultyPage()));
      },
      backgroundColor: const Color(0xFF1A56DB),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Icon(Icons.person_add, color: Colors.white, fontWeight: FontWeight.bold),
    );
  }

  void _showDeactivateDialog(Faculty faculty) {
    showModalBottomSheet(
      context: context,
      builder: (_) => _DeactivateFacultySheet(
        faculty: faculty,
        onConfirm: () async {
          Navigator.pop(context);
          final success = await AdminServices.deactivateFaculty(faculty.id);
          if (success) {
            loadInitialData();
          }
        },
      ),
    );
  }
}

class _FacultyCard extends StatelessWidget {
  final Faculty faculty;
  final VoidCallback onDeactivate;
  const _FacultyCard({required this.faculty, required this.onDeactivate});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFFE8EEF9),
                  child: Text(
                    faculty.initials,
                    style: GoogleFonts.inter(color: Color(0xFF1A56DB), fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        faculty.name,
                        style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF111827)),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          _RoleBadge(label: faculty.role),
                          const SizedBox(width: 8),
                          _StatusDot(isActive: faculty.isActive),
                          const SizedBox(width: 4),
                          Text(
                            faculty.isActive ? 'Active' : 'Inactive',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: faculty.isActive ? const Color(0xFF16A34A) : const Color(0xFF9CA3AF),
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Action buttons
                Row(
                  children: [
                    _ActionIcon(
                      icon: Icons.edit_outlined,
                      color: const Color(0xFF1F2937),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) => EditFacultyPage(faculty: faculty)));
                      },
                    ),
                    const SizedBox(width: 4),
                    _ActionIcon(
                      icon: Icons.person_off_outlined,
                      color: faculty.isActive ? const Color(0xFF1F2937) : const Color(0xFFEF4444),
                      onTap: onDeactivate,
                    ),
                  ],
                ),
              ],
            ),
            if (faculty.department.isNotEmpty || faculty.designation.isNotEmpty) ...[
              const SizedBox(height: 14),
              _InfoRow(icon: Icons.grid_view_rounded, primary: faculty.department, secondary: 'Department'),
              const SizedBox(height: 8),
              _InfoRow(icon: Icons.school_outlined, primary: faculty.designation, secondary: 'Designation'),
            ],
            if (faculty.email != null) ...[
              const SizedBox(height: 8),
              _InfoRow(icon: Icons.alternate_email, primary: faculty.email!),
            ],
            if (faculty.phone != null) ...[
              const SizedBox(height: 8),
              _InfoRow(icon: Icons.phone_outlined, primary: faculty.phone!),
            ],
          ],
        ),
      ),
    );
  }
}

class _RoleBadge extends StatelessWidget {
  final String label;
  const _RoleBadge({required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(color: const Color(0xFFE8EEF9), borderRadius: BorderRadius.circular(6)),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 12,
          color: Color(0xFF1A56DB),
          fontWeight: FontWeight.w800,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  final bool isActive;
  const _StatusDot({required this.isActive});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color(0xFF16A34A) : const Color(0xFF9CA3AF),
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  const _ActionIcon({required this.icon, required this.color, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, size: 22, color: color),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String primary;
  final String? secondary;
  const _InfoRow({required this.icon, required this.primary, this.secondary});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.black54),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              primary,
              style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF374151), fontWeight: FontWeight.w800),
            ),
            if (secondary != null)
              Text(
                secondary!,
                style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[600], fontWeight: FontWeight.w800),
              ),
          ],
        ),
      ],
    );
  }
}

class _DeactivateFacultySheet extends StatelessWidget {
  final Faculty faculty;
  final Future<void> Function() onConfirm;
  const _DeactivateFacultySheet({required this.faculty, required this.onConfirm});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(color: const Color(0xFFD1D5DB), borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(height: 28),
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(color: const Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(16)),
            child: const Icon(Icons.warning_amber_rounded, color: Color(0xFFDC2626), size: 30),
          ),
          const SizedBox(height: 16),
          Text(
            'Deactivate Faculty',
            style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFFDC2626)),
          ),
          const SizedBox(height: 12),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.inter(fontSize: 14, color: Color(0xFF374151), height: 1.5),
              children: [
                const TextSpan(text: 'Are you sure you want to deactivate '),
                TextSpan(
                  text: faculty.name,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
                const TextSpan(text: '? They will no longer be able to log in.'),
              ],
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await onConfirm();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Text(
                'Yes, Deactivate',
                style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15),
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(color: Color(0xFF374151), fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
