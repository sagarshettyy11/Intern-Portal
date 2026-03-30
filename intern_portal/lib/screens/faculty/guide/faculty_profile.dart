import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

class FacultyProfilePage extends StatelessWidget {
  const FacultyProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: CommonAppBar(title: "Guide Profile", showBack: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Center(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 90,
                      height: 90,
                      color: const Color(0xFF1A5C6B),
                      child: const Icon(Icons.person, color: Colors.white, size: 54),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(color: Color(0xFF2563EB), shape: BoxShape.circle),
                      child: const Icon(Icons.settings, color: Colors.white, size: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Dr. Aristhanes Murthy',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            const Text(
              'ACADEMIC LEAD & ADMINISTRATOR',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Color(0xFF2563EB), letterSpacing: 1),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Personal Information card
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
                        // Section header
                        Row(
                          children: [
                            Icon(Icons.badge_outlined, color: const Color(0xFF2563EB), size: 20),
                            const SizedBox(width: 8),
                            const Text(
                              'Personal Information',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _InfoField(label: 'FULL NAME', value: 'Dr. Aristhanes Murthy'),
                        const SizedBox(height: 12),
                        _InfoFieldWithAction(
                          label: 'CONTACT NUMBER',
                          value: '+1 (555) 234-8901',
                          actionIcon: Icons.phone_outlined,
                        ),
                        const SizedBox(height: 12),
                        _InfoFieldWithAction(
                          label: 'EMAIL ADDRESS',
                          value: 'a.murthy@faculty.edu',
                          actionIcon: Icons.mail_outline,
                        ),
                        const SizedBox(height: 12),
                        _InfoField(label: 'DESIGNATION', value: 'Head of Department'),
                        const SizedBox(height: 12),
                        _InfoField(label: 'BRANCH', value: 'Computer Science & Engineering'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  Row(
                    children: [
                      Icon(Icons.copy_outlined, color: const Color(0xFF2563EB), size: 20),
                      const SizedBox(width: 8),
                      const Text(
                        'Academic Resources',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _ResourceItem(icon: Icons.help_outline, title: 'FAQ & Support'),
                  const SizedBox(height: 10),
                  _ResourceItem(icon: Icons.description_outlined, title: 'Internship Guidelines'),
                  const SizedBox(height: 10),
                  _ResourceItem(icon: Icons.menu_book_outlined, title: 'Student Handbook'),
                  const SizedBox(height: 22),
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
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, color: const Color(0xFF2563EB), size: 20),
                            const SizedBox(width: 8),
                            const Text(
                              'Campus Location',
                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Main Block, Level 4',
                          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87),
                        ),
                        Text('HOD Suite - Room 402', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            height: 130,
                            width: double.infinity,
                            color: const Color(0xFF1A5C6B),
                            child: CustomPaint(painter: _MapPainter()),
                          ),
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.navigation_outlined, color: Colors.white, size: 18),
                            label: const Text(
                              'Get Directions',
                              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2563EB),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              elevation: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout_rounded, color: Colors.red, size: 18),
                      label: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const _GuideBottomNav(currentIndex: 3),
    );
  }
}

class _InfoField extends StatelessWidget {
  final String label;
  final String value;
  const _InfoField({required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[500], fontWeight: FontWeight.w600, letterSpacing: 0.4),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
        ),
      ],
    );
  }
}
class _InfoFieldWithAction extends StatelessWidget {
  final String label;
  final String value;
  final IconData actionIcon;
  const _InfoFieldWithAction({required this.label, required this.value, required this.actionIcon});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 10, color: Colors.grey[500], fontWeight: FontWeight.w600, letterSpacing: 0.4),
            ),
            const SizedBox(height: 3),
            Text(
              value,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
          ],
        ),
        Icon(actionIcon, color: const Color(0xFF2563EB), size: 18),
      ],
    );
  }
}

class _ResourceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  const _ResourceItem({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(color: const Color(0xFFEFF6FF), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: const Color(0xFF2563EB), size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              '$title>',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
            ),
          ),
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

    for (double x = 0; x < size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final roadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..strokeWidth = 7;
    canvas.drawLine(Offset(0, size.height * 0.5), Offset(size.width, size.height * 0.5), roadPaint);
    canvas.drawLine(Offset(size.width * 0.4, 0), Offset(size.width * 0.4, size.height), roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}

// ── Bottom nav ────────────────────────────────────────────────────────────────

class _GuideBottomNav extends StatelessWidget {
  final int currentIndex;
  const _GuideBottomNav({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF2563EB),
        unselectedItemColor: Colors.grey[500],
        selectedLabelStyle: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(fontSize: 9),
        elevation: 0,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'DASHBOARD'),
          BottomNavigationBarItem(icon: Icon(Icons.group_outlined), label: 'STUDENTS'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'MESSAGES'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'PROFILE'),
        ],
      ),
    );
  }
}
