import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/screens/college/students/profile.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class CertificatesScreen extends StatefulWidget {
  const CertificatesScreen({super.key});
  @override
  State<CertificatesScreen> createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends State<CertificatesScreen> {
  static const Color kBlue      = Color(0xFF1B3FAB);
  static const Color kBlueLight = Color(0xFFDDE5FF);
  static const Color kDark      = Color(0xFF14142B);
  static const Color kGrey      = Color(0xFF9A9CB0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F4FF),
      appBar: CommonAppBar(
        showBack: false,
        showLogo: true,
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircleAvatar(radius: 16, child: Icon(Icons.person, size: 18, color: Colors.black)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _statsRow(),
            const SizedBox(height: 28),
            _sectionHeader(),
            const SizedBox(height: 14),
            _certificateCard(),
            const SizedBox(height: 14),
            _emptyCard(),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 3,
        onTap: (index) => StudentBottomNavController.onItemTapped(context, index),
      ),
    );
  }

  Widget _statsRow() {
    return Row(
      children: [
        _statTile('1', 'TOTAL'),
        const SizedBox(width: 10),
        _statTile('1', 'ISSUED'),
        const SizedBox(width: 10),
        _statTile('0', 'PENDING'),
      ],
    );
  }

  Widget _statTile(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: const Color(0xFFF0F2F5),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: kDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.8,
                color: kGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(Icons.verified, color: kBlue, size: 24),
            SizedBox(width: 8),
            Text(
              'Issued Certificates',
              style: GoogleFonts.inter(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: kDark,
              ),
            ),
          ],
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: kBlueLight,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Newest First',
            style: GoogleFonts.inter(
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              color: kBlue,
            ),
          ),
        ),
      ],
    );
  }

  Widget _certificateCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  color: const Color(0xFFE8EDFF),
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'TE',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: kBlue,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TechCorp Solutions Inc.',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: kDark,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Software development',
                    style: GoogleFonts.inter(fontSize: 13.5, color: kGrey),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 22),
          _infoRow(
            icon: Icons.calendar_month_outlined,
            label: 'DURATION',
            value: '01 Mar 2026 to 25 Apr 2026',
          ),
          const SizedBox(height: 16),
          _infoRow(
            icon: Icons.event_available_outlined,
            label: 'ISSUED DATE',
            value: '22 Apr 2026',
          ),
          const SizedBox(height: 16),
          _infoRow(
            icon: Icons.fingerprint,
            label: 'VERIFICATION ID',
            value: 'CERT-CBED121636',
            valueColor: kBlue,
          ),
          const SizedBox(height: 22),
          Row(
            children: [
              Expanded(
                flex: 52,
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.remove_red_eye_outlined,
                        size: 19, color: Colors.white),
                    label: Text(
                      'View',
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kBlue,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 48,
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.download_outlined,
                        size: 19, color: Color(0xFF3A3C50)),
                    label: Text(
                      'Download',
                      style: GoogleFonts.inter(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF3A3C50)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF0F1F6),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 22, color: kGrey),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.9,
                color: kGrey,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14.5,
                fontWeight: FontWeight.w500,
                color: valueColor ?? kDark,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _emptyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FB),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFD8DAE8), width: 1),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: const Color(0xFFCCCDD8), width: 1.5),
                ),
              ),
              const Icon(Icons.workspace_premium_outlined,
                  size: 30, color: Color(0xFFCCCDD8)),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'No other certificates issued yet',
            style: GoogleFonts.inter(
              fontSize: 13.5,
              color: kGrey,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}