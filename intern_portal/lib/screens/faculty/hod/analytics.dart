import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: const Color(0xFF3B6EF0),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Icon(Icons.school, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 8),
            const Text(
              'Intern Portal',
              style: TextStyle(
                  color: Color(0xFF3B6EF0),
                  fontWeight: FontWeight.w700,
                  fontSize: 15),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined,
                color: Colors.black54),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey[200]),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'HOD Dashboard',
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 16),

            // Top 4 stat cards
            Row(
              children: [
                Expanded(
                  child: _AnalyticStatCard(
                    icon: Icons.group_outlined,
                    iconColor: const Color(0xFF3B6EF0),
                    label: 'ACTIVE STUDENTS',
                    value: '1,240',
                    isHighlighted: false,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _AnalyticStatCard(
                    icon: Icons.description_outlined,
                    iconColor: Colors.white,
                    label: 'REPORTS DONE',
                    value: '85.4%',
                    isHighlighted: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _AnalyticStatCard(
                    icon: Icons.workspace_premium_outlined,
                    iconColor: Colors.orange,
                    label: 'CERTIFICATES',
                    value: '912',
                    isHighlighted: false,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _AnalyticStatCard(
                    icon: Icons.handshake_outlined,
                    iconColor: const Color(0xFF3B6EF0),
                    label: 'JOe PLACEMENT',
                    value: '62.1%',
                    isHighlighted: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Career Outcomes donut
            const Text(
              'Career Outcomes',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 12),
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
                      offset: const Offset(0, 2))
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 180,
                    width: 180,
                    child: CustomPaint(
                      painter: _CareerDonutPainter(),
                      child: const Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '62%',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            Text(
                              'PLACED',
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                  letterSpacing: 0.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _LegendDot(
                          color: const Color(0xFF3B6EF0),
                          label: 'Full-time Job'),
                      const SizedBox(width: 16),
                      _LegendDot(
                          color: const Color(0xFF1A1A2E),
                          label: 'Further Study'),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _LegendDot(
                          color: Colors.grey.shade300,
                          label: 'Searching'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Completion Breakdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Completion Breakdown',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                const Text(
                  'VIEW ALL',
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF3B6EF0),
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2))
                ],
              ),
              child: Column(
                children: [
                  _CompletionRow(
                    initials: 'JD',
                    initialsColor: const Color(0xFF3B6EF0),
                    name: 'Jane Doe',
                    company: 'Tech Solutions Inc.',
                    status: 'COMPLETED',
                    statusColor: const Color(0xFF3B6EF0),
                    time: '2d ago',
                    isLast: false,
                  ),
                  _CompletionRow(
                    initials: 'MS',
                    initialsColor: Colors.teal,
                    name: 'Mark Smith',
                    company: 'Green Energy Corp.',
                    status: 'PENDING',
                    statusColor: Colors.orange,
                    time: 'Due tomorrow',
                    isLast: false,
                  ),
                  _CompletionRow(
                    initials: 'AL',
                    initialsColor: Colors.purple,
                    name: 'Alex Lee',
                    company: 'Fintech Dynamics',
                    status: 'COMPLETED',
                    statusColor: const Color(0xFF3B6EF0),
                    time: '1w ago',
                    isLast: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Student Feedback Trends
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Student Feedback\nTrends',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF4FF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'SENTIMENT:\nPOSITIVE',
                    style: TextStyle(
                        fontSize: 10,
                        color: Color(0xFF3B6EF0),
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2))
                ],
              ),
              child: Column(
                children: [
                  _FeedbackItem(
                    icon: Icons.chat_outlined,
                    iconColor: const Color(0xFF3B6EF0),
                    iconBg: const Color(0xFFEFF4FF),
                    title: 'Skill Gap Identified',
                    subtitle:
                        '62% of students report a need for more practical Cloud Infrastructure training prior to internships.',
                  ),
                  Divider(height: 20, color: Colors.grey[100]),
                  _FeedbackItem(
                    icon: Icons.thumb_up_outlined,
                    iconColor: Colors.green,
                    iconBg: const Color(0xFFE8F5E9),
                    title: 'Company Satisfaction',
                    subtitle:
                        'Top rated employers this term: TechSolutions Ltd, Global Systems, and Innovate Corp.',
                  ),
                  Divider(height: 20, color: Colors.grey[100]),
                  _FeedbackItem(
                    icon: Icons.warning_amber_outlined,
                    iconColor: Colors.orange,
                    iconBg: const Color(0xFFFFF3E0),
                    title: 'Relocation Hurdles',
                    subtitle:
                        '15% students mentioned difficulty in finding affordable housing near major IT hubs.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Artifacts Availability
            const Text(
              'Artifacts Availability',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2))
                ],
              ),
              child: Column(
                children: [
                  _ArtifactBar(
                    label: 'OFFER LETTERS',
                    current: 1120,
                    total: 1240,
                    color: const Color(0xFF3B6EF0),
                  ),
                  const SizedBox(height: 14),
                  _ArtifactBar(
                    label: 'COMPLETION CERTIFICATES',
                    current: 912,
                    total: 1240,
                    color: Colors.green,
                  ),
                  const SizedBox(height: 14),
                  _ArtifactBar(
                    label: 'EMPLOYER FEEDBACK FORMS',
                    current: 650,
                    total: 1240,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const _HodBottomNav(currentIndex: 3),
    );
  }
}

// ── Analytic stat card ────────────────────────────────────────────────────────

class _AnalyticStatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final String value;
  final bool isHighlighted;

  const _AnalyticStatCard({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.value,
    required this.isHighlighted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isHighlighted ? const Color(0xFF3B6EF0) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
                fontSize: 10,
                color: isHighlighted ? Colors.white70 : Colors.grey[500],
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: isHighlighted ? Colors.white : Colors.black87),
          ),
        ],
      ),
    );
  }
}

