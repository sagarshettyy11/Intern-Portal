import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/admin/dashboard_model.dart';
import 'package:intern_portal/screens/college/admin/admin_profile.dart';
import 'package:intern_portal/services/users/admin_services.dart';
import 'dart:math' as math;

import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class CollegeAdminDashboardScreen extends StatefulWidget {
  const CollegeAdminDashboardScreen({super.key});
  @override
  State<CollegeAdminDashboardScreen> createState() => _CollegeAdminDashboardScreenState();
}

class _CollegeAdminDashboardScreenState extends State<CollegeAdminDashboardScreen> {
  int selectedNavIndex = 0;
  DashboardData? dashboard;
  bool isLoading = true;
  String _selectedBatch = 'All Batches';
  String _selectedYear = 'All Years';
  final List<String> _batches = ['All Batches', 'Fall 2024', 'Spring 2025'];
  final List<String> _years = ['All Years', '2023', '2024', '2025'];

  @override
  void initState() {
    super.initState();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    final data = await AdminServices.fetchDashboard();
    setState(() {
      dashboard = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
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
              child: ListView(
                padding: const EdgeInsets.only(bottom: 24),
                children: [
                  _buildHeroCard(),
                  const SizedBox(height: 16),
                  _buildFilterRow(),
                  const SizedBox(height: 16),
                  _buildStatsGrid(),
                  const SizedBox(height: 20),
                  _buildInternshipRegistrations(),
                  const SizedBox(height: 20),
                  _buildDepartmentRegistrations(),
                  const SizedBox(height: 20),
                  _buildStatusBreakdown(),
                  const SizedBox(height: 20),
                  _buildRecentRegistrations(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AdminAppBottomNav(
        currentIndex: 0,
        onTap: (index) => AdminBottomNavController.onItemTapped(context, index),
      ),
    );
  }

  Widget _buildHeroCard() {
    return Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A56DB), Color(0xFF2563EB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
            style: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          Text(
            'Overview of all internship activity',
            style: GoogleFonts.inter(
              fontSize: 15,
              color: Colors.white.withValues(alpha: 0.85),
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterRow() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _FilterDropdown(
            value: _selectedBatch,
            items: _batches,
            onChanged: (v) {
              if (v != null) setState(() => _selectedBatch = v);
            },
          ),
          const SizedBox(width: 12),
          _FilterDropdown(
            value: _selectedYear,
            items: _years,
            onChanged: (v) {
              if (v != null) setState(() => _selectedYear = v);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.people_alt,
                  label: 'TOTAL STUDENTS',
                  value: dashboard!.overview['total_students'].toString(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.school,
                  label: 'TOTAL FACULTY',
                  value: dashboard!.overview['total_faculty'].toString(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.domain,
                  label: 'DEPARTMENTS',
                  value: dashboard!.overview['total_depts'].toString(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.work,
                  label: 'BATCHES',
                  value: dashboard!.overview['total_batches'].toString(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInternshipRegistrations() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Internship Registrations',
            style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: Row(
              children: [
                _RegCountTile(
                  label: 'TOTAL',
                  value: dashboard!.stats['total'].toString(),
                  valueColor: const Color(0xFF1A56DB),
                ),
                _RegDivider(),
                _RegCountTile(
                  label: 'PENDING',
                  value: dashboard!.stats['pending'].toString(),
                  valueColor: const Color(0xFFD97706),
                ),
                _RegDivider(),
                _RegCountTile(
                  label: 'APPROVED',
                  value: dashboard!.stats['approved'].toString(),
                  valueColor: const Color(0xFF16A34A),
                ),
                _RegDivider(),
                _RegCountTile(
                  label: 'REJECTED',
                  value: dashboard!.stats['rejected'].toString(),
                  valueColor: const Color(0xFFDC2626),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentRegistrations() {
    final List deptList = dashboard?.deptStats ?? [];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.bar_chart_rounded, color: Color(0xFF1A56DB), size: 22),
                SizedBox(width: 8),
                Text('Department Registrations', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800)),
              ],
            ),
            const SizedBox(height: 20),
            if (deptList.isEmpty)
              Center(
                child: Text('No registrations found', style: GoogleFonts.inter(fontSize: 14, color: Colors.grey)),
              )
            else
              SizedBox(
                height: 220,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: _getMaxY(deptList),
                    barGroups: _buildBarGroups(deptList),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index >= deptList.length) return const SizedBox();
                            return Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: Text(
                                deptList[index]['dept_code'],
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  color: Colors.grey[800],
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    ),
                    borderData: FlBorderData(show: false),
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBreakdown() {
    final status = dashboard!.statusBreakdown;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.pie_chart_rounded, color: Color(0xFF1A56DB), size: 22),
                SizedBox(width: 8),
                Text(
                  'Status Breakdown',
                  style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(
              child: _DonutChart(
                approved: status['approved'] ?? 0,
                pending: status['pending'] ?? 0,
                rejected: status['rejected'] ?? 0,
                completed: status['completed'] ?? 0,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _LegendItem(color: Color(0xFF1A56DB), label: 'Approved'),
                      SizedBox(height: 10),
                      _LegendItem(color: Color(0xFFDC2626), label: 'Rejected'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      _LegendItem(color: Color(0xFFD97706), label: 'Pending'),
                      SizedBox(height: 10),
                      _LegendItem(color: Color(0xFFCBD5E1), label: 'Incomplete'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentRegistrations() {
    final List recentList = dashboard!.recentRegistrations;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Registrations',
                style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: const Color(0xFF0F172A)),
              ),
              GestureDetector(
                onTap: () {
                  // Navigate to full registrations list
                },
                child: Text(
                  'View All',
                  style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: const Color(0xFF1A56DB)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Text(
                          'STUDENT',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey[800],
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'DEPT',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey[800],
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Text(
                          'COMPANY',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey[800],
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(
                          'STATUS',
                          textAlign: TextAlign.right,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: Colors.grey[800],
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1, color: Color(0xFFF1F5F9)),
                if (recentList.isEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text(
                        'No registrations found',
                        style: GoogleFonts.inter(fontSize: 13, color: const Color(0xFF94A3B8)),
                      ),
                    ),
                  )
                else
                  ...recentList.asMap().entries.map((entry) {
                    final i = entry.key;
                    final reg = entry.value;
                    return Column(
                      children: [
                        _RecentRegRow(
                          studentName: reg['student_name'] ?? '',
                          dept: reg['dept_code'] ?? '',
                          company: reg['company_name'] ?? '',
                          status: reg['status'] ?? '',
                        ),
                        if (i < recentList.length - 1) const Divider(height: 1, color: Color(0xFFF1F5F9)),
                      ],
                    );
                  }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

double _getMaxY(List list) {
  if (list.isEmpty) return 10;
  final max = list.map((e) => e['count'] as int).reduce((a, b) => a > b ? a : b);
  return (max + 2).toDouble();
}

List<BarChartGroupData> _buildBarGroups(List list) {
  return List.generate(list.length, (index) {
    final item = list[index];
    final value = (item['count'] ?? 0).toDouble();
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(toY: value, width: 16, color: const Color(0xFF0000FF), borderRadius: BorderRadius.zero),
      ],
    );
  });
}

class _RecentRegRow extends StatelessWidget {
  final String studentName;
  final String dept;
  final String company;
  final String status;
  const _RecentRegRow({required this.studentName, required this.dept, required this.company, required this.status});
  Color get _statusBg {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFFDCFCE7);
      case 'pending':
        return const Color(0xFFFEF3C7);
      case 'rejected':
        return const Color(0xFFFEE2E2);
      default:
        return const Color(0xFFF1F5F9);
    }
  }

  Color get _statusFg {
    switch (status.toLowerCase()) {
      case 'approved':
        return const Color(0xFF16A34A);
      case 'pending':
        return const Color(0xFFD97706);
      case 'rejected':
        return const Color(0xFFDC2626);
      default:
        return const Color(0xFF64748B);
    }
  }

  bool get _showDot => status.toLowerCase() == 'approved' || status.toLowerCase() == 'rejected';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              studentName,
              style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, color: const Color(0xFF0F172A)),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(6)),
              child: Text(
                dept,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xFF1A56DB)),
              ),
            ),
          ),
          // Company
          Expanded(
            flex: 3,
            child: Text(
              company,
              style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: const Color(0xFF475569)),
            ),
          ),
          // Status badge
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: _statusBg, borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_showDot) ...[
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(color: _statusFg, shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 4),
                    ],
                    Flexible(
                      child: Text(
                        status.isNotEmpty ? status[0].toUpperCase() + status.substring(1) : '',
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: _statusFg),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  const _FilterDropdown({required this.value, required this.items, required this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 18, color: Color(0xFF64748B)),
          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
          items: items.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _StatCard({required this.icon, required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: const Color(0xFF1A56DB), size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Colors.grey[800],
              letterSpacing: 0.6,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
          ),
        ],
      ),
    );
  }
}

class _RegCountTile extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  const _RegCountTile({required this.label, required this.value, required this.valueColor});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: valueColor),
            ),
            const SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Colors.grey[800],
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RegDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 40, color: const Color(0xFFF1F5F9));
  }
}

class _DonutChart extends StatelessWidget {
  final int approved;
  final int pending;
  final int rejected;
  final int completed;

  const _DonutChart({required this.approved, required this.pending, required this.rejected, required this.completed});
  @override
  Widget build(BuildContext context) {
    final total = approved + pending + rejected + completed;
    return SizedBox(
      width: 160,
      height: 160,
      child: CustomPaint(
        painter: _DonutPainter(approved: approved, pending: pending, rejected: rejected, completed: completed),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                total.toString(), // 🔥 TOTAL COUNT
                style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w900, color: Color(0xFF0F172A)),
              ),
              Text('Total', style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[800], fontWeight: FontWeight.w800)),
            ],
          ),
        ),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final int approved;
  final int pending;
  final int rejected;
  final int completed;
  _DonutPainter({required this.approved, required this.pending, required this.rejected, required this.completed});
  @override
  void paint(Canvas canvas, Size size) {
    final total = approved + pending + rejected + completed;
    if (total == 0) return;
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 12;
    const strokeWidth = 20.0;
    double startAngle = -math.pi / 2;
    void drawSegment(int value, Color color) {
      if (value == 0) return;
      final sweep = 2 * math.pi * (value / total);
      final paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweep, false, paint);
      startAngle += sweep;
    }

    drawSegment(approved, const Color(0xFF1A56DB)); // Blue
    drawSegment(pending, const Color(0xFFD97706)); // Orange
    drawSegment(rejected, const Color(0xFFDC2626)); // Red
    drawSegment(completed, const Color(0xFFCBD5E1)); // Grey
  }

  @override
  bool shouldRepaint(_DonutPainter old) =>
      old.approved != approved || old.pending != pending || old.rejected != rejected || old.completed != completed;
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendItem({required this.color, required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF475569)),
        ),
      ],
    );
  }
}
