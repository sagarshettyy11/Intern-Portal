import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/screens/submit_report.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class ReportsOverviewPage extends StatefulWidget {
  const ReportsOverviewPage({super.key});
  @override
  ReportsOverviewPageState createState() => ReportsOverviewPageState();
}

class ReportsOverviewPageState extends State<ReportsOverviewPage> {
  int _selectedFilter = 0;
  final List<String> _filters = ["All Reports", "Pending", "Submitted", "Approved"];
  final List<Map<String, dynamic>> _reports = [
    {
      "type": "Safety Audit Q3",
      "due": "Oct 24, 2023",
      "status": "Approved",
      "statusColor": Color(0xFF27AE60),
      "bgColor": Color(0xFFEAF7EF),
    },
    {
      "type": "Monthly Expense Review",
      "due": "Oct 20, 2023",
      "status": "Overdue",
      "statusColor": Color(0xFFE53935),
      "bgColor": Color(0xFFFFF1F1),
    },
    {
      "type": "Compliance Checklist",
      "due": "Oct 28, 2023",
      "status": "Pending",
      "statusColor": Color(0xFF3B6EF0),
      "bgColor": Color(0xFFEFF4FF),
    },
    {
      "type": "Internal Audit v1",
      "due": "Oct 22, 2023",
      "status": "Late",
      "statusColor": Color(0xFFE67E00),
      "bgColor": Color(0xFFFFF8E6),
    },
    {
      "type": "Quarterly Performance",
      "due": "Oct 25, 2023",
      "status": "Rejected",
      "statusColor": Color(0xFFE53935),
      "bgColor": Color(0xFFFFF1F1),
    },
    {
      "type": "Compliance Checklist",
      "due": "Oct 28, 2023",
      "status": "Pending",
      "statusColor": Color(0xFF3B6EF0),
      "bgColor": Color(0xFFEFF4FF),
    },
    {
      "type": "Internal Audit v2",
      "due": "Oct 22, 2023",
      "status": "Late",
      "statusColor": Color(0xFFE67E00),
      "bgColor": Color(0xFFFFF8E6),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black87),
        title: Text(
          "Reports Overview",
          style: GoogleFonts.inter(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 17),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.black87),
            onPressed: () {},
          ),
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(color: Color(0xFF3B6EF0), shape: BoxShape.circle),
            child: IconButton(
              icon: Icon(Icons.add, color: Colors.white, size: 20),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SubmitReportPage()));
              },
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey[200]),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _MetricCard(
                    title: "Daily Reports",
                    value: "24",
                    badge: "+5%",
                    badgeColor: Colors.green,
                    sub: "Target: 30 reports",
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _MetricCard(
                    title: "Weekly Trends",
                    value: "142",
                    badge: "-2%",
                    badgeColor: Colors.red,
                    sub: "Avg: 145/week",
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: _MetricCardWithProgress(
                    title: "Monthly Completion",
                    value: "92%",
                    badge: "-8%",
                    progress: 0.92,
                  ),
                ),
              ],
            ),
            SizedBox(height: 14),
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (_, _) => SizedBox(width: 8),
                itemBuilder: (context, i) {
                  final selected = _selectedFilter == i;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedFilter = i),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      decoration: BoxDecoration(
                        color: selected ? Color(0xFF3B6EF0) : Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text(
                        _filters[i],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
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
                                color: Colors.grey[500],
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
                                color: Colors.grey[500],
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
                                color: Colors.grey[500],
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
                        itemCount: _reports.length,
                        separatorBuilder: (_, _) => Divider(height: 1, color: Colors.grey[100], indent: 16),
                        itemBuilder: (context, i) {
                          final r = _reports[i];
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    r["type"],
                                    style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    r["due"],
                                    style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600]),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: (r["bgColor"] as Color),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      r["status"],
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                        color: r["statusColor"] as Color,
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
                Text("Showing 5 of 48 reports", style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500])),
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
          Text(title, style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[500])),
          SizedBox(height: 4),
          Row(
            children: [
              Text(
                value,
                style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              SizedBox(width: 4),
              Text(
                badge,
                style: GoogleFonts.inter(fontSize: 10, color: badgeColor, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 2),
          Text(sub, style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[400])),
        ],
      ),
    );
  }
}

class _MetricCardWithProgress extends StatelessWidget {
  final String title, value, badge;
  final double progress;
  const _MetricCardWithProgress({
    required this.title,
    required this.value,
    required this.badge,
    required this.progress,
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
          Text(title, style: GoogleFonts.inter(fontSize: 10, color: Colors.grey[500])),
          SizedBox(height: 4),
          Row(
            children: [
              Text(
                value,
                style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              SizedBox(width: 4),
              Text(
                badge,
                style: GoogleFonts.inter(fontSize: 10, color: Colors.red, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              color: Color(0xFF3B6EF0),
              minHeight: 4,
            ),
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
      child: Icon(icon, size: 18, color: Colors.grey[500]),
    );
  }
}
