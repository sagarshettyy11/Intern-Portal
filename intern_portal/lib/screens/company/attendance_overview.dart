import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/company/attendance_model.dart';
import 'package:intern_portal/screens/company/student_attendence.dart';
import 'package:intern_portal/services/users/company_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class AttendanceOverviewScreen extends StatefulWidget {
  const AttendanceOverviewScreen({super.key});
  @override
  State<AttendanceOverviewScreen> createState() => _AttendanceOverviewScreenState();
}

class _AttendanceOverviewScreenState extends State<AttendanceOverviewScreen> {
  String _year = '2023-24';
  String _college = 'Engineering';
  String _batch = 'Batch A';
  String _branch = 'CS';
  final TextEditingController _searchCtrl = TextEditingController();
  List<AttendanceStudent> students = [];
  AttendanceSummary? summary;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAttendance();
  }

  Future<void> loadAttendance() async {
    final res = await CompanyService.fetchAttendance(search: _searchCtrl.text, batch: _batch);
    setState(() {
      students = res?.students ?? [];
      summary = res?.summary;
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          children: [
            _buildTopStats(),
            const SizedBox(height: 14),
            _buildExportCard(),
            const SizedBox(height: 14),
            _buildFiltersCard(),
            const SizedBox(height: 14),
            _buildSearchBar(),
            const SizedBox(height: 16),
            ...students.map(
              (s) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _StudentCard(student: s),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: CompanyAppBottomNav(
        currentIndex: 2,
        onTap: (index) => CompanyBottomNavController.onItemTapped(context, index),
      ),
    );
  }

  Widget _buildTopStats() {
    return Row(
      children: [
        Expanded(child: _statCard('TOTAL INTERNS', '${summary?.totalStudents ?? 0}', const Color(0xFF111827))),
        const SizedBox(width: 12),
        Expanded(child: _statCard('AVG ATTENDANCE', '${summary?.avgAttendance ?? 0}%', const Color(0xFFE02424))),
      ],
    );
  }

  Widget _statCard(String label, String value, Color valColor) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: Colors.grey[800],
              fontWeight: FontWeight.w800,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: valColor),
          ),
        ],
      ),
    );
  }

  Widget _buildExportCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'EXPORT BATCH ATTENDANCE',
            style: GoogleFonts.inter(
              fontSize: 10,
              color: Colors.grey[800],
              fontWeight: FontWeight.w800,
              letterSpacing: 0.7,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.download_rounded, color: Colors.white, size: 18),
              label: Text(
                'Export Batch Attendance',
                style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF374151),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltersCard() {
    return _card(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _filterDropdown('YEAR', _year, [
                  '2023-24',
                  '2024-25',
                  '2025-26',
                ], (v) => setState(() => _year = v!)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _filterDropdown('COLLEGE', _college, [
                  'Engineering',
                  'Science',
                  'Arts',
                ], (v) => setState(() => _college = v!)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _filterDropdown('BATCH', _batch, [
                  'Batch A',
                  'Batch B',
                  'Batch C',
                ], (v) => setState(() => _batch = v!)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _filterDropdown('BRANCH', _branch, [
                  'CS',
                  'IT',
                  'ECE',
                  'ME',
                ], (v) => setState(() => _branch = v!)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0000FF),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 0,
              ),
              child: Text(
                'Apply Filter',
                style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w900, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterDropdown(String label, String value, List<String> items, ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[800], fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 4),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE5E7EB)),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: DropdownButton<String>(
            value: value,
            isExpanded: true,
            underline: const SizedBox(),
            icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF6B7280), size: 18),
            style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF111827)),
            items: items
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Text(e, style: GoogleFonts.inter(fontWeight: FontWeight.w800)),
                  ),
                )
                .toList(),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchCtrl,
      onChanged: (value) {
        loadAttendance();
      },
      style: GoogleFonts.inter(fontSize: 14),
      decoration: InputDecoration(
        hintText: 'Search student or ID...',
        hintStyle: GoogleFonts.inter(color: Colors.grey[800], fontSize: 14),
        prefixIcon: Icon(Icons.search, color: Colors.grey[800], size: 20),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF0000FF)),
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}

class _StudentCard extends StatelessWidget {
  final AttendanceStudent student;
  const _StudentCard({required this.student});
  Color get borderColor {
    switch (student.status.toLowerCase()) {
      case 'critical':
        return const Color(0xFFE02424);
      case 'warning':
      case 'at risk':
        return const Color(0xFFF0A500);
      default:
        return const Color(0xFF1A56DB);
    }
  }

  Color get statusTextColor {
    switch (student.status.toLowerCase()) {
      case 'critical':
        return const Color(0xFFE02424);
      case 'warning':
      case 'at risk':
        return const Color(0xFFB45309);
      default:
        return const Color(0xFF057A55);
    }
  }

  Color get statusBgColor {
    switch (student.status.toLowerCase()) {
      case 'critical':
        return const Color(0xFFFFE4E4);
      case 'warning':
      case 'at risk':
        return const Color(0xFFFEF3C7);
      default:
        return const Color(0xFFDEF7EC);
    }
  }

  Color get attendanceColor {
    final pct = student.attendance;
    if (pct < 50) return const Color(0xFFE02424);
    if (pct < 80) return const Color(0xFFF0A500);
    return const Color(0xFF1A56DB);
  }

  @override
  Widget build(BuildContext context) {
    final double pct = student.attendance;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: borderColor, width: 4)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                student.name,
                style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 16, color: const Color(0xFF111827)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: statusBgColor, borderRadius: BorderRadius.circular(20)),
                child: Text(
                  student.status,
                  style: GoogleFonts.inter(color: statusTextColor, fontSize: 11, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            student.regNo,
            style: GoogleFonts.inter(color: const Color(0xFF6B7280), fontSize: 12, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.laptop_outlined, size: 14, color: Colors.grey[700]),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  student.domain,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.grey[700]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Row(
            children: [
              Icon(Icons.calendar_today_outlined, size: 12, color: Colors.grey[700]),
              const SizedBox(width: 5),
              Text(
                student.period,
                style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.w800),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ATTENDANCE', style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w800)),
                  const SizedBox(height: 2),
                  Text(
                    '$pct%',
                    style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: attendanceColor),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => AttendanceManagementScreen()));
                },
                child: Row(
                  children: [
                    Text(
                      'View Attendance',
                      style: GoogleFonts.inter(
                        color: const Color(0xFF0000FF),
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Color(0xFF0000FF)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