// ── Career donut painter ──────────────────────────────────────────────────────

class _CareerDonutPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 16;
    const strokeWidth = 22.0;

    final segments = [
      (0.62, const Color(0xFF3B6EF0)),   // Placed full-time
      (0.20, const Color(0xFF1A1A2E)),   // Further study
      (0.18, Colors.grey),                // Searching
    ];

    double startAngle = -math.pi / 2;
    for (final seg in segments) {
      final sweepAngle = 2 * math.pi * seg.$1;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle - 0.05,
        false,
        Paint()
          ..color = seg.$2
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.butt,
      );
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ── Legend dot ────────────────────────────────────────────────────────────────

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
            decoration:
                BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 5),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}

// ── Completion row ────────────────────────────────────────────────────────────

class _CompletionRow extends StatelessWidget {
  final String initials;
  final Color initialsColor;
  final String name;
  final String company;
  final String status;
  final Color statusColor;
  final String time;
  final bool isLast;

  const _CompletionRow({
    required this.initials,
    required this.initialsColor,
    required this.name,
    required this.company,
    required this.status,
    required this.statusColor,
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
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: initialsColor),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black87)),
                    Text(company,
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey[500])),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    status,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: statusColor),
                  ),
                  const SizedBox(height: 2),
                  Text(time,
                      style:
                          TextStyle(fontSize: 11, color: Colors.grey[400])),
                ],
              ),
            ],
          ),
        ),
        if (!isLast)
          Divider(height: 1, color: Colors.grey[100], indent: 16),
      ],
    );
  }
}

// ── Feedback item ─────────────────────────────────────────────────────────────

class _FeedbackItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;

  const _FeedbackItem({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
              color: iconBg, borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: Colors.black87)),
              const SizedBox(height: 4),
              Text(subtitle,
                  style: TextStyle(
                      fontSize: 12, color: Colors.grey[600], height: 1.4)),
            ],
          ),
        ),
      ],
    );
  }
}

// ── Artifact bar ──────────────────────────────────────────────────────────────

class _ArtifactBar extends StatelessWidget {
  final String label;
  final int current;
  final int total;
  final Color color;

  const _ArtifactBar({
    required this.label,
    required this.current,
    required this.total,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[600],
                    letterSpacing: 0.3)),
            Text('$current / $total',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: color)),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: current / total,
            backgroundColor: Colors.grey[200],
            color: color,
            minHeight: 7,
          ),
        ),
      ],
    );
  }
}

// ── Bottom nav ────────────────────────────────────────────────────────────────

class _HodBottomNav extends StatelessWidget {
  final int currentIndex;
  const _HodBottomNav({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.grey[200]!))),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        selectedLabelStyle:
            const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        elevation: 0,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined,
                color: currentIndex == 0
                    ? const Color(0xFF3B6EF0)
                    : Colors.grey[500]),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined,
                color: currentIndex == 1
                    ? const Color(0xFF3B6EF0)
                    : Colors.grey[500]),
            label: 'Students',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin_outlined,
                color: currentIndex == 2
                    ? const Color(0xFF3B6EF0)
                    : Colors.grey[500]),
            label: 'Guides',
          ),
          // Active Analytics pill
          BottomNavigationBarItem(
            icon: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: currentIndex == 3
                    ? const Color(0xFF3B6EF0)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.bar_chart_rounded,
                  color: currentIndex == 3
                      ? Colors.white
                      : Colors.grey[500]),
            ),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline,
                color: currentIndex == 4
                    ? const Color(0xFF3B6EF0)
                    : Colors.grey[500]),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}