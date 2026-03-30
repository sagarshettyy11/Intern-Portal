import 'package:flutter/material.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class HodProfilePage extends StatelessWidget {
  const HodProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Icon(Icons.grid_view_rounded, color: Colors.black87, size: 20),
            const SizedBox(width: 8),
            const Text(
              'HOD Dashboard',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 15),
            ),
          ],
        ),
        actions: [
          const Text(
            'HORIZON',
            style: TextStyle(color: Color(0xFF3B6EF0), fontWeight: FontWeight.w800, fontSize: 13, letterSpacing: 1),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black54),
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
            // Profile header
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 72,
                    height: 72,
                    color: Colors.grey[300],
                    child: Icon(Icons.person, size: 44, color: Colors.grey[600]),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dr. Aristhanes Murthy',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Text('Academic Lead & Administrator', style: TextStyle(fontSize: 13, color: Colors.grey[500])),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Personal Information card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFF0F4FF), borderRadius: BorderRadius.circular(14)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section header
                  Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: const Color(0xFF3B6EF0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.badge_outlined, color: Colors.white, size: 18),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Personal Information',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _InfoRow(label: 'FULL NAME', value: 'Dr. Aristhanes Murthy'),
                  const SizedBox(height: 12),
                  _InfoRow(label: 'CONTACT NUMBER', value: '+91 98450 12345'),
                  const SizedBox(height: 12),
                  _InfoRow(label: 'EMAIL ADDRESS', value: 'hod.cse@horizon.edu'),
                  const SizedBox(height: 12),
                  _InfoRow(label: 'DESIGNATION', value: 'Head of Department'),
                  const SizedBox(height: 12),
                  _InfoRow(label: 'BRANCH', value: 'Computer Science & Engineering'),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // Quick Links
            const Text(
              'Quick Links',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
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
                  _QuickLinkRow(icon: Icons.help_outline, title: 'FAQ & Support'),
                  Divider(height: 1, color: Colors.grey[100]),
                  _QuickLinkRow(icon: Icons.check_box_outlined, title: 'Internship Guidelines'),
                  Divider(height: 1, color: Colors.grey[100]),
                  _QuickLinkRow(icon: Icons.menu_book_outlined, title: 'Student Handbook'),
                ],
              ),
            ),
            const SizedBox(height: 22),

            // Campus Location
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Campus Location',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
                const Text(
                  'Main Block, Level 4',
                  style: TextStyle(fontSize: 13, color: Color(0xFF3B6EF0), fontWeight: FontWeight.w600),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Map card
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                height: 180,
                width: double.infinity,
                color: const Color(0xFF1A5C6B),
                child: Stack(
                  children: [
                    // Map grid
                    CustomPaint(size: const Size(double.infinity, 180), painter: _MapPainter()),
                    // Get Directions button
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: const [
                            Icon(Icons.location_on, color: Color(0xFF3B6EF0), size: 14),
                            SizedBox(width: 4),
                            Text(
                              'Get Directions',
                              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),

            // Logout button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.logout_rounded, color: Colors.red, size: 20),
                label: const Text(
                  'Logout',
                  style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.w600),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFF1F1),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: HodAppBottomNav(
        currentIndex: 4,
        onTap: (index) => HodBottomNavController.onItemTapped(context, index),
      ),
    );
  }
}

// ── Info row ──────────────────────────────────────────────────────────────────

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 10, color: Colors.grey[500], fontWeight: FontWeight.w600, letterSpacing: 0.4),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
      ],
    );
  }
}

// ── Quick link row ────────────────────────────────────────────────────────────

class _QuickLinkRow extends StatelessWidget {
  final IconData icon;
  final String title;
  const _QuickLinkRow({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(color: const Color(0xFFEFF4FF), borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: const Color(0xFF3B6EF0), size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
        ],
      ),
    );
  }
}

// ── Map painter ───────────────────────────────────────────────────────────────

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 22) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 22) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final roadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.15)
      ..strokeWidth = 8;
    canvas.drawLine(Offset(0, size.height * 0.45), Offset(size.width, size.height * 0.45), roadPaint);
    canvas.drawLine(Offset(size.width * 0.45, 0), Offset(size.width * 0.45, size.height), roadPaint);

    // Pin
    final pinPaint = Paint()..color = const Color(0xFF3B6EF0);
    canvas.drawCircle(Offset(size.width * 0.45, size.height * 0.45), 10, pinPaint);
    canvas.drawCircle(Offset(size.width * 0.45, size.height * 0.45), 6, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ── Bottom nav ────────────────────────────────────────────────────────────────

class _HodBottomNav extends StatelessWidget {
  final int currentIndex;
  const _HodBottomNav({required this.currentIndex});

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
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        elevation: 0,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: 'Students'),
          BottomNavigationBarItem(icon: Icon(Icons.person_pin_outlined), label: 'Guides'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Analytics'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
        ],
      ),
    );
  }
}
