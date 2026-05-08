import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/hod/profile_model.dart';
import 'package:intern_portal/services/users/hod_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HodProfilePage extends StatefulWidget {
  const HodProfilePage({super.key});
  @override
  State<HodProfilePage> createState() => _HodProfilePageState();
}

class _HodProfilePageState extends State<HodProfilePage> {
  HodProfile? profile;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final data = await HodServices.fetchProfile();
    if (!mounted) return;
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
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: CommonAppBar(showLogo: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                      Text(
                        profile?.name ?? '',
                        style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black87),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        profile?.designation ?? "",
                        style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[800], fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: const Color(0xFFF0F4FF), borderRadius: BorderRadius.circular(14)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      Text(
                        'Personal Information',
                        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black87),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _InfoRow(label: 'FULL NAME', value: profile?.name ?? ""),
                  const SizedBox(height: 12),
                  _InfoRow(label: 'CONTACT NUMBER', value: profile?.phone ?? ""),
                  const SizedBox(height: 12),
                  _InfoRow(label: 'EMAIL ADDRESS', value: profile?.email ?? ""),
                  const SizedBox(height: 12),
                  _InfoRow(label: 'DESIGNATION', value: profile?.designation ?? ""),
                  const SizedBox(height: 12),
                  _InfoRow(label: 'BRANCH', value: profile?.department ?? ""),
                ],
              ),
            ),
            const SizedBox(height: 22),
            Text(
              'Quick Links',
              style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
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
            Text(
              'Campus Location',
              style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                height: 180,
                width: double.infinity,
                color: const Color(0xFF1A5C6B),
                child: Stack(
                  children: [
                    CustomPaint(size: const Size(double.infinity, 180)),
                    Positioned(
                      bottom: 12,
                      right: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Icon(Icons.location_on, color: Color(0xFF3B6EF0), size: 14),
                            SizedBox(width: 4),
                            Text(
                              'Get Directions',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                              ),
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
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final prefs = await SharedPreferences.getInstance();
                  await prefs.remove('token');
                  await prefs.clear();
                  Navigator.pushNamedAndRemoveUntil(context, '/UnifiedLogin', (route) => false);
                },
                icon: const Icon(Icons.logout_rounded, color: Colors.white, size: 20),
                label: Text(
                  'Logout',
                  style: GoogleFonts.inter(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w800),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0000FF),
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
          style: GoogleFonts.inter(
            fontSize: 10,
            color: Colors.grey[800],
            fontWeight: FontWeight.w800,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black87),
        ),
      ],
    );
  }
}

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
            child: Icon(icon, color: const Color(0xFF0000FF), size: 18),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.black87),
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.grey[800], size: 20),
        ],
      ),
    );
  }
}
