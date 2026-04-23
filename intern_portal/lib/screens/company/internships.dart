import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

enum RequestStatus { pending, verified, approved }

class InternRequest {
  final String name;
  final String studentId;
  final RequestStatus headerStatus;
  final String faculty;
  final String role;
  final IconData roleIcon;
  final String startDate;
  final String endDate;
  final String guideStatus;
  final Color guideStatusColor;
  final Color guideStatusBg;
  final String appliedOn;
  final String actionType;

  const InternRequest({
    required this.name,
    required this.studentId,
    required this.headerStatus,
    required this.faculty,
    required this.role,
    required this.roleIcon,
    required this.startDate,
    required this.endDate,
    required this.guideStatus,
    required this.guideStatusColor,
    required this.guideStatusBg,
    required this.appliedOn,
    required this.actionType,
  });
}

class InternshipRequestsScreen extends StatefulWidget {
  const InternshipRequestsScreen({super.key});
  @override
  State<InternshipRequestsScreen> createState() => _InternshipRequestsScreenState();
}

class _InternshipRequestsScreenState extends State<InternshipRequestsScreen> {
  final TextEditingController _searchController = TextEditingController();
  static const Color kBlue = Color(0xFF1B3FAB);
  static const Color kDark = Color(0xFF14142B);
  static const Color kGrey = Color(0xFF9A9CB0);

