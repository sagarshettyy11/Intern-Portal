import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/data/student/registeration_data.dart';
import 'package:intern_portal/screens/submit_report.dart';
import 'package:intern_portal/services/users/student_services.dart';
import 'package:intern_portal/themes/status_utils.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class ReportsOverviewPage extends StatefulWidget {
  const ReportsOverviewPage({super.key});
  @override
  ReportsOverviewPageState createState() => ReportsOverviewPageState();
}

class ReportsOverviewPageState extends State<ReportsOverviewPage> {
  int _selectedFilter = 0;
  List<dynamic> reports = [];
  Map<String, dynamic>? stats;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadReports();
  }

  Future<void> loadReports() async {
    final data = await StudentServices.fetchReports();
    if (data['reports'] != null) {
      setState(() {
        reports = data['reports'];
        stats = data['stats'];
        isLoading = false;
      });
    }
  }

  List filteredReports() {
    if (_selectedFilter == 0) return reports;
    String filter = filters[_selectedFilter].toLowerCase();
    return reports.where((r) {
      return (r["display_status"] ?? "").toLowerCase().contains(filter);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: CommonAppBar(
        title: "Reports Overview",
        showBack: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black87, fontWeight: FontWeight.bold),
            onPressed: () {},
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SubmitReportPage()));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF3B6EF0),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    title: "Total Reports",
                    value: "${stats?['total'] ?? 0}",
                    badge: "${stats?['approval_rate'] ?? 0}%",
                    badgeColor: Colors.green,
                    sub: "Approved: ${stats?['approved'] ?? 0}",
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _MetricCard(
                    title: "Pending",
                    value: "${stats?['pending'] ?? 0}",
                    badge: "Waiting",
                    badgeColor: Colors.orange,
                    sub: "Needs action",
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _MetricCard(
                    title: "Overdue",
                    value: "${stats?['overdue'] ?? 0}",
                    badge: "Late",
                    badgeColor: Colors.red,
                    sub: "Missed deadline",
                  ),
                ),
              ],
            ),
            SizedBox(height: 14),
            SizedBox(
              height: 30,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: filters.length,
                separatorBuilder: (_, _) => SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final selected = _selectedFilter == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = i),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: selected ? Color(0xFF3B6EF0) : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        filters[i],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: selected ? Colors.white : Colors.grey[700],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 14),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: Offset(0, 2)),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Text(
                              "REPORT TYPE",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[900],
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "DUE DATE",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[900],
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Text(
                              "STATUS",
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[900],
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, color: Colors.grey[100]),
                    Expanded(
                      child: ListView.separated(
                        itemCount: filteredReports().length,
                        separatorBuilder: (_, _) => Divider(height: 1, color: Colors.grey[100], indent: 16),
                        itemBuilder: (context, i) {
                          final r = filteredReports()[i];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    r["report_type"] ?? "",
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 13,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    r["deadline_date"] ?? "",
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: getStatusBg(r["display_status"] ?? ""),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      r["display_status"] ?? "",
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: getStatusColor(r["display_status"] ?? ""),
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Showing ${reports.length} reports",
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[900]),
                ),
                Row(
                  children: [
                    _PageBtn(icon: Icons.chevron_left, isActive: false),
                    SizedBox(width: 8),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(color: Color(0xFF3B6EF0), borderRadius: BorderRadius.circular(8)),
                      child: Center(
                        child: Text(
                          "1",
                          style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    _PageBtn(icon: Icons.chevron_right, isActive: false),
                  ],
                ),
              ],
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 2,
        onTap: (index) => BottomNavController.onItemTapped(context, index),
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  final String title, value, badge, sub;
  final Color badgeColor;
  const _MetricCard({
    required this.title,
    required this.value,
    required this.badge,
    required this.badgeColor,
    required this.sub,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Text(
                value,
                style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(width: 4),
              Text(
                badge,
                style: GoogleFonts.inter(fontSize: 12, color: badgeColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 2),
          Text(
            sub,
            style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _PageBtn extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  const _PageBtn({required this.icon, required this.isActive});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, size: 18, color: Colors.grey[800], fontWeight: FontWeight.bold),
    );
  }
}
