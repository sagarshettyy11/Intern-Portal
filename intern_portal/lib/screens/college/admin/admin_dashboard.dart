import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/screens/college/admin/admin_profile.dart';
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
  String _selectedBatch = 'All Batches';
  String _selectedYear = 'All Years';
  final List<String> _batches = ['All Batches', 'Fall 2024', 'Spring 2025'];
  final List<String> _years = ['All Years', '2023', '2024', '2025'];
  final int _totalStudents = 9;
  final int _totalFaculty = 5;
  final int _departments = 2;
  final int _batches2 = 1;
  final int _regTotal = 0;
  final int _regPending = 0;
  final int _regApproved = 0;
  final int _regRejected = 0;

  @override
  Widget build(BuildContext context) {
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
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
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
          const SizedBox(height: 6),
          Text(
            'Overview of all internship activity',
            style: TextStyle(fontSize: 14, color: Colors.white.withValues(alpha: 0.85), fontWeight: FontWeight.w400),
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
                child: _StatCard(icon: Icons.people_alt, label: 'TOTAL STUDENTS', value: '$_totalStudents'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(icon: Icons.school, label: 'TOTAL FACULTY', value: '$_totalFaculty'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _StatCard(icon: Icons.domain, label: 'DEPARTMENTS', value: '$_departments'),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(icon: Icons.work, label: 'BATCHES', value: '$_batches2'),
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
                _RegCountTile(label: 'TOTAL', value: '$_regTotal', valueColor: const Color(0xFF1A56DB)),
                _RegDivider(),
                _RegCountTile(label: 'PENDING', value: '$_regPending', valueColor: const Color(0xFFD97706)),
                _RegDivider(),
                _RegCountTile(label: 'APPROVED', value: '$_regApproved', valueColor: const Color(0xFF16A34A)),
                _RegDivider(),
                _RegCountTile(label: 'REJECTED', value: '$_regRejected', valueColor: const Color(0xFFDC2626)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDepartmentRegistrations() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                Icon(Icons.bar_chart_rounded, color: Color(0xFF1A56DB), size: 22),
                SizedBox(width: 8),
                Text(
                  'Department Registrations',
                  style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 36),
              decoration: BoxDecoration(color: const Color(0xFFF1F5F9), borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.bar_chart_rounded, size: 40, color: Colors.grey.shade400),
                  const SizedBox(height: 12),
                  Text(
                    'No registrations found',
                    style: GoogleFonts.inter(fontSize: 14, color: Color(0xFF94A3B8), fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusBreakdown() {
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
                  style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF0F172A)),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Center(child: _DonutChart(percentage: 0)),
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
          const SizedBox(height: 14),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: Color(0xFF64748B),
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 4),
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
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color(0xFF94A3B8),
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
  final double percentage;
  const _DonutChart({required this.percentage});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      height: 160,
      child: CustomPaint(
        painter: _DonutPainter(percentage: percentage),
        child: Center(
          child: Text(
            '${percentage.toStringAsFixed(0)}%',
            style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
          ),
        ),
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final double percentage;
  _DonutPainter({required this.percentage});
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) - 12;
    const strokeWidth = 20.0;
    final bgPaint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, bgPaint);
    if (percentage > 0) {
      final fgPaint = Paint()
        ..color = const Color(0xFF1A56DB)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;
      final sweepAngle = 2 * math.pi * (percentage / 100);
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -math.pi / 2, sweepAngle, false, fgPaint);
    }
  }

  @override
  bool shouldRepaint(_DonutPainter old) => old.percentage != percentage;
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
          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: Color(0xFF475569)),
        ),
      ],
    );
  }
}
