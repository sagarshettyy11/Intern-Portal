import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/screens/college/faculty/hod/hod_profile.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class StudentPerformancePage extends StatelessWidget {
  const StudentPerformancePage({super.key});

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
            const SizedBox(height: 4),
            Text(
              'Department\nPerformance Analytics',
              style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black87),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(color: const Color(0xFF3B6EF0), borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Text(
                        'Academic Year 2023-24',
                        style: GoogleFonts.inter(fontSize: 12, color: Colors.white, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.keyboard_arrow_down, size: 16, color: Colors.white),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    'Semester 7',
                    style: GoogleFonts.inter(fontSize: 12, color: Colors.black87, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _DeptStatCard(icon: Icons.group_outlined, label: 'TOTAL INTERNS', value: '1,248'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DeptStatCard(
                    icon: Icons.trending_up,
                    iconColor: Colors.orange,
                    label: 'COMPLETION RATE',
                    value: '78.4%',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _DeptStatCard(icon: Icons.business_outlined, label: 'ACTIVE COMPANIES', value: '156'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _DeptStatCard(
                    icon: Icons.star_border_rounded,
                    iconColor: Colors.amber,
                    label: 'AVG. RATING',
                    value: '4.8/5',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Internship Completion %',
                    style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 160,
                    width: 160,
                    child: CustomPaint(
                      painter: _DonutPainter(value: 0.65),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '65%',
                              style: GoogleFonts.inter(
                                fontSize: 28,
                                color: Colors.black87,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            Text(
                              'COMPLETED',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                color: Colors.grey,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Ongoing semester internships are\nprojected to reach 85% by next month.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey[800],
                      height: 1.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            /* const SizedBox(height: 16),
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
                        'Report Submission\nConsistency',
                        style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black87),
                      ),
                      Row(
                        children: [
                          Text(
                            'MONTHLY\nTREND',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: Color(0xFF3B6EF0),
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.right,
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.trending_up, size: 16, color: Color(0xFF3B6EF0)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 80,
                    child: CustomPaint(size: const Size(double.infinity, 80), painter: _LineChartPainter()),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: ['JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN']
                        .map(
                          (m) => Text(
                            m,
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        )
                        .toList(),
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
                  Text(
                    'Grade Distribution',
                    style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  _GradeBar(grade: 'GRADE A+', value: 342, max: 500, color: const Color(0xFF1A1A7E)),
                  const SizedBox(height: 10),
                  _GradeBar(grade: 'GRADE A', value: 489, max: 500, color: const Color(0xFF3B6EF0)),
                  const SizedBox(height: 10),
                  _GradeBar(grade: 'GRADE B+', value: 212, max: 500, color: const Color(0xFF90CAF9)),
                  const SizedBox(height: 10),
                  _GradeBar(grade: 'GRADE B', value: 145, max: 500, color: Colors.grey.shade400),
                  const SizedBox(height: 10),
                  _GradeBar(grade: 'GRADE C', value: 60, max: 500, color: Colors.red.shade200),
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
                  Text(
                    'Department Comparison',
                    style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: CustomPaint(size: const Size(double.infinity, 200), painter: _RadarChartPainter()),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(color: Color(0xFF3B6EF0), shape: BoxShape.circle),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'CURRENT DEPT',
                        style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[800], fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(color: Colors.grey[400], shape: BoxShape.circle),
                      ),
                      SizedBox(width: 6),
                      Text(
                        'AVERAGE',
                        style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[800], fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ],
              ),
            ),*/
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Performance Alerts',
                  style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                Text(
                  'VIEW ALL',
                  style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF3B6EF0), fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _AlertCard(
              color: const Color(0xFFFFF1F1),
              borderColor: const Color(0xFFFFCDD2),
              iconColor: Colors.red,
              icon: Icons.warning_amber_rounded,
              title: 'Weekly Report Missing',
              subtitle: '12 students in Comp. Sci. overdue by 2 days',
            ),
            const SizedBox(height: 10),
            _AlertCard(
              color: const Color(0xFFEFF4FF),
              borderColor: const Color(0xFFBDD4FF),
              iconColor: const Color(0xFF3B6EF0),
              icon: Icons.chat_bubble_outline,
              title: 'Industry Mentor Feedback',
              subtitle: 'High positive trend in Mechanical Eng. dept.',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: HodAppBottomNav(
        currentIndex: 1,
        onTap: (index) => HodBottomNavController.onItemTapped(context, index),
      ),
    );
  }
}

class _DeptStatCard extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String label;
  final String value;
  const _DeptStatCard({required this.icon, this.iconColor, required this.label, required this.value});
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
          Icon(icon, color: iconColor ?? const Color(0xFF3B6EF0), size: 22),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: Colors.grey[800],
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

class _DonutPainter extends CustomPainter {
  final double value;
  const _DonutPainter({required this.value});
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;
    const strokeWidth = 18.0;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      0,
      2 * math.pi,
      false,
      Paint()
        ..color = Colors.grey.shade200
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * value,
      false,
      Paint()
        ..color = const Color(0xFF3B6EF0)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

/* class _LineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF3B6EF0)
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;
    final points = [
      Offset(0, size.height * 0.6),
      Offset(size.width * 0.2, size.height * 0.3),
      Offset(size.width * 0.4, size.height * 0.7),
      Offset(size.width * 0.6, size.height * 0.5),
      Offset(size.width * 0.8, size.height * 0.15),
      Offset(size.width, size.height * 0.4),
    ];
    final path = Path()..moveTo(points[0].dx, points[0].dy);
    for (int i = 0; i < points.length - 1; i++) {
      final mid = Offset((points[i].dx + points[i + 1].dx) / 2, (points[i].dy + points[i + 1].dy) / 2);
      path.quadraticBezierTo(points[i].dx, points[i].dy, mid.dx, mid.dy);
    }
    path.lineTo(points.last.dx, points.last.dy);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

class _GradeBar extends StatelessWidget {
  final String grade;
  final int value;
  final int max;
  final Color color;
  const _GradeBar({required this.grade, required this.value, required this.max, required this.color});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 72,
          child: Text(
            grade,
            style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[800], fontWeight: FontWeight.w800),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: value / max,
              backgroundColor: Colors.grey[800],
              color: color,
              minHeight: 8,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          value.toString(),
          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.black87),
        ),
      ],
    );
  }
}

class _RadarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.height * 0.38;
    const sides = 5;
    final labels = ['PLACEMENT', 'INDUSTRY', 'AVG GRADE', 'SUBMISSION', 'FEEDBACK'];
    final currentValues = [0.85, 0.75, 0.70, 0.80, 0.65];
    final avgValues = [0.65, 0.60, 0.58, 0.62, 0.55];
    final gridPaint = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (int ring = 1; ring <= 4; ring++) {
      final r = radius * ring / 4;
      final path = Path();
      for (int i = 0; i < sides; i++) {
        final angle = -math.pi / 2 + (2 * math.pi * i / sides);
        final x = center.dx + r * math.cos(angle);
        final y = center.dy + r * math.sin(angle);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas.drawPath(path, gridPaint);
    }
    for (int i = 0; i < sides; i++) {
      final angle = -math.pi / 2 + (2 * math.pi * i / sides);
      canvas.drawLine(
        center,
        Offset(center.dx + radius * math.cos(angle), center.dy + radius * math.sin(angle)),
        gridPaint,
      );
    }
    _drawRadarShape(canvas, center, radius, avgValues, Colors.grey.shade400, sides);
    _drawRadarShape(canvas, center, radius, currentValues, const Color(0xFF3B6EF0), sides);
    final labelPaint = TextPainter(textDirection: TextDirection.ltr);
    for (int i = 0; i < sides; i++) {
      final angle = -math.pi / 2 + (2 * math.pi * i / sides);
      final x = center.dx + (radius + 18) * math.cos(angle);
      final y = center.dy + (radius + 18) * math.sin(angle);
      labelPaint.text = TextSpan(
        text: labels[i],
        style: GoogleFonts.inter(fontSize: 9, color: Colors.grey[900], fontWeight: FontWeight.w800),
      );
      labelPaint.layout();
      labelPaint.paint(canvas, Offset(x - labelPaint.width / 2, y - labelPaint.height / 2));
    }
  }

  void _drawRadarShape(Canvas canvas, Offset center, double radius, List<double> values, Color color, int sides) {
    final fillPaint = Paint()
      ..color = color.withValues(alpha: 0.15)
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    final path = Path();
    for (int i = 0; i < sides; i++) {
      final angle = -math.pi / 2 + (2 * math.pi * i / sides);
      final r = radius * values[i];
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
} */

class _AlertCard extends StatelessWidget {
  final Color color;
  final Color borderColor;
  final Color iconColor;
  final IconData icon;
  final String title;
  final String subtitle;
  const _AlertCard({
    required this.color,
    required this.borderColor,
    required this.iconColor,
    required this.icon,
    required this.title,
    required this.subtitle,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey[400]),
        ],
      ),
    );
  }
}
