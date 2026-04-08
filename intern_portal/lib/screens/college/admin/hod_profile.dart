import 'package:flutter/material.dart';

void main() {
  runApp(const HorizonApp());
}

// ─── App Root ────────────────────────────────────────────────────────────────

class HorizonApp extends StatelessWidget {
  const HorizonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HOD Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A56DB)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const HodProfileScreen(),
    );
  }
}

// ─── Constants ───────────────────────────────────────────────────────────────

const Color kPrimary = Color(0xFF1A56DB);
const Color kBg = Color(0xFFF0F4F8);
const Color kText = Color(0xFF0F172A);
const Color kSubText = Color(0xFF64748B);
const Color kMuted = Color(0xFF94A3B8);
const Color kCardBg = Color(0xFFEEF2FF);
const Color kWhite = Colors.white;
const Color kRedBg = Color(0xFFFEE2E2);
const Color kRed = Color(0xFFDC2626);
const Color kDivider = Color(0xFFE2E8F0);

// ─── Data ────────────────────────────────────────────────────────────────────

class _ProfileData {
  final String fullName;
  final String role;
  final String contactNumber;
  final String email;
  final String designation;
  final String branch;

  const _ProfileData({
    required this.fullName,
    required this.role,
    required this.contactNumber,
    required this.email,
    required this.designation,
    required this.branch,
  });
}

const _ProfileData _hodProfile = _ProfileData(
  fullName: 'Dr. Aristhanes Murthy',
  role: 'Academic Lead & Administrator',
  contactNumber: '+91 98450 12345',
  email: 'hod.cse@horizon.edu',
  designation: 'Head of Department',
  branch: 'Computer Science & Engineering',
);

class _LinkItem {
  final IconData icon;
  final String label;
  const _LinkItem(this.icon, this.label);
}

final List<_LinkItem> _quickLinks = [
  _LinkItem(Icons.help_outline_rounded, 'FAQ & Support'),
  _LinkItem(Icons.description_outlined, 'Internship Guidelines'),
  _LinkItem(Icons.menu_book_outlined, 'Student Handbook'),
];

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem(this.icon, this.label);
}

final List<_NavItem> _navItems = [
  _NavItem(Icons.home_outlined, 'HOME'),
  _NavItem(Icons.people_outline, 'STUDENTS'),
  _NavItem(Icons.search, 'GUIDES'),
  _NavItem(Icons.bar_chart_outlined, 'ANALYTICS'),
  _NavItem(Icons.person_outline, 'PROFILE'),
];

// ─── Screen ──────────────────────────────────────────────────────────────────

class HodProfileScreen extends StatefulWidget {
  const HodProfileScreen({super.key});

  @override
  State<HodProfileScreen> createState() => _HodProfileScreenState();
}

class _HodProfileScreenState extends State<HodProfileScreen> {
  int _navIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBg,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _ProfileHeader(),
                    const SizedBox(height: 20),
                    _PersonalInfoCard(),
                    const SizedBox(height: 24),
                    _QuickLinksSection(),
                    const SizedBox(height: 24),
                    _CampusLocationSection(),
                    const SizedBox(height: 20),
                    _LogoutButton(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            _BottomNav(
              selectedIndex: _navIndex,
              onTap: (i) => setState(() => _navIndex = i),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Top Bar ─────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhite,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          const Icon(Icons.grid_view_rounded, color: kPrimary, size: 26),
          const SizedBox(width: 8),
          const Text(
            'HOD Dashboard',
            style: TextStyle(
              color: kPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          const Spacer(),
          const Text(
            'HORIZON',
            style: TextStyle(
              color: kPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 15,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(width: 12),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(
                Icons.notifications_outlined,
                color: kSubText,
                size: 26,
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  width: 9,
                  height: 9,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: kWhite, width: 1.5),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Profile Header ───────────────────────────────────────────────────────────

class _ProfileHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: const Color(0xFF334155),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.person, color: Colors.white70, size: 44),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _hodProfile.fullName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: kText,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _hodProfile.role,
                style: const TextStyle(fontSize: 13, color: kSubText),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Personal Info Card ───────────────────────────────────────────────────────

class _PersonalInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kCardBg,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: kPrimary,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.badge_outlined,
                  color: kWhite,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Personal Information',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: kText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _InfoRow(label: 'FULL NAME', value: _hodProfile.fullName),
          const SizedBox(height: 14),
          _InfoRow(label: 'CONTACT NUMBER', value: _hodProfile.contactNumber),
          const SizedBox(height: 14),
          _InfoRow(label: 'EMAIL ADDRESS', value: _hodProfile.email),
          const SizedBox(height: 14),
          _InfoRow(label: 'DESIGNATION', value: _hodProfile.designation),
          const SizedBox(height: 14),
          _InfoRow(label: 'BRANCH', value: _hodProfile.branch),
        ],
      ),
    );
  }
}

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
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: kMuted,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: kText,
          ),
        ),
      ],
    );
  }
}

// ─── Quick Links ──────────────────────────────────────────────────────────────

class _QuickLinksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Links',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: kText,
          ),
        ),
        const SizedBox(height: 12),
        ..._quickLinks
            .map((link) => _QuickLinkRow(icon: link.icon, label: link.label)),
      ],
    );
  }
}

class _QuickLinkRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickLinkRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: kCardBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: kPrimary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: kText,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: kMuted, size: 22),
          ],
        ),
      ),
    );
  }
}

// ─── Campus Location ──────────────────────────────────────────────────────────

class _CampusLocationSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Text(
              'Campus Location',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: kText,
              ),
            ),
            Spacer(),
            Text(
              'MAIN BLOCK, LEVEL 4',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: kPrimary,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 180,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                CustomPaint(painter: _MapPainter()),
                Positioned(
                  bottom: 14,
                  right: 14,
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.12),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.location_on, color: kPrimary, size: 18),
                          SizedBox(width: 6),
                          Text(
                            'Get Directions',
                            style: TextStyle(
                              color: kText,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
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

// ─── Map Painter ──────────────────────────────────────────────────────────────

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = const Color(0xFF6B9E78),
    );

    final gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.18)
      ..strokeWidth = 1.0;

    for (double y = 0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    for (double x = 0; x < size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }

    final roadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..strokeWidth = 4.0;

    canvas.drawLine(
      Offset(0, size.height * 0.35),
      Offset(size.width, size.height * 0.35),
      roadPaint,
    );
    canvas.drawLine(
      Offset(0, size.height * 0.65),
      Offset(size.width, size.height * 0.65),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.3, 0),
      Offset(size.width * 0.3, size.height),
      roadPaint,
    );
    canvas.drawLine(
      Offset(size.width * 0.65, 0),
      Offset(size.width * 0.65, size.height),
      roadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─── Logout Button ────────────────────────────────────────────────────────────

class _LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: kRedBg,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: kRed, size: 20),
            SizedBox(width: 8),
            Text(
              'Logout',
              style: TextStyle(
                color: kRed,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Bottom Nav ───────────────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _BottomNav({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kWhite,
        border: Border(top: BorderSide(color: kDivider)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_navItems.length, (i) {
          final selected = i == selectedIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                selected
                    ? Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: kPrimary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(_navItems[i].icon, size: 20, color: kWhite),
                      )
                    : Icon(_navItems[i].icon, size: 24, color: kMuted),
                const SizedBox(height: 4),
                Text(
                  _navItems[i].label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                    color: selected ? kPrimary : kMuted,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}