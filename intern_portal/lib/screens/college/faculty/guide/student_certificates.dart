import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/guide/guide_certificate_model.dart';
import 'package:intern_portal/screens/college/faculty/guide/faculty_profile.dart';
import 'package:intern_portal/services/users/guide_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class CertificatesPage extends StatefulWidget {
  const CertificatesPage({super.key});
  @override
  State<CertificatesPage> createState() => _CertificatesPageState();
}

class _CertificatesPageState extends State<CertificatesPage> {
  List<GuideCertificate> certificates = [];
  ACFilterTab _selectedTab = ACFilterTab.all;
  GuideCertificateStats? stats;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCertificates();
  }

  Future<void> loadCertificates() async {
    final res = await GuideServices.fetchCertificates(
      search: '',
      status: _selectedTab == ACFilterTab.issued
          ? 'Issued'
          : _selectedTab == ACFilterTab.pending
          ? 'Pending'
          : '',
    );

    setState(() {
      certificates = res?.certificates ?? [];
      stats = res?.stats;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(
        showLogo: true,
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => FacultyProfilePage()));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircleAvatar(radius: 16, child: Icon(Icons.person, size: 18, color: Colors.black)),
            ),
          ),
        ],
      ),
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
                    _buildStatsRow(),
                    const SizedBox(height: 20),
                    _buildSearchBar(),
                    const SizedBox(height: 16),
                    _buildTabRow(),
                    const SizedBox(height: 24),
                    _buildSectionHeader(),
                    const SizedBox(height: 14),
                    _buildCertificatesList(),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GuideAppBottomNav(
        currentIndex: 3,
        onTap: (index) => GuideBottomNavController.onItemTapped(context, index),
      ),
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        _buildStatCard(label: 'TOTAL', value: '${stats?.total ?? 0}', valueColor: const Color(0xFF1A56DB)),
        const SizedBox(width: 10),
        _buildStatCard(label: 'ISSUED', value: '${stats?.issued ?? 0}', valueColor: const Color(0xFF16A34A)),
        const SizedBox(width: 10),
        _buildStatCard(label: 'PENDING', value: '${stats?.pending ?? 0}', valueColor: const Color(0xFFEA580C)),
      ],
    );
  }

  Widget _buildStatCard({required String label, required String value, required Color valueColor}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9CA3AF),
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: valueColor, height: 1.0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          SizedBox(width: 14),
          Icon(Icons.search, color: Color(0xFF9CA3AF), size: 20),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              style: GoogleFonts.inter(fontSize: 14, color: Color(0xFF111827)),
              decoration: InputDecoration(
                hintText: 'Search by student name or ID',
                hintStyle: GoogleFonts.inter(fontSize: 14, color: Color(0xFF9CA3AF)),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildTabChip('All', ACFilterTab.all),
          const SizedBox(width: 10),
          _buildTabChip('Issued', ACFilterTab.issued),
          const SizedBox(width: 10),
          _buildTabChip('Pending', ACFilterTab.pending),
        ],
      ),
    );
  }

  Widget _buildTabChip(String label, ACFilterTab tab) {
    final bool isSelected = _selectedTab == tab;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = tab;
          isLoading = true;
        });
        loadCertificates();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A56DB) : Colors.white,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: isSelected ? const Color(0xFF1A56DB) : const Color(0xFFE5E7EB)),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : const Color(0xFF6B7280),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(color: const Color(0xFF1A56DB), borderRadius: BorderRadius.circular(8)),
          child: const Icon(Icons.verified_outlined, color: Colors.white, size: 18),
        ),
        const SizedBox(width: 10),
        Text(
          'Recent Certificates',
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
        ),
      ],
    );
  }

  Widget _buildCertificatesList() {
    List<Widget> items = [];
    for (final cert in certificates) {
      items.add(_buildCertificateCard(cert));
      items.add(const SizedBox(height: 16));
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: items);
  }

  Widget _buildCertificateCard(GuideCertificate cert) {
    final isIssued = cert.status == 'Issued';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Name + badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cert.name,
                      style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700, color: Color(0xFF111827)),
                    ),
                    const SizedBox(height: 2),
                    Text('ID: ${cert.regNo}', style: GoogleFonts.inter(fontSize: 12, color: Color(0xFF9CA3AF))),
                  ],
                ),
              ),
              _buildStatusBadge(isIssued),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow(icon: Icons.business, label: 'COMPANY', value: cert.company),
          const SizedBox(height: 10),
          _buildInfoRow(icon: Icons.work_outline, label: 'DOMAIN / ROLE', value: "${cert.domain} • ${cert.role}"),
          if (cert.duration.isNotEmpty) ...[
            const SizedBox(height: 10),
            _buildInfoRow(icon: Icons.calendar_today_outlined, label: 'DURATION', value: cert.duration),
          ],
          if (isIssued && cert.verificationId != null) ...[
            const SizedBox(height: 14),
            _buildVerificationRow(verificationId: cert.verificationId!, issuedDate: cert.issuedDate ?? ''),
          ],
          const SizedBox(height: 14),
          // Action buttons
          if (isIssued) _buildIssuedActions() else _buildPendingAction(),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(bool isIssued) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isIssued ? const Color(0xFFDCFCE7) : const Color(0xFFFEF3C7),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        isIssued ? 'ISSUED' : 'PENDING',
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: isIssued ? const Color(0xFF16A34A) : const Color(0xFF92400E),
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(color: const Color(0xFFEEF2FF), borderRadius: BorderRadius.circular(8)),
          child: Icon(icon, color: const Color(0xFF1A56DB), size: 17),
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Color(0xFF9CA3AF),
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVerificationRow({required String verificationId, required String issuedDate}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(color: const Color(0xFFF3F4F6), borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'VERIFICATION ID',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF9CA3AF),
                  letterSpacing: 0.7,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                verificationId,
                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1A56DB)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'ISSUED DATE',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF9CA3AF),
                  letterSpacing: 0.7,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                issuedDate,
                style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildIssuedActions() {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.remove_red_eye_outlined, size: 18, color: Color(0xFF1A56DB)),
            label: Text(
              'View',
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1A56DB)),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              side: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download_outlined, size: 18, color: Colors.white),
            label: Text(
              'Download',
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A56DB),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 12),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPendingAction() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () {},
        icon: const Icon(Icons.list_alt_outlined, size: 18, color: Color(0xFF1A56DB)),
        label: Text(
          'Review Details',
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1A56DB)),
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 13),
          side: const BorderSide(color: Color(0xFFE5E7EB), width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }
}
