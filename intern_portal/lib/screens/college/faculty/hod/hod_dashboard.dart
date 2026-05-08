import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/hod/dashboard_model.dart';
import 'package:intern_portal/screens/college/faculty/hod/hod_profile.dart';
import 'package:intern_portal/services/users/hod_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class HodDashboardPage extends StatefulWidget {
  const HodDashboardPage({super.key});
  @override
  State<HodDashboardPage> createState() => _HodDashboardPageState();
}

class _HodDashboardPageState extends State<HodDashboardPage> {
  HodDashboard? data;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    final res = await HodServices.fetchDashboard();
    setState(() {
      data = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (data == null) {
      return const Scaffold(body: Center(child: Text("Failed to load dashboard")));
    }
    final batches = data!.batchYears.entries.toList();
    final chartData = batches.map((e) {
      final b = e.value;
      final total = b.total == 0 ? 1 : b.total;
      final applied = (total - b.notApplied) / total;
      final ongoing = b.ongoing / total;
      final completed = b.completed / total;
      return [applied, ongoing, completed];
    }).toList();
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
                      fontWeight: FontWeight.w800,
                      color: Colors.grey[800],
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Overview Analytics',
                    style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: Colors.black87),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: _StatCard(
                          icon: Icons.group_outlined,
                          iconColor: const Color(0xFF3B6EF0),
                          badge: '+12%',
                          badgeColor: Colors.green,
                          label: 'TOTAL STUDENTS',
                          value: data!.stats.totalStudents.toString(),
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
                          value: data!.stats.activeInternships.toString(),
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
                          badge: "${data!.stats.avgRating}/5",
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
                          value: "${data!.stats.completionRate}%",
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
                        'Departmental Progress',
                        style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 100,
                    width: double.infinity,
                    child: CustomPaint(painter: _BarChartPainter(chartData)),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: batches.map((e) {
                      return Text(
                        e.key,
                        style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.grey[800]),
                      );
                    }).toList(),
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
                children: data!.recentApprovals.map((a) {
                  return _ApprovalRow(
                    initials: a.studentName.substring(0, 2).toUpperCase(),
                    initialsColor: Colors.blue,
                    name: a.studentName,
                    guide: "Guide: ${a.guideName}",
                    tag: a.status,
                    tagColor: Colors.white,
                    tagBg: Colors.blue,
                    time: a.date,
                    isLast: false,
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Faculty Guide Load',
              style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Column(
              children: data!.guideLoads.map((g) {
                final double progress = (g.mentees / 10).clamp(0.0, 1.0);
                Color progressColor;
                if (g.mentees >= 8) {
                  progressColor = Colors.red;
                } else if (g.mentees >= 5) {
                  progressColor = Colors.orange;
                } else {
                  progressColor = const Color(0xFF3B6EF0);
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _GuideLoadCard(
                    name: g.name,
                    mentees: "${g.mentees} Mentees",
                    // responseTime: "~2 hrs", // optional
                    progress: progress,
                    progressColor: progressColor,
                  ),
                );
              }).toList(),
            ),
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
              Icon(icon, color: iconColor, size: 22, fontWeight: FontWeight.bold),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  badge,
                  style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: badgeColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
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
            style: GoogleFonts.inter(fontSize: valueFontSize, fontWeight: FontWeight.w800, color: Colors.black87),
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
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.w800),
        ),
      ],
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final List<List<double>> groups;

  _BarChartPainter(this.groups);

  @override
  void paint(Canvas canvas, Size size) {
    final bluePaint = Paint()..color = const Color(0xFF3B6EF0);
    final darkPaint = Paint()..color = const Color(0xFF1A1A2E);
    final greyPaint = Paint()..color = Colors.grey.shade300;

    final barWidth = size.width * 0.08;
    final gap = size.width * 0.02;

    final groupWidth = size.width / groups.length;

    for (int g = 0; g < groups.length; g++) {
      final startX = g * groupWidth + groupWidth * 0.2;

      final heights = groups[g];

      final paints = [bluePaint, darkPaint, greyPaint];

      for (int i = 0; i < heights.length; i++) {
        final h = heights[i];

        canvas.drawRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(startX + i * (barWidth + gap), size.height * (1 - h), barWidth, size.height * h),
            const Radius.circular(3),
          ),
          paints[i],
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
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
                  style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: initialsColor),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14, color: Colors.black87),
                    ),
                    Text(
                      guide,
                      style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[800], fontWeight: FontWeight.w800),
                    ),
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
                      style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: tagColor),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    time,
                    style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[700], fontWeight: FontWeight.w800),
                  ),
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
  final double progress;
  final Color progressColor;
  const _GuideLoadCard({
    required this.name,
    required this.mentees,
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
                    style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 14, color: Colors.black87),
                  ),
                  Text(
                    mentees,
                    style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.grey[800]),
                  ),
                ],
              ),
              /* Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'RESPONSE TIME',
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                  Text(
                    responseTime,
                    style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.black87),
                  ),
                ],
              ), */
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
