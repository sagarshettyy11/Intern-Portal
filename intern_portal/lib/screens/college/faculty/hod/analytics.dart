import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/hod/analytics_model.dart';
import 'package:intern_portal/screens/college/faculty/hod/hod_profile.dart';
import 'package:intern_portal/services/users/hod_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});
  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ['All Students', 'Ongoing', 'Unassigned', 'Completed'];
  AnalyticsResponse? analytics;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAnalytics();
  }

  Future<void> loadAnalytics({String search = '', String batch = '', String year = ''}) async {
    if (analytics == null) {
      setState(() => isLoading = true);
    }
    final res = await HodServices.fetchAnalytics(search: search, batch: batch, year: year);
    setState(() {
      analytics = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F8),
      appBar: CommonAppBar(
        showLogo: true,
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => HodProfilePage()));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircleAvatar(radius: 16, child: Icon(Icons.person, size: 18, color: Colors.black)),
            ),
          ),
        ],
      ),
      body: Stack(
  children: [
    SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatsRow(),
          const SizedBox(height: 24),
          _buildSectionHeader(),
          const SizedBox(height: 14),
          _buildSearchBar(),
          const SizedBox(height: 14),
          _buildFilterTabs(),
          const SizedBox(height: 16),
          ...(analytics?.students ?? []).map(
            (s) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildStudentCard(s),
            ),
          ),
        ],
      ),
    ),

    // 👇 Smooth loader (no black screen)
    if (isLoading)
      Container(
        color: Colors.black.withValues(alpha: 0.05),
        child: const Center(child: CircularProgressIndicator()),
      ),
  ],
),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF1565C0),
        child: const Icon(Icons.bar_chart, color: Colors.white),
      ),
      bottomNavigationBar: HodAppBottomNav(
        currentIndex: 3,
        onTap: (index) => HodBottomNavController.onItemTapped(context, index),
      ),
    );
  }

  Widget _buildStatsRow() {
    final stats = [
      {'label': 'TOTAL', 'value': analytics?.stats.totalReports.toString() ?? '0', 'color': const Color(0xFF1565C0)},
      {'label': 'APPROVED', 'value': analytics?.stats.approved.toString() ?? '0', 'color': const Color(0xFF2E7D32)},
      {'label': 'PENDING', 'value': analytics?.stats.pending.toString() ?? '0', 'color': const Color(0xFFF57C00)},
      {'label': 'REJECTED', 'value': analytics?.stats.rejected.toString() ?? '0', 'color': const Color(0xFFC62828)},
    ];
    return Row(
      children: List.generate(stats.length, (i) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < stats.length - 1 ? 8 : 0),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 4, offset: const Offset(0, 2)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  stats[i]['label'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w700,
                    color: Colors.grey[500],
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  stats[i]['value'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: stats[i]['color'] as Color,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildSectionHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Students Overview',
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF4FF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF90CAF9)),
          ),
          child: Row(
            children: [
              Text(
                'BATCH 2024',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1565C0),
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(width: 4),
              Icon(Icons.keyboard_arrow_down, color: Color(0xFF1565C0), size: 16),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 4)],
      ),
      child: TextField(
        onChanged: (value) {
          loadAnalytics(search: value);
        },
        decoration: InputDecoration(
          hintText: 'Search by name or USN...',
          hintStyle: GoogleFonts.inter(color: Colors.grey[400], fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Colors.grey[400], size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
        ),
      ),
    );
  }

  Widget _buildFilterTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(_filters.length, (i) {
          final isSelected = _selectedFilter == i;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () {
                setState(() => _selectedFilter = i);
                String filter = _filters[i];
                if (filter == 'Ongoing') {
                  loadAnalytics(search: 'ongoing');
                } else if (filter == 'Completed') {
                  loadAnalytics(search: 'completed');
                } else if (filter == 'Unassigned') {
                  loadAnalytics(search: 'not applied');
                } else {
                  loadAnalytics();
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF1565C0) : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: isSelected ? const Color(0xFF1565C0) : Colors.grey[300]!),
                ),
                child: Text(
                  _filters[i],
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : Colors.black54,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStudentCard(StudentModel student) {
    final statusConfig = _statusConfig(student.status);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(color: const Color(0xFFEFF4FF), borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      student.initials,
                      style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1565C0)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              student.name,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          _buildStatusBadge(student.status, statusConfig['bg'] as Color, statusConfig['text'] as Color),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${student.usn}  •  ${student.batch}',
                        style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[500]),
                      ),
                      const SizedBox(height: 6),
                      _buildIconText(Icons.email_outlined, student.email),
                      const SizedBox(height: 3),
                      _buildIconText(Icons.phone_outlined, student.phone),
                    ],
                  ),
                ),
              ],
            ),

            if (student.company != null) ...[
              const SizedBox(height: 12),
              Text(
                student.company!,
                style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF1565C0), fontWeight: FontWeight.w600),
              ),
              Text(student.role ?? 'No Role', style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600])),
            ],
            const SizedBox(height: 12),
            if (student.hasReports && student.total != null) ...[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(color: const Color(0xFFF8F9FB), borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildMiniStat('TOTAL', student.total.toString(), Colors.black87),
                    _verticalDivider(),
                    _buildMiniStat('APPROV.', student.approved!.toString().padLeft(2, '0'), const Color(0xFF2E7D32)),
                    _verticalDivider(),
                    _buildMiniStat('PEND.', student.pending!.toString().padLeft(2, '0'), const Color(0xFFF57C00)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.chevron_right, size: 18),
                  label: const Text('VIEW REPORTS'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1565C0),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    textStyle: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700, letterSpacing: 0.5),
                  ),
                ),
              ),
            ] else ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FB),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey[200]!, style: BorderStyle.solid),
                ),
                child: Column(
                  children: [
                    Icon(Icons.info_outline, color: Colors.grey[400], size: 22),
                    const SizedBox(height: 6),
                    Text('No active reports found', style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[500])),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 13, color: Colors.grey[500]),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600]),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildMiniStat(String label, String value, Color valueColor) {
    return Column(
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w700,
            color: Colors.grey[500],
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: valueColor),
        ),
      ],
    );
  }

  Widget _verticalDivider() {
    return Container(width: 1, height: 30, color: Colors.grey[200]);
  }

  Widget _buildStatusBadge(String label, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(
        label,
        style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: textColor, letterSpacing: 0.3),
      ),
    );
  }

  Map<String, Color> _statusConfig(String status) {
    switch (status) {
      case 'ONGOING':
        return {'bg': const Color(0xFFFFF3E0), 'text': const Color(0xFFE65100)};
      case 'NOT APPLIED':
        return {'bg': const Color(0xFFFFEBEE), 'text': const Color(0xFFC62828)};
      case 'COMPLETED':
        return {'bg': const Color(0xFFE8F5E9), 'text': const Color(0xFF2E7D32)};
      default:
        return {'bg': const Color(0xFFEEEEEE), 'text': Colors.grey};
    }
  }
}
