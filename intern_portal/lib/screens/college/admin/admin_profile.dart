import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/models/admin/profile_model.dart';
import 'package:intern_portal/services/users/admin_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

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

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});
  @override
  State<AdminProfileScreen> createState() => _HodProfileScreenState();
}

class _HodProfileScreenState extends State<AdminProfileScreen> {
  AdminProfile? profile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final data = await AdminServices.fetchAdminProfile();
    setState(() {
      profile = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: kBg,
      appBar: CommonAppBar(title: "Admin Profile", showBack: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _ProfileHeader(profile: profile!),
                    const SizedBox(height: 20),
                    _PersonalInfoCard(profile: profile!),
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
          ],
        ),
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  final AdminProfile profile;

  const _ProfileHeader({required this.profile});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.person, size: 44),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(profile.name, style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800)),
              const SizedBox(height: 4),
              Text(profile.designation, style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w700)),
            ],
          ),
        ),
      ],
    );
  }
}

class _PersonalInfoCard extends StatelessWidget {
  final AdminProfile profile;
  const _PersonalInfoCard({required this.profile});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Personal Information", style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87)),
          const SizedBox(height: 16),
          _InfoRow(label: 'FULL NAME', value: profile.name),
          const SizedBox(height: 14),
          _InfoRow(label: 'CONTACT NUMBER', value: profile.phone),
          const SizedBox(height: 14),
          _InfoRow(label: 'EMAIL ADDRESS', value: profile.email),
          const SizedBox(height: 14),
          _InfoRow(label: 'DESIGNATION', value: profile.designation),
          const SizedBox(height: 14),
          _InfoRow(label: 'DEPARTMENT', value: profile.department),
          const SizedBox(height: 14),
          _InfoRow(label: 'COLLEGE', value: profile.college),
          const SizedBox(height: 14),
          _InfoRow(label: 'ADDRESS', value: profile.address),
          const SizedBox(height: 14),
          _InfoRow(label: 'WEBSITE', value: profile.website),
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
          style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: Colors.grey[800], letterSpacing: 0.6),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black87),
        ),
      ],
    );
  }
}

class _QuickLinksSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Links',
          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        ..._quickLinks.map((link) => _QuickLinkRow(icon: link.icon, label: link.label)),
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
          color: kCardBg,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 4, offset: const Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(color: kCardBg, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, color: kPrimary, size: 20),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.black87),
              ),
            ),
            const Icon(Icons.chevron_right, color: kMuted, size: 22),
          ],
        ),
      ),
    );
  }
}

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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: kText),
            ),
            Spacer(),
            Text(
              'MAIN BLOCK, LEVEL 4',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: kPrimary, letterSpacing: 0.5),
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
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
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
                            style: TextStyle(color: kText, fontWeight: FontWeight.w600, fontSize: 13),
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

class _MapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = const Color(0xFF6B9E78));
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
    canvas.drawLine(Offset(0, size.height * 0.35), Offset(size.width, size.height * 0.35), roadPaint);
    canvas.drawLine(Offset(0, size.height * 0.65), Offset(size.width, size.height * 0.65), roadPaint);
    canvas.drawLine(Offset(size.width * 0.3, 0), Offset(size.width * 0.3, size.height), roadPaint);
    canvas.drawLine(Offset(size.width * 0.65, 0), Offset(size.width * 0.65, size.height), roadPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(color: kRedBg, borderRadius: BorderRadius.circular(14)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.logout, color: kRed, size: 20),
            SizedBox(width: 8),
            Text(
              'Logout',
              style: TextStyle(color: kRed, fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
