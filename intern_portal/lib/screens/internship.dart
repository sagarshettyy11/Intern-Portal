import 'package:flutter/material.dart';

class InternshipsPage extends StatelessWidget {
  const InternshipsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black87),
        title: const Text(
          "My Internships",
          style: TextStyle(
              color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 17),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black87),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.grey[300],
              child: Icon(Icons.person, size: 18, color: Colors.grey[600]),
            ),
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
            // ── Header card ───────────────────────────────────────────────
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
              child: Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A2E),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.work_outline,
                        color: Colors.white, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Software Engineer Intern",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text("TechCorp",
                              style: TextStyle(
                                  fontSize: 13, color: Colors.grey[600])),
                          Text(" · ",
                              style: TextStyle(color: Colors.grey[400])),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8F1FF),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              "IN PROGRESS",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Color(0xFF3B6EF0),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // ── Stats row ─────────────────────────────────────────────────
            Row(
              children: [
                Expanded(
                  child: _StatBox(
                    label: "OVERALL COMPLETION",
                    value: "65%",
                    sub: "+1%",
                    subColor: Colors.green,
                    showProgress: true,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _StatBox(
                    label: "REPORTS SUBMITTED",
                    value: "12/20",
                    sub: "Due in 2 days",
                    subColor: Colors.grey,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _StatBox(
                    label: "DAYS REMAINING",
                    value: "45 Days",
                    sub: "End Nov 15, 2024",
                    subColor: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 22),

            // ── Milestones header ─────────────────────────────────────────
            Row(
              children: [
                const Icon(Icons.show_chart, color: Color(0xFF3B6EF0), size: 20),
                const SizedBox(width: 6),
                const Text(
                  "Internship Milestones",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // ── Timeline ──────────────────────────────────────────────────
            // Completed item 1
            _MilestoneItem(
              isDone: true,
              isFuture: false,
              title: "Orientation & Onboarding",
              subtitle: "Completed on Aug 15",
            ),
            // Completed item 2
            _MilestoneItem(
              isDone: true,
              isFuture: false,
              title: "Initial Training & Project Approval",
              subtitle: "Completed on Sep 02",
            ),
            // Active item
            const _ActiveMilestone(),
            // Future item (last — no connector line below)
            _MilestoneItem(
              isDone: false,
              isFuture: true,
              title: "Final Report Submission",
              subtitle: "Scheduled for Nov 10",
            ),
            const SizedBox(height: 22),

            // ── Mentors ───────────────────────────────────────────────────
            const Text(
              "Your Mentors",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 12),
            _MentorCard(
                name: "Dr. Robert Chen",
                role: "Software Engineer (Industry)"),
            const SizedBox(height: 10),
            _MentorCard(
                name: "Prof. Sarah Miller", role: "Academic Supervisor"),
            const SizedBox(height: 22),

            // ── Resources ─────────────────────────────────────────────────
            const Text(
              "Helpful Resources",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2))
                ],
              ),
              child: Column(
                children: [
                  _ResourceTile(
                      icon: Icons.description_outlined,
                      title: "Internship Guidelines"),
                  Divider(height: 1, indent: 50, color: Colors.grey[200]),
                  _ResourceTile(
                      icon: Icons.help_outline, title: "Support Contacts"),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const _BottomNav(currentIndex: 1),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Stat box
// ─────────────────────────────────────────────────────────────────────────────

class _StatBox extends StatelessWidget {
  final String label, value, sub;
  final Color subColor;
  final bool showProgress;

  const _StatBox({
    required this.label,
    required this.value,
    required this.sub,
    required this.subColor,
    this.showProgress = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: TextStyle(
                  fontSize: 9,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3)),
          const SizedBox(height: 6),
          Text(value,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87)),
          if (showProgress) ...[
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: 0.65,
                backgroundColor: Colors.grey[200],
                color: const Color(0xFF3B6EF0),
                minHeight: 4,
              ),
            ),
          ],
          const SizedBox(height: 4),
          Text(sub, style: TextStyle(fontSize: 10, color: subColor)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Milestone item (completed / future)
// FIX: replaced IntrinsicHeight + Expanded with a plain Row + fixed-height line
// ─────────────────────────────────────────────────────────────────────────────

class _MilestoneItem extends StatelessWidget {
  final bool isDone;
  final bool isFuture;
  final String title;
  final String subtitle;

  const _MilestoneItem({
    required this.isDone,
    required this.isFuture,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: dot + connector line
        SizedBox(
          width: 24,
          child: Column(
            children: [
              // Dot
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: isDone
                      ? const Color(0xFF3B6EF0)
                      : Colors.grey[200],
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isDone ? Icons.check : Icons.circle,
                  size: isDone ? 14 : 8,
                  color: isDone ? Colors.white : Colors.grey[400],
                ),
              ),
              // Connector line (not shown for the last/future item)
              if (!isFuture)
                Container(
                  width: 2,
                  height: 52, // fixed height — no Expanded needed
                  color: isDone
                      ? const Color(0xFF3B6EF0)
                      : Colors.grey[300],
                ),
            ],
          ),
        ),
        const SizedBox(width: 14),

        // Right: text content
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(bottom: isFuture ? 0 : 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: isFuture ? Colors.grey[400] : Colors.black87,
                  ),
                ),
                const SizedBox(height: 2),
                Text(subtitle,
                    style:
                        TextStyle(fontSize: 12, color: Colors.grey[500])),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Active milestone
// FIX: replaced IntrinsicHeight + Expanded + LayoutBuilder DashedLine
//      with a plain Row + fixed-height dashed painter
// ─────────────────────────────────────────────────────────────────────────────

class _ActiveMilestone extends StatelessWidget {
  const _ActiveMilestone();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Left: active dot + dashed connector
        SizedBox(
          width: 24,
          child: Column(
            children: [
              // Active dot (white ring with blue fill)
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: const Color(0xFF3B6EF0), width: 2.5),
                ),
                child: Center(
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF3B6EF0),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              // Dashed connector — fixed height, custom painter
              CustomPaint(
                size: const Size(2, 148),
                painter: _DashedLinePainter(),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),

        // Right: active milestone card
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Mid-term Evaluation",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF3B6EF0)),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF3B6EF0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "ACTIVE",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F5FF),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "REQUIRED TASKS",
                        style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.4),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.check_circle,
                              color: Color(0xFF3B6EF0), size: 18),
                          const SizedBox(width: 8),
                          Text(
                            "Update Portfolio",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[500],
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          Container(
                            width: 18,
                            height: 18,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey[400]!),
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Schedule Meeting with Guide",
                            style: TextStyle(
                                fontSize: 13, color: Colors.black87),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Dashed line painter — replaces LayoutBuilder-based DashedLine widget
// Uses CustomPainter so it works at any fixed size without needing intrinsic height
// ─────────────────────────────────────────────────────────────────────────────

class _DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const dashHeight = 4.0;
    const dashSpace = 4.0;
    final paint = Paint()
      ..color = const Color(0xFF3B6EF0).withValues(alpha: 0.4)
      ..strokeWidth = 2;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashHeight),
        paint,
      );
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// Mentor card
// ─────────────────────────────────────────────────────────────────────────────

class _MentorCard extends StatelessWidget {
  final String name, role;

  const _MentorCard({required this.name, required this.role});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, color: Colors.grey[600]),
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
                Text(role,
                    style: TextStyle(fontSize: 12, color: Colors.grey[500])),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F5FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.chat_bubble_outline,
                color: Color(0xFF3B6EF0), size: 18),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Resource tile
// ─────────────────────────────────────────────────────────────────────────────

class _ResourceTile extends StatelessWidget {
  final IconData icon;
  final String title;

  const _ResourceTile({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          // Blue icon box
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF3B6EF0), size: 18),
          ),
          const SizedBox(width: 14),
          // Title
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          // Chevron
          Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Bottom nav
// ─────────────────────────────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  final int currentIndex;

  const _BottomNav({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF3B6EF0),
        unselectedItemColor: Colors.grey[500],
        selectedLabelStyle:
            const TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 9),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_view_rounded), label: 'DASHBOARD'),
          BottomNavigationBarItem(
              icon: Icon(Icons.work_outline), label: 'INTERNSHIPS'),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart_rounded), label: 'REPORTS'),
          BottomNavigationBarItem(
              icon: Icon(Icons.verified_user_outlined),
              label: 'CERTIFICATES'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'PROFILE'),
        ],
      ),
    );
  }
}