import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/admin/student_model.dart';
import 'package:intern_portal/screens/college/admin/add_student.dart';
import 'package:intern_portal/screens/college/admin/edit_student.dart';
import 'package:intern_portal/screens/college/admin/import_students.dart';
import 'package:intern_portal/services/users/admin_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class StudentsListScreen extends StatefulWidget {
  const StudentsListScreen({super.key});
  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  int selectedTab = 2;
  List<StudentModel> students = [];
  bool isLoading = true;
  int total = 0;
  int active = 0;
  int inactive = 0;

  Future<void> fetchStudents({String search = ''}) async {
    try {
      final response = await AdminServices.fetchStudents(search: search);
      if (response != null) {
        setState(() {
          students = response.students;
          total = response.stats.total;
          active = response.stats.active;
          inactive = response.stats.inactive;
          isLoading = false;
        });
      }
    } catch (e) {
      debugPrint("Error: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchStudents();
  }

  void _onDeactivateStudent(int index) {
    showModalBottomSheet(
      context: context,
      builder: (_) => DeactivateStudentSheet(
        studentName: students[index].name.split(' ').first,
        onConfirm: () async {
          final studentId = students[index].studentId;
          final success = await AdminServices.deactivateStudent(studentId);
          if (success) {
            fetchStudents();
          }
          Navigator.pop(context);
        },
        onCancel: () => Navigator.pop(context),
      ),
    );
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
            onTap: () {},
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
                    GestureDetector(
                      onTap: () =>
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const ImportStudentsScreen())),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1A56DB), Color(0xFF2563EB)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF1A56DB).withValues(alpha: 0.35),
                              blurRadius: 16,
                              offset: const Offset(0, 6),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.upload_file, color: Colors.white70, size: 14),
                                      SizedBox(width: 6),
                                      Text(
                                        'FAST ONBOARDING',
                                        style: GoogleFonts.inter(
                                          color: Colors.white70,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Bulk Import via Excel',
                                    style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Quickly add multiple student profiles using our standard spreadsheet template.',
                                    style: GoogleFonts.inter(color: Colors.white70, fontSize: 13, height: 1.4),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            Container(
                              width: 42,
                              height: 42,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.25),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.arrow_forward, color: Colors.white, size: 22),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        _StatCard(label: 'TOTAL', value: "$total", valueColor: const Color(0xFF0F172A)),
                        const SizedBox(width: 10),
                        _StatCard(label: 'ACTIVE', value: "$active", valueColor: const Color(0xFF1A56DB)),
                        const SizedBox(width: 10),
                        _StatCard(label: 'INACTIVE', value: "$inactive", valueColor: const Color(0xFFEF4444)),
                      ],
                    ),
                    const SizedBox(height: 18),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 46,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'Search students...',
                                hintStyle: GoogleFonts.inter(color: Color(0xFFADB5BD), fontSize: 14),
                                prefixIcon: Icon(Icons.search, color: Color(0xFFADB5BD), size: 20),
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(vertical: 13),
                              ),
                              onChanged: (value) {
                                fetchStudents(search: value);
                              },
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          height: 46,
                          width: 46,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: const Icon(Icons.tune, color: Color(0xFF64748B), size: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.group_outlined, color: Color(0xFF1A56DB), size: 20),
                            SizedBox(width: 6),
                            Text(
                              'Students List',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const AddStudentScreen())).then((
                              _,
                            ) {
                              fetchStudents();
                            });
                          },
                          icon: const Icon(Icons.add_circle_outline, size: 18, color: Color(0xFF1A56DB)),
                          label: Text(
                            'Add Student',
                            style: GoogleFonts.inter(color: Color(0xFF1A56DB), fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ...students.asMap().entries.map(
                      (entry) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: _StudentCard(student: entry.value, onDeactivate: () => _onDeactivateStudent(entry.key)),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AdminAppBottomNav(
        currentIndex: 2,
        onTap: (index) => AdminBottomNavController.onItemTapped(context, index),
      ),
    );
  }
}

class _StudentCard extends StatelessWidget {
  final StudentModel student;
  final VoidCallback onDeactivate;
  const _StudentCard({required this.student, required this.onDeactivate});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 10, offset: const Offset(0, 3))],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(color: const Color(0xFFE8EEF8), borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text(
                    student.initials,
                    style: GoogleFonts.inter(color: Color(0xFF1A56DB), fontWeight: FontWeight.w700, fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.name,
                      style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15, color: Color(0xFF0F172A)),
                    ),
                    const SizedBox(height: 2),
                    Text(student.email, style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF64748B))),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: student.isActive ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  student.isActive ? 'ACTIVE' : 'INACTIVE',
                  style: GoogleFonts.inter(
                    color: student.isActive ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: Icon(Icons.edit_outlined, color: const Color(0xFF94A3B8), size: 20),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditStudentDetailsScreen(student: student)),
                  );
                },
              ),
              const SizedBox(width: 6),
              GestureDetector(
                onTap: onDeactivate,
                child: Icon(
                  Icons.power_settings_new,
                  color: student.isActive ? const Color(0xFFEF4444) : const Color(0xFF94A3B8),
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _InfoCell(label: 'REG ID', value: student.regNo),
              ),
              Expanded(
                child: _InfoCell(label: 'DEPARTMENT', value: student.departmentName ?? ''),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _InfoCell(label: 'BATCH', value: student.batch),
              ),
              Expanded(
                child: _InfoCell(label: 'YEAR OF STUDY', value: student.yearOfStudy),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCell extends StatelessWidget {
  final String label;
  final String value;
  const _InfoCell({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            color: Color(0xFF94A3B8),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF0F172A), fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  const _StatCard({required this.label, required this.value, required this.valueColor});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: valueColor),
            ),
          ],
        ),
      ),
    );
  }
}

class DeactivateStudentSheet extends StatelessWidget {
  final String studentName;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;
  const DeactivateStudentSheet({super.key, required this.studentName, required this.onConfirm, required this.onCancel});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(color: const Color(0xFFE2E8F0), borderRadius: BorderRadius.circular(2)),
          ),
          const SizedBox(height: 28),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(color: const Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(18)),
            child: const Icon(Icons.warning_amber_rounded, color: Color(0xFFDC2626), size: 36),
          ),
          const SizedBox(height: 20),
          Text(
            'Deactivate Student',
            style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFFDC2626)),
          ),
          const SizedBox(height: 10),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: GoogleFonts.inter(fontSize: 14, color: Color(0xFF64748B), height: 1.5),
              children: [
                const TextSpan(text: 'Are you sure you want to deactivate '),
                TextSpan(
                  text: studentName,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
                ),
                const TextSpan(text: '? They\nwill no longer be able to log in.'),
              ],
            ),
          ),
          const SizedBox(height: 28),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: onConfirm,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
              child: Text('Yes, Deactivate', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700)),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: TextButton(
              onPressed: onCancel,
              style: TextButton.styleFrom(
                backgroundColor: const Color(0xFFF1F5F9),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
