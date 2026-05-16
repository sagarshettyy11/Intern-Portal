import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/student/certificate_models.dart';
import 'package:intern_portal/screens/college/faculty/guide/certificate_viewer.dart';
import 'package:intern_portal/screens/college/students/notifications.dart';
import 'package:intern_portal/screens/college/students/profile.dart';
import 'package:intern_portal/services/users/student_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';
import 'package:path_provider/path_provider.dart';

class CertificatesScreen extends StatefulWidget {
  const CertificatesScreen({super.key});
  @override
  State<CertificatesScreen> createState() => _CertificatesScreenState();
}

class _CertificatesScreenState extends State<CertificatesScreen> {
  List<CertificateModel> certificates = [];
  int total = 0;
  int issued = 0;
  int pending = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCertificates();
  }

  Future<void> loadCertificates() async {
    try {
      final data = await StudentServices.fetchCertificates();
      setState(() {
        certificates = data['issued'];
        total = data['stats']['total_approved'];
        issued = data['stats']['total_issued'];
        pending = data['stats']['total_pending'];
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  void _viewCertificate(CertificateModel cert) {
    if (cert.fileUrl == null || cert.fileUrl!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Certificate not found")));
      return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (_) => CertificateViewer(fileUrl: cert.fileUrl!)));
  }

  Future<void> _downloadCertificate(CertificateModel cert) async {
    try {
      if (cert.fileUrl == null || cert.fileUrl!.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Certificate not found")));
        return;
      }
      final dir = await getExternalStorageDirectory();
      if (dir == null) {
        throw Exception("Storage directory unavailable");
      }
      final fileName = cert.fileUrl!.split('/').last;
      final savePath = "${dir.path}/$fileName";
      await Dio().download(cert.fileUrl!, savePath);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Downloaded to: $savePath")));
      }
      debugPrint("FILE SAVED AT: $savePath");
    } catch (e) {
      debugPrint("DOWNLOAD ERROR: $e");
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Download failed")));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: CommonAppBar(showLogo: true),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: Color(0xFFF0F4FF),
      appBar: CommonAppBar(
        showLogo: true,
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationsScreen()));
            },
            child: const Icon(Icons.notifications_outlined, color: Colors.black, size: 24),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _statsRow(),
            const SizedBox(height: 10),
            _sectionHeader(),
            const SizedBox(height: 14),
            if (certificates.isEmpty) _emptyCard() else ...certificates.map((c) => _certificateCard(c)),
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
        _statTile(total.toString(), 'TOTAL'),
        const SizedBox(width: 10),
        _statTile(issued.toString(), 'ISSUED'),
        const SizedBox(width: 10),
        _statTile(pending.toString(), 'PENDING'),
      ],
    );
  }

  Widget _statTile(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.8,
                color: Colors.grey[800],
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
            Icon(Icons.verified, color: Color(0xFF0000FF), size: 24),
            SizedBox(width: 8),
            Text(
              'Issued Certificates',
              style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ],
        ),
      ],
    );
  }

  Widget _certificateCard(CertificateModel c) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 14, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(color: const Color(0xFFE8EDFF), borderRadius: BorderRadius.circular(16)),
                alignment: Alignment.center,
                child: Text(
                  c.companyName.isNotEmpty
                      ? c.companyName.trim().split(' ').take(2).map((e) => e[0]).join().toUpperCase()
                      : '--',
                  style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF0000FF)),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c.companyName,
                    style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: Colors.black),
                  ),
                  SizedBox(height: 4),
                  Text(
                    c.domain ?? "-",
                    style: GoogleFonts.inter(fontSize: 13.5, color: Colors.grey[800], fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          _infoRow(
            icon: Icons.calendar_month_outlined,
            label: 'DURATION',
            value: "${c.startDate ?? ''} to ${c.endDate ?? ''}",
          ),
          const SizedBox(height: 8),
          _infoRow(icon: Icons.event_available_outlined, label: 'ISSUED DATE', value: c.issuedDate),
          const SizedBox(height: 8),
          _infoRow(
            icon: Icons.fingerprint,
            label: 'VERIFICATION ID',
            value: c.verificationId,
            valueColor: Color(0xFF0000FF),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                flex: 52,
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () => _viewCertificate(c),
                    icon: const Icon(Icons.remove_red_eye_outlined, size: 19, color: Colors.white),
                    label: Text(
                      'View',
                      style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF0000FF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 48,
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton.icon(
                    onPressed: () => _downloadCertificate(c),
                    icon: const Icon(Icons.download_outlined, size: 19, color: Color(0xFF3A3C50)),
                    label: Text(
                      'Download',
                      style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800, color: Color(0xFF3A3C50)),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF0F1F6),
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
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

  Widget _infoRow({required IconData icon, required String label, required String value, Color? valueColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, size: 22, color: Colors.grey[800]),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.9,
                color: Colors.grey[800],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: GoogleFonts.inter(fontSize: 14.5, fontWeight: FontWeight.w800, color: valueColor ?? Colors.black),
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
                  border: Border.all(color: const Color(0xFFCCCDD8), width: 1.5),
                ),
              ),
              const Icon(Icons.workspace_premium_outlined, size: 30, color: Color(0xFFCCCDD8)),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'No other certificates issued yet',
            style: GoogleFonts.inter(fontSize: 13.5, color: Colors.grey[800], fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
