import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/hod/student_model.dart';
import 'package:intern_portal/screens/college/faculty/hod/hod_profile.dart';
import 'package:intern_portal/services/users/hod_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class StudentPerformancePage extends StatefulWidget {
  const StudentPerformancePage({super.key});
  @override
  State<StudentPerformancePage> createState() => _StudentPerformancePageState();
}

class _StudentPerformancePageState extends State<StudentPerformancePage> {
  DepartmentPerformance? data;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    final res = await HodServices.fetchStudentPerformance();
    setState(() {
      data = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return const Scaffold(body: Center(child: Text("No Data")));
    }
    final total = data!.summary.totalStudents.toDouble();
    final completed = total == 0 ? 0.0 : data!.summary.completed / total;
    final ongoing = total == 0 ? 0.0 : data!.summary.ongoing / total;
    final pending = total == 0 ? 0.0 : data!.summary.pending / total;
    final notApplied = total == 0 ? 0.0 : data!.summary.notApplied / total;
    final completedPercent = (completed * 100).toStringAsFixed(0);
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
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    'Department Student Performance',
                    style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black87),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _DeptStatCard(
                          icon: Icons.group_outlined,
                          label: 'TOTAL STUDENTS',
                          value: data!.summary.totalStudents.toString(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _DeptStatCard(
                          icon: Icons.trending_up,
                          iconColor: Colors.orange,
                          label: 'APPLIED',
                          value: data!.summary.applied.toString(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _DeptStatCard(
                          icon: Icons.business_outlined,
                          label: 'ONGOING',
                          value: data!.summary.ongoing.toString(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _DeptStatCard(
                          icon: Icons.star_border_rounded,
                          iconColor: Colors.amber,
                          label: 'PENDING',
                          value: data!.summary.pending.toString(),
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
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Internship Completion %',
                          style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black87),
                        ),
                        const SizedBox(height: 20),
                        Center(
                          child: IntrinsicWidth(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 160,
                                  width: 160,
                                  child: CustomPaint(
                                    painter: _DonutPainter(
                                      segments: [
                                        _DonutSegment(value: completed, color: Color(0xFF3B6EF0)),
                                        _DonutSegment(value: ongoing, color: Color(0xFF90CAF9)),
                                        _DonutSegment(value: pending, color: Colors.red),
                                        _DonutSegment(value: notApplied, color: Colors.grey),
                                      ],
                                    ),
                                    child: Center(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            '$completedPercent%',
                                            style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800),
                                          ),
                                          Text('COMPLETED', style: GoogleFonts.inter(fontSize: 10)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 24),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _legendItem("Completed", data!.summary.completed, Color(0xFF3B6EF0)),
                                    _legendItem("Ongoing", data!.summary.ongoing, Color(0xFF90CAF9)),
                                    _legendItem("Pending", data!.summary.pending, Colors.red),
                                    _legendItem("Not Applied", data!.summary.notApplied, Colors.grey),
                                  ],
                                ),
                              ],
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
            ),  */
                  const SizedBox(height: 16),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Grade Distribution',
                          style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black87),
                        ),
                        const SizedBox(height: 8),
                        Column(
                          children: data!.grades.map((g) {
                            final max = data!.summary.totalStudents;
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: _GradeBar(
                                grade: 'GRADE ${g.label}',
                                value: g.value,
                                max: max == 0 ? 1 : max,
                                color: _getGradeColor(g.label),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Student Details',
                    style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey[800], size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Search students or companies...',
                          style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[800], fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  Column(
                    children: data!.students.map((s) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: StudentCard(student: s),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
      bottomNavigationBar: HodAppBottomNav(
        currentIndex: 1,
        onTap: (index) => HodBottomNavController.onItemTapped(context, index),
      ),
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A+':
        return const Color(0xFF1A1A7E);
      case 'A':
        return const Color(0xFF3B6EF0);
      case 'B+':
        return const Color(0xFF90CAF9);
      case 'B':
        return Colors.grey.shade400;
      case 'C':
        return Colors.red.shade200;
      default:
        return Colors.grey;
    }
  }

  Widget _legendItem(String title, int count, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$count Students", style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700)),
              Text(title, style: GoogleFonts.inter(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

class StudentCard extends StatelessWidget {
  final StudentData student;
  const StudentCard({super.key, required this.student});
  @override
  Widget build(BuildContext context) {
    final statusData = _getStatusStyle(student.status);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue.shade200,
                child: Text(
                  student.name.isNotEmpty ? student.name[0].toUpperCase() : "?",
                  style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(student.name, style: GoogleFonts.inter(fontWeight: FontWeight.w800)),
                    Text(
                      student.email,
                      style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: statusData.bg, borderRadius: BorderRadius.circular(20)),
                child: Text(
                  statusData.label,
                  style: GoogleFonts.inter(color: statusData.color, fontSize: 11, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Divider(color: Colors.grey.shade300),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(child: _infoBlock("REG NO", student.registrationNo)),
              Expanded(child: _infoBlock("BATCH", student.year)),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(child: _infoBlock("COMPANY", student.guide.isEmpty ? "-" : student.guide)),
              Expanded(child: _infoBlock("GUIDE", student.guide.isEmpty ? "Not Assigned" : student.guide)),
            ],
          ),
        ],
      ),
    );
  }
}

Widget _infoBlock(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        label,
        style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[500], fontWeight: FontWeight.w800),
      ),
      const SizedBox(height: 2),
      Text(value, style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800)),
    ],
  );
}

class StatusStyle {
  final String label;
  final Color color;
  final Color bg;
  StatusStyle(this.label, this.color, this.bg);
}

StatusStyle _getStatusStyle(String status) {
  switch (status.toLowerCase()) {
    case "pending":
      return StatusStyle("Pending", Colors.blue, Colors.blue.shade100);
    case "completed":
      return StatusStyle("Completed", Colors.green, Colors.green.shade100);
    case "ongoing":
      return StatusStyle("Ongoing", Colors.orange, Colors.orange.shade100);
    case "not applied":
      return StatusStyle("Not Applied", Colors.orange, Colors.orange.shade100);
    default:
      return StatusStyle("Unknown", Colors.grey, Colors.grey.shade200);
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
  final List<_DonutSegment> segments;

  _DonutPainter({required this.segments});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 12;
    const strokeWidth = 18.0;

    double startAngle = -math.pi / 2;

    for (var segment in segments) {
      final sweepAngle = 2 * math.pi * segment.value;

      final paint = Paint()
        ..color = segment.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, sweepAngle, false, paint);

      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class _DonutSegment {
  final double value;
  final Color color;

  _DonutSegment({required this.value, required this.color});
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
} */

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

/* class _RadarChartPainter extends CustomPainter {
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
} 

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
} */