  final List<InternRequest> _requests = const [
    InternRequest(
      name: 'Alex Thompson',
      studentId: 'ID: ST-8829',
      headerStatus: RequestStatus.pending,
      faculty: 'Faculty of Tech • Computer Science',
      role: 'DevOps Engineer Role',
      roleIcon: Icons.desktop_windows_outlined,
      startDate: 'Aug 15, 2024',
      endDate: 'Dec 20, 2024',
      guideStatus: 'PENDING',
      guideStatusColor: Color(0xFF1B3FAB),
      guideStatusBg: Color(0xFFE8EDFF),
      appliedOn: 'Jul 10, 2024',
      actionType: 'approve_reject',
    ),
    InternRequest(
      name: 'Maya Rodriguez',
      studentId: 'ID: ST-9011',
      headerStatus: RequestStatus.verified,
      faculty: 'Business School • Analytics',
      role: 'Data Analyst Intern',
      roleIcon: Icons.trending_up_rounded,
      startDate: 'Sep 01, 2024',
      endDate: 'Nov 30, 2024',
      guideStatus: 'APPROVED',
      guideStatusColor: Color(0xFF1E8A4C),
      guideStatusBg: Color(0xFFE6F7ED),
      appliedOn: 'Aug 05, 2024',
      actionType: 'review',
    ),
    InternRequest(
      name: 'Jordan Lee',
      studentId: 'ID: ST-4432',
      headerStatus: RequestStatus.approved,
      faculty: 'Design Dept • UI/UX',
      role: 'Product Designer Role',
      roleIcon: Icons.palette_outlined,
      startDate: 'Oct 01, 2024',
      endDate: 'Jan 15, 2025',
      guideStatus: 'APPROVED',
      guideStatusColor: Color(0xFF1E8A4C),
      guideStatusBg: Color(0xFFE6F7ED),
      appliedOn: 'Sep 12, 2024',
      actionType: 'processing',
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.fromLTRB(16, 6, 16, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _statsRow(),
            const SizedBox(height: 16),
            _searchBar(),
            const SizedBox(height: 20),
            _sectionHeader(),
            const SizedBox(height: 14),
            ..._requests.map(_buildRequestCard),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kBlue,
        elevation: 4,
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      bottomNavigationBar: CompanyAppBottomNav(
        currentIndex: 4,
        onTap: (index) => CompanyBottomNavController.onItemTapped(context, index),
      ),
    );
  }

  Widget _statsRow() {
    return Row(
      children: [
        _statCard('12', 'PENDING', numColor: const Color(0xFF1B3FAB), bg: Colors.white),
        const SizedBox(width: 8),
        _statCard('45', 'APPROVED', numColor: const Color(0xFFA07830), bg: const Color(0xFFFFF8EE)),
        const SizedBox(width: 8),
        _statCard('08', 'REJECTED', numColor: const Color(0xFFCC2222), bg: const Color(0xFFFFEEEE)),
        const SizedBox(width: 8),
        _statCard('05', 'GUIDE APP.', numColor: const Color(0xFF555770), bg: const Color(0xFFF0F0F4)),
      ],
    );
  }

  Widget _statCard(String value, String label, {required Color numColor, required Color bg}) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: numColor),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 9.5,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, 2)),
              ],
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search student or ID...',
                hintStyle: GoogleFonts.inter(color: Colors.grey[800], fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.grey[800], size: 20),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, 2)),
            ],
          ),
          child: const Icon(Icons.tune_rounded, color: kGrey, size: 22),
        ),
      ],
    );
  }

  Widget _sectionHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LIVE APPLICATIONS',
              style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: Color(0xFF1B3FAB)),
            ),
            SizedBox(height: 2),
            Text(
              'Active Requests',
              style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: kDark),
            ),
          ],
        ),
        const Spacer(),
        Padding(
          padding: EdgeInsets.only(bottom: 4),
          child: Text(
            '65 Total',
            style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[800], fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildRequestCard(InternRequest r) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 3))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(radius: 26),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    r.name,
                    style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800, color: kDark),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    r.studentId,
                    style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[800], fontWeight: FontWeight.w800),
                  ),
                ],
              ),
              const Spacer(),
              _headerBadge(r.headerStatus),
            ],
          ),
          const SizedBox(height: 14),
          _iconRow(Icons.school_outlined, r.faculty),
          const SizedBox(height: 6),
          _iconRow(r.roleIcon, r.role),
          const SizedBox(height: 14),
          Row(
            children: [_dateCol('START DATE', r.startDate), const SizedBox(width: 24), _dateCol('END DATE', r.endDate)],
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'GUIDE STATUS',
                    style: GoogleFonts.inter(fontSize: 9.5, fontWeight: FontWeight.w800, color: Colors.grey[800]),
                  ),
                  const SizedBox(height: 4),
                  _guideBadge(r.guideStatus, r.guideStatusColor, r.guideStatusBg),
                ],
              ),
              const SizedBox(width: 24),
              _dateCol('APPLIED ON', r.appliedOn),
            ],
          ),
          const SizedBox(height: 16),
          _actionButtons(r.actionType),
        ],
      ),
    );
  }

  Widget _iconRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 17, color: Colors.grey[800]),
        const SizedBox(width: 8),
        Text(
          text,
          style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[800], fontWeight: FontWeight.w800),
        ),
      ],
    );
  }

  Widget _dateCol(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 9.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.6,
            color: Colors.grey[800],
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: GoogleFonts.inter(fontSize: 13.5, fontWeight: FontWeight.w800, color: kDark),
        ),
      ],
    );
  }

  Widget _headerBadge(RequestStatus status) {
    switch (status) {
      case RequestStatus.pending:
        return _badge('PENDING', color: kBlue, bg: const Color(0xFFE8EDFF), border: kBlue);
      case RequestStatus.verified:
        return _badge('VERIFIED', color: kBlue, bg: const Color(0xFFE8EDFF), border: kBlue);
      case RequestStatus.approved:
        return _badge(
          'APPROVED',
          color: const Color(0xFF8A6000),
          bg: const Color(0xFFFFF0CC),
          border: const Color(0xFFD4A017),
        );
    }
  }

  Widget _badge(String text, {required Color color, required Color bg, required Color border}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: border.withValues(alpha: 0.4), width: 1),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w800, color: color, letterSpacing: 0.3),
      ),
    );
  }

  Widget _guideBadge(String text, Color color, Color bg) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(
        text,
        style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, color: color, letterSpacing: 0.3),
      ),
    );
  }

  Widget _actionButtons(String type) {
    switch (type) {
      case 'approve_reject':
        return Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 44,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: Color(0xFFDDDEE8)),
                    backgroundColor: const Color(0xFFF6F7FA),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text(
                    'View',
                    style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w800, color: Color(0xFF14142B)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            _circleActionBtn(icon: Icons.close, iconColor: const Color(0xFFCC2222), bg: const Color(0xFFFFEEEE)),
            const SizedBox(width: 10),
            _circleActionBtn(icon: Icons.check, iconColor: const Color(0xFF1E8A4C), bg: const Color(0xFFE6F7ED)),
          ],
        );

      case 'review':
        return SizedBox(
          width: double.infinity,
          height: 46,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: kBlue,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(
              'Review Placement',
              style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        );
      case 'processing':
      default:
        return Container(
          width: double.infinity,
          height: 44,
          decoration: BoxDecoration(color: const Color(0xFFF6F7FA), borderRadius: BorderRadius.circular(12)),
          alignment: Alignment.center,
          child: Text(
            'Processing...',
            style: GoogleFonts.inter(fontSize: 14, color: kGrey, fontWeight: FontWeight.w500),
          ),
        );
    }
  }

  Widget _circleActionBtn({required IconData icon, required Color iconColor, required Color bg}) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
      child: Icon(icon, color: iconColor, size: 20, fontWeight: FontWeight.w800),
    );
  }
}
