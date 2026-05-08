import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/services/users/company_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyProfileScreen extends StatefulWidget {
  const CompanyProfileScreen({super.key});
  @override
  State<CompanyProfileScreen> createState() => _CompanyProfileScreenState();
}

class _CompanyProfileScreenState extends State<CompanyProfileScreen> {
  bool _acceptingApplications = true;
  bool _autoVerifyCertificates = false;
  Map<String, dynamic>? profile;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  void loadProfile() async {
    final data = await CompanyService.fetchProfile();
    setState(() {
      profile = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: CommonAppBar(showLogo: true),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProfileCard(),
                  const SizedBox(height: 16),
                  _buildGeneralInfoCard(),
                  const SizedBox(height: 16),
                  const SizedBox(height: 24),
                  _buildProgramSettings(),
                  const SizedBox(height: 12),
                  _buildLogoutButton(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
      bottomNavigationBar: CompanyAppBottomNav(
        currentIndex: 4,
        onTap: (index) => CompanyBottomNavController.onItemTapped(context, index),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFFFCC80), width: 1),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.verified, color: Color(0xFFE65100), size: 14),
                    SizedBox(width: 4),
                    Text(
                      'VERIFIED',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFE65100),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(color: const Color(0xFFF0F2F5), borderRadius: BorderRadius.circular(16)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  color: const Color(0xFF1A2A3A),
                  child: const Icon(Icons.android, color: Color(0xFF4DD0E1), size: 60),
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              profile?['name'] ?? '',
              style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black87),
            ),
            Text(
              profile?['category'] ?? '',
              style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600], fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGeneralInfoCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info, color: Color(0xFF1565C0), size: 20),
                SizedBox(width: 8),
                Text(
                  'General Information',
                  style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF0000FF)),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildInfoRow(
              icon: Icons.location_on,
              iconColor: const Color(0xFF0000FF),
              label: 'OFFICE ADDRESS',
              value: profile?['address'] ?? 'No address available',
              isLink: false,
            ),
            const SizedBox(height: 14),
            _buildInfoRow(
              icon: Icons.language,
              iconColor: const Color(0xFF0000FF),
              label: 'CONTACT PERSON',
              value: profile?['person'] ?? '',
              isLink: false,
            ),
            const SizedBox(height: 14),
            _buildInfoRow(
              icon: Icons.phone,
              iconColor: const Color(0xFF0000FF),
              label: 'PHONE',
              value: profile?['phone'] ?? '',
              isLink: false,
            ),
            const SizedBox(height: 14),
            _buildInfoRow(
              icon: Icons.contact_page_outlined,
              iconColor: const Color(0xFF0000FF),
              label: 'PRIMARY EMAIL',
              value: profile?['email'] ?? '',
              isLink: false,
            ),
            const SizedBox(height: 14),
            _buildInfoRow(
              icon: Icons.contact_page_outlined,
              iconColor: const Color(0xFF0000FF),
              label: 'COMPANY DESCRIPTION',
              value: profile?['description'] ?? 'No description available',
              isLink: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required bool isLink,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(color: const Color(0xFFEFF4FF), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: iconColor, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: isLink ? const Color(0xFF0000FF) : Colors.black87,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProgramSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PROGRAM SETTINGS',
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Colors.grey[600],
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 14),
        _buildToggleRow(
          title: 'Accepting New Applications',
          subtitle: 'Allow students to apply to active roles',
          value: _acceptingApplications,
          onChanged: (val) => setState(() => _acceptingApplications = val),
          activeColor: const Color(0xFF0000FF),
        ),
        const SizedBox(height: 6),
        Divider(color: Colors.grey[200], height: 1),
        const SizedBox(height: 6),
        _buildToggleRow(
          title: 'Auto-verify Certificates',
          subtitle: 'Automatically issue completion badges',
          value: _autoVerifyCertificates,
          onChanged: (val) => setState(() => _autoVerifyCertificates = val),
          activeColor: const Color(0xFF0000FF),
        ),
      ],
    );
  }

  Widget _buildToggleRow({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
    required Color activeColor,
  }) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.black87),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeThumbColor: Colors.white,
          activeTrackColor: activeColor,
          inactiveThumbColor: Colors.white,
          inactiveTrackColor: Colors.grey[300],
        ),
      ],
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove('token');
          await prefs.clear();
          Navigator.pushNamedAndRemoveUntil(context, '/UnifiedLogin', (route) => false);
        },
        icon: const Icon(Icons.logout, color: Colors.white, size: 18, fontWeight: FontWeight.w800),
        label: Text(
          'Logout',
          style: GoogleFonts.inter(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w800),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          side: BorderSide(color: Color(0xFF0000FF), width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          backgroundColor: Color(0xFF0000FF),
        ),
      ),
    );
  }
}
