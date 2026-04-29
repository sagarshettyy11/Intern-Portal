import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/company/certificate_model.dart';
import 'package:intern_portal/screens/company/upload_certificate.dart';
import 'package:intern_portal/services/users/company_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class CertificatesListScreen extends StatefulWidget {
  const CertificatesListScreen({super.key});
  @override
  State<CertificatesListScreen> createState() => _CertificatesListScreenState();
}

class _CertificatesListScreenState extends State<CertificatesListScreen> {
  String _activeFilter = 'All Status';
  final TextEditingController _searchCtrl = TextEditingController();
  static const _filters = ['All Status', 'Pending Upload', 'Issued'];
  List<CertificateModel> _records = [];
  CertificateStats? stats;
  bool isLoading = true;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadCertificates();
  }

  Future<void> loadCertificates() async {
    final res = await CompanyService.fetchCertificates();
    setState(() {
      _records = res?.certificates ?? [];
      stats = res?.stats;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    List<CertificateModel> filtered = _records.where((r) {
      final query = _searchCtrl.text.toLowerCase();
      final matchesSearch = r.studentName.toLowerCase().contains(query) || r.studentId.toString().contains(query);
      final matchesFilter = _activeFilter == 'All Status'
          ? true
          : _activeFilter == 'Issued'
          ? r.status == 'ISSUED'
          : r.status == 'NOT UPLOADED';
      return matchesSearch && matchesFilter;
    }).toList();

    int total = stats?.totalInterns ?? 0;
    int issued = stats?.issued ?? 0;
    int pending = stats?.pending ?? 0;

    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: CommonAppBar(
        showLogo: true,
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {},
            child: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircleAvatar(radius: 16, child: Icon(Icons.person, size: 18, color: Colors.black)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatsRow(total, issued, pending),
            const SizedBox(height: 14),
            _buildSearchBar(),
            const SizedBox(height: 12),
            _buildFilterTabs(),
            const SizedBox(height: 16),
            _buildRecentRecordsHeader(pending),
            const SizedBox(height: 12),
            if (filtered.isEmpty)
              const Center(child: Text("No certificates found"))
            else
              ...filtered.map(
                (r) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _CertificateRecordCard(record: r, onRefresh: loadCertificates),
                ),
              ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: CompanyAppBottomNav(
        currentIndex: 3,
        onTap: (index) => CompanyBottomNavController.onItemTapped(context, index),
      ),
    );
  }

  Widget _buildStatsRow(int total, int issued, int pending) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(child: _statItem('TOTAL', total.toString(), const Color(0xFF1A56DB))),
            VerticalDivider(color: Colors.grey.shade200, thickness: 1, width: 1),
            Expanded(child: _statItem('ISSUED', issued.toString(), const Color(0xFF057A55))),
            VerticalDivider(color: Colors.grey.shade200, thickness: 1, width: 1),
            Expanded(child: _statItem('PENDING', pending.toString(), const Color(0xFFE02424))),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            color: Colors.grey[800],
            fontWeight: FontWeight.w800,
            letterSpacing: 0.7,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w800, color: color),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      controller: _searchCtrl,
      onChanged: (_) => setState(() {}),
      style: GoogleFonts.inter(fontSize: 14),
      decoration: InputDecoration(
        hintText: 'Search by student name or ID...',
        hintStyle: GoogleFonts.inter(color: Colors.grey[700], fontSize: 14),
        prefixIcon: Icon(Icons.search, color: Colors.grey[700], size: 20),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFF1A56DB)),
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return Row(
      children: _filters.map((f) {
        final isActive = _activeFilter == f;
        return Padding(
          padding: const EdgeInsets.only(right: 8),
          child: GestureDetector(
            onTap: () => setState(() => _activeFilter = f),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isActive ? const Color(0xFF1A56DB) : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: isActive ? null : Border.all(color: const Color(0xFFE5E7EB)),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: const Color(0xFF1A56DB).withValues(alpha: 0.25),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : [],
              ),
              child: Text(
                f,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isActive ? Colors.white : const Color(0xFF374151),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildRecentRecordsHeader(int pending) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Recent Records',
          style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xFF111827)),
        ),
        Text(
          '$pending PENDING',
          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF1A56DB)),
        ),
      ],
    );
  }
}

class _CertificateRecordCard extends StatelessWidget {
  final CertificateModel record;
  final VoidCallback onRefresh;
  const _CertificateRecordCard({required this.record, required this.onRefresh});
  bool get _isIssued => record.status == 'ISSUED';
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _isIssued ? const Color(0xFFF9FAFB) : Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                record.studentName,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w800,
                  fontSize: 15,
                  color: _isIssued ? const Color(0xFF9CA3AF) : const Color(0xFF111827),
                ),
              ),
              _statusBadge(),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            record.studentId.toString(),
            style: GoogleFonts.inter(
              fontSize: 12,
              color: _isIssued ? const Color(0xFFD1D5DB) : const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 13,
                color: _isIssued ? const Color(0xFFD1D5DB) : const Color(0xFF9CA3AF),
              ),
              const SizedBox(width: 5),
              Text(
                record.period,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: _isIssued ? const Color(0xFFD1D5DB) : const Color(0xFF6B7280),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: _isIssued
                ? OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.verified_outlined, size: 16, color: Color(0xFF9CA3AF)),
                    label: Text(
                      'View Certificate',
                      style: GoogleFonts.inter(color: Color(0xFF9CA3AF), fontWeight: FontWeight.w800, fontSize: 14),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      side: const BorderSide(color: Color(0xFFE5E7EB)),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color(0xFFF3F4F6),
                    ),
                  )
                : ElevatedButton.icon(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => UploadCertificateScreen(record: record)),
                      );
                      onRefresh();
                    },
                    icon: const Icon(Icons.upload_rounded, color: Colors.white, size: 18),
                    label: Text(
                      'Upload',
                      style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A56DB),
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _statusBadge() {
    if (_isIssued) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(color: const Color(0xFFE5E7EB), borderRadius: BorderRadius.circular(20)),
        child: Text(
          'ISSUED',
          style: GoogleFonts.inter(color: Color(0xFF6B7280), fontSize: 11, fontWeight: FontWeight.w600),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: const Color(0xFFFFE4E4), borderRadius: BorderRadius.circular(20)),
      child: Text(
        'NOT UPLOADED',
        style: GoogleFonts.inter(color: Color(0xFFE02424), fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }
}
