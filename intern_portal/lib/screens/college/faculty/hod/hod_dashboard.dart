import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/screens/college/faculty/hod/hod_profile.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class HodDashboardPage extends StatelessWidget {
  const HodDashboardPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: CommonAppBar(
        showLogo: true,
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => HodProfilePage()));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircleAvatar(radius: 16, child: Icon(Icons.person, size: 18, color: Colors.black)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HOD Dashboard',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ACADEMIC YEAR 2023-24',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[500],
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Overview Analytics',
                    style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: Icons.group_outlined,
                          iconColor: const Color(0xFF3B6EF0),
                          badge: '+12%',
                          badgeColor: Colors.green,
                          label: 'TOTAL STUDENTS',
                          value: '1,240',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.work_outline,
                          iconColor: const Color(0xFF3B6EF0),
                          badge: 'Stable',
                          badgeColor: Colors.blue,
                          label: 'ACTIVE\nINTERNSHIPS',
                          value: '482',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: Icons.star_border_rounded,
                          iconColor: const Color(0xFF3B6EF0),
                          badge: '4.8/5.0',
                          badgeColor: Colors.orange,
                          label: 'GUIDE\nPERFORMANCE',
                          value: 'Excellent',
                          valueFontSize: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _StatCard(
                          icon: Icons.check_circle_outline,
                          iconColor: const Color(0xFF3B6EF0),
                          badge: '+2%',
                          badgeColor: Colors.green,
                          label: 'COMPLETION RATE',
                          value: '94.2%',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Departmental\nProgress',
                        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4F6FB),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey[300]!),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('Semester 6', style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500)),
                            const SizedBox(width: 4),
                            Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.grey[600]),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: CustomPaint(painter: _BarChartPainter()),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('2021-22', style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[500])),
                      Text('2022-23', style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[500])),
                      Text(
                        '2023-24',
                        style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF3B6EF0), fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      _LegendDot(color: const Color(0xFF3B6EF0), label: 'Applied'),
                      const SizedBox(width: 16),
                      _LegendDot(color: const Color(0xFF1A1A2E), label: 'Ongoing'),
                      const SizedBox(width: 16),
                      _LegendDot(color: Colors.grey[300]!, label: 'Completed'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Approvals',
                  style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                Text(
                  'VIEW ALL',
                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF3B6EF0)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                children: [
                  _ApprovalRow(
                    initials: 'AR',
                    initialsColor: const Color(0xFF3B6EF0),
                    name: 'Alex Rivera',
                    guide: 'Guide: Dr. Sarah Chen',
                    tag: 'Final Report',
                    tagColor: const Color(0xFF3B6EF0),
                    tagBg: const Color(0xFFE8F1FF),
                    time: '2m ago',
                    isLast: false,
                  ),
                  _ApprovalRow(
                    initials: 'MK',
                    initialsColor: Colors.orange,
                    name: 'Maya Kapoor',
                    guide: 'Guide: Prof. Mark Davis',
                    tag: 'Mid-term',
                    tagColor: Colors.orange,
                    tagBg: const Color(0xFFFFF3E0),
                    time: '15m ago',
                    isLast: false,
                  ),
                  _ApprovalRow(
                    initials: 'JL',
                    initialsColor: Colors.purple,
                    name: 'Jordan Lee',
                    guide: 'Guide: Dr. Robert Fox',
                    tag: 'NOC Verified',
                    tagColor: Colors.purple,
                    tagBg: const Color(0xFFF3E5F5),
                    time: '1h ago',
                    isLast: false,
                  ),
                  _ApprovalRow(
                    initials: 'ST',
                    initialsColor: Colors.teal,
                    name: 'Sanya Thakur',
                    guide: 'Guide: Dr. Sarah Chen',
                    tag: 'Certificate',
                    tagColor: Colors.white,
                    tagBg: const Color(0xFF1A1A2E),
                    time: '3h ago',
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Faculty Guide Load',
              style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            _GuideLoadCard(
              name: 'Dr. Sarah Chen',
              mentees: '8 Mentees',
              responseTime: '~2.4 hrs',
              progress: 0.78,
              progressColor: const Color(0xFF3B6EF0),
            ),
            const SizedBox(height: 10),
            _GuideLoadCard(
              name: 'Prof. Mark Davis',
              mentees: '5 Mentees',
              responseTime: '~4.1 hrs',
              progress: 0.50,
              progressColor: const Color(0xFF3B6EF0),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: HodAppBottomNav(
        currentIndex: 0,
        onTap: (index) => HodBottomNavController.onItemTapped(context, index),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String badge;
  final Color badgeColor;
  final String label;
  final String value;
  final double valueFontSize;
  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.badge,
    required this.badgeColor,
    required this.label,
    required this.value,
    this.valueFontSize = 22,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: const Color(0xFFF4F6FB), borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: iconColor, size: 22),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w600, color: badgeColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: Colors.grey[500],
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(fontSize: valueFontSize, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  final Color color;
  final String label;
  const _LegendDot({required this.color, required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 5),
        Text(label, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}

class _BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final bluePaint = Paint()..color = const Color(0xFF3B6EF0);
    final darkPaint = Paint()..color = const Color(0xFF1A1A2E);
    final greyPaint = Paint()..color = Colors.grey.shade300;
    final barWidth = size.width * 0.09;
    final gap = size.width * 0.02;
    final groups = [
      [0.45, 0.55, 0.35],
      [0.55, 0.60, 0.42],
      [0.72, 0.75, 0.50],
    ];
    final groupWidth = size.width / 3;
    for (int g = 0; g < groups.length; g++) {
      final startX = g * groupWidth + groupWidth * 0.15;
      final heights = groups[g];
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(startX, size.height * (1 - heights[0]), barWidth, size.height * heights[0]),
          const Radius.circular(3),
        ),
        bluePaint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(startX + barWidth + gap, size.height * (1 - heights[1]), barWidth, size.height * heights[1]),
          const Radius.circular(3),
        ),
        darkPaint,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            startX + (barWidth + gap) * 2,
            size.height * (1 - heights[2]),
            barWidth,
            size.height * heights[2],
          ),
          const Radius.circular(3),
        ),
        greyPaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _ApprovalRow extends StatelessWidget {
  final String initials;
  final Color initialsColor;
  final String name;
  final String guide;
  final String tag;
  final Color tagColor;
  final Color tagBg;
  final String time;
  final bool isLast;
  const _ApprovalRow({
    required this.initials,
    required this.initialsColor,
    required this.name,
    required this.guide,
    required this.tag,
    required this.tagColor,
    required this.tagBg,
    required this.time,
    required this.isLast,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: initialsColor.withValues(alpha: 0.15),
                child: Text(
                  initials,
                  style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.bold, color: initialsColor),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87),
                    ),
                    Text(guide, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500])),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: tagBg, borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      tag,
                      style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: tagColor),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(time, style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[400])),
                ],
              ),
            ],
          ),
        ),
        if (!isLast) Divider(height: 1, color: Colors.grey[100], indent: 16),
      ],
    );
  }
}

class _GuideLoadCard extends StatelessWidget {
  final String name;
  final String mentees;
  final String responseTime;
  final double progress;
  final Color progressColor;
  const _GuideLoadCard({
    required this.name,
    required this.mentees,
    required this.responseTime,
    required this.progress,
    required this.progressColor,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
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
                    name,
                    style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87),
                  ),
                  Text(mentees, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500])),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'RESPONSE TIME',
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                  Text(
                    responseTime,
                    style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              color: progressColor,
              minHeight: 5,
            ),
          ),
        ],
      ),
    );
  }
}
