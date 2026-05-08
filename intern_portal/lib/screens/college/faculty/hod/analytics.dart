import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/hod/analytics_model.dart';
import 'package:intern_portal/models/hod/student_model.dart';
import 'package:intern_portal/screens/college/faculty/hod/hod_profile.dart';
import 'package:intern_portal/screens/college/faculty/hod/student_analytics.dart';
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
  String selectedBatch = '2022-2026';
  final List<String> _filters = ['All Students', 'Ongoing', 'Pending', 'Completed'];

  AnalyticsResponse? analytics;
  List<GuideModel> guides = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadAnalytics();
    loadGuides();
  }

  Future<void> loadGuides() async {
    final res = await HodServices.fetchGuides();
    setState(() {
      guides = res;
    });
  }

  Future<void> loadAnalytics({String search = '', String batch = '', String year = '', String status = ''}) async {
    if (analytics == null) {
      setState(() => isLoading = true);
    }
    final res = await HodServices.fetchAnalytics(search: search, batch: batch, year: year, status: status);
    setState(() {
      analytics = res;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F5F8),
      appBar: CommonAppBar(showLogo: true),
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
                  (s) => Padding(padding: const EdgeInsets.only(bottom: 16), child: _buildStudentCard(s)),
                ),
              ],
            ),
          ),
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
                    fontWeight: FontWeight.w800,
                    color: Colors.grey[800],
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  stats[i]['value'] as String,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
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
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF4FF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF90CAF9)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedBatch,
              icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF1565C0)),
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1565C0),
                letterSpacing: 0.4,
              ),
              items: [
                '2022-2026',
                '2023-2027',
                '2024-2028',
                '2025-2029',
              ].map((batch) => DropdownMenuItem(value: batch, child: Text(batch))).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    selectedBatch = value;
                  });
                  loadAnalytics(batch: value);
                }
              },
            ),
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
          hintStyle: GoogleFonts.inter(color: Colors.grey[600], fontSize: 14, fontWeight: FontWeight.w800),
          prefixIcon: Icon(Icons.search, color: Colors.grey[600], size: 20, fontWeight: FontWeight.w800),
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
                  loadAnalytics(status: 'ongoing');
                } else if (filter == 'Completed') {
                  loadAnalytics(status: 'completed');
                } else if (filter == 'Pending') {
                  loadAnalytics(status: 'not applied');
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
                  border: Border.all(color: isSelected ? const Color(0xFF0000FF) : Colors.grey[300]!),
                ),
                child: Text(
                  _filters[i],
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
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
                      style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1565C0)),
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
                                fontWeight: FontWeight.w800,
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
                        style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[600], fontWeight: FontWeight.w800),
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
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.company!,
                          style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF1565C0), fontWeight: FontWeight.w800),
                        ),
                        Text(
                          student.role ?? 'No Role',
                          style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[800], fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _showAssignGuidePopup(student);
                    },
                    icon: const Icon(Icons.supervisor_account_rounded),
                    color: const Color(0xFF1565C0),
                    tooltip: 'Assign Guide',
                  ),
                ],
              ),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => StudentReviewScreen(studentId: student.id)),
                    );
                  },
                  icon: const Icon(Icons.chevron_right, size: 18, fontWeight: FontWeight.w800, color: Colors.white),
                  label: Text(
                    'VIEW REPORTS',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w800, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0000FF),
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

  void _showAssignGuidePopup(StudentModel student) {
    int? selectedGuide;
    final guideList = guides;
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 12),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.95,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.supervisor_account_rounded, color: Color(0xFF1565C0)),
                          const SizedBox(width: 8),
                          Text("Assign Guide", style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w800)),
                        ],
                      ),
                      const SizedBox(height: 18),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F7FB),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: const Color(0xFFE3F2FD),
                              child: Text(
                                student.initials,
                                style: GoogleFonts.inter(fontWeight: FontWeight.w800, color: const Color(0xFF1565C0)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    student.name,
                                    style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    student.usn,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    student.company ?? 'No Company',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: const Color(0xFF1565C0),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 18),
                      Text("Select Faculty Guide", style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w700)),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<int>(
                        initialValue: selectedGuide,
                        isExpanded: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[100],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        hint: const Text("Choose Guide"),
                        items: guideList.map((guide) {
                          return DropdownMenuItem<int>(
                            value: guide.id,
                            child: SizedBox(
                              width: double.infinity,
                              child: Text(
                                "${guide.name} • ${guide.designation}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setModalState(() {
                            selectedGuide = value;
                          });
                        },
                      ),
                      const SizedBox(height: 22),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: selectedGuide == null
                              ? null
                              : () async {
                                  final success = await HodServices.assignGuide(
                                    internshipId: student.id,
                                    guideId: selectedGuide!,
                                  );
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        success ? "Guide assigned successfully" : "Failed to assign guide",
                                        style: GoogleFonts.inter(),
                                      ),
                                    ),
                                  );
                                  if (success) {
                                    loadAnalytics();
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0000FF),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: Text(
                            "ASSIGN GUIDE",
                            style: GoogleFonts.inter(fontWeight: FontWeight.w800, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildIconText(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 13, color: Colors.grey[600], fontWeight: FontWeight.w800),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w800),
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
            fontWeight: FontWeight.w800,
            color: Colors.grey[700],
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
    switch (status.toUpperCase()) {
      case 'ONGOING':
        return {'bg': Colors.orange.shade100, 'text': Colors.orange.shade800};
      case 'PENDING':
        return {'bg': Colors.red.shade100, 'text': Colors.red.shade800};
      case 'COMPLETED':
        return {'bg': Colors.green.shade100, 'text': Colors.green.shade800};
      default:
        return {'bg': Colors.grey.shade300, 'text': Colors.grey};
    }
  }
}
