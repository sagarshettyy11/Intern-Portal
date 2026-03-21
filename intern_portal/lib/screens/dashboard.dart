import 'package:flutter/material.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/screens/registration.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(color: Color(0xFF3B6EF0), borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.school, color: Colors.white, size: 18),
            ),
            SizedBox(width: 8),
            Text(
              "InternPortal",
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ],
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 8),
            decoration: BoxDecoration(color: Color(0xFF3B6EF0), shape: BoxShape.circle),
            child: IconButton(
              icon: Icon(Icons.add, color: Colors.white, size: 20),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const RegistrationPage()));
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.notifications_outlined, color: Colors.black87),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey[200]),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: Offset(0, 2)),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: "Good Morning, ",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                      children: [TextSpan(text: "Alex Rivera!")],
                    ),
                  ),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      text: "You are ",
                      style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                      children: [
                        TextSpan(
                          text: "75%",
                          style: TextStyle(color: Color(0xFF3B6EF0), fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: " through your internship progress."),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: 0.75,
                      backgroundColor: Colors.grey[200],
                      color: Color(0xFF3B6EF0),
                      minHeight: 6,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.assignment_outlined, size: 16, color: Colors.white),
                    label: Text(
                      "View Assignment",
                      style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF3B6EF0),
                      padding: EdgeInsets.symmetric(vertical: 13),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 0,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.calendar_month_outlined, size: 16, color: Colors.grey[700]),
                    label: Text(
                      "Weekly Log",
                      style: TextStyle(color: Colors.grey[700], fontSize: 13, fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 13),
                      side: BorderSide(color: Colors.grey[300]!),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _StatCard(
                    label: "ACTIVE INTERNSHIP",
                    value: "TechCorp Solut...",
                    valueStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    label: "PENDING REPORTS",
                    value: "02",
                    valueStyle: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF3B6EF0)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 22),
            Text(
              "Internship Journey",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 14),
            _JourneyTimeline(),
            SizedBox(height: 22),
            Text(
              "Priority Alerts",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(color: Color(0xFFFFF1F1), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Color(0xFFE53935), size: 24),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Submit Weekly Report 12",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE53935), fontSize: 14),
                        ),
                        Text("Due by end of day today", style: TextStyle(fontSize: 12, color: Color(0xFFE53935))),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Color(0xFFE53935)),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: BoxDecoration(color: Color(0xFFFFF8E6), borderRadius: BorderRadius.circular(12)),
              child: Row(
                children: [
                  Icon(Icons.access_time_rounded, color: Color(0xFFE67E00), size: 24),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mentor Meeting",
                          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFE67E00), fontSize: 14),
                        ),
                        Text("Tomorrow at 10:00 AM", style: TextStyle(fontSize: 12, color: Color(0xFFE67E00))),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Color(0xFFE67E00)),
                ],
              ),
            ),
            SizedBox(height: 22),
            Text(
              "Resources for You",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: Offset(0, 2)),
                ],
              ),
              child: Column(
                children: [
                  _ResourceItem(icon: Icons.description_outlined, title: "Guidelines", trailing: Icons.open_in_new),
                  Divider(height: 1, indent: 52),
                  _ResourceItem(
                    icon: Icons.article_outlined,
                    title: "Report Template",
                    trailing: Icons.download_outlined,
                  ),
                  Divider(height: 1, indent: 52),
                  _ResourceItem(icon: Icons.help_outline, title: "Student FAQ", trailing: Icons.chevron_right),
                  Divider(height: 1, indent: 52),
                  _ResourceItem(icon: Icons.group_outlined, title: "Peer Support", trailing: Icons.chevron_right),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 0,
        onTap: (index) => BottomNavController.onItemTapped(context, index),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle valueStyle;
  const _StatCard({required this.label, required this.value, required this.valueStyle});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 10, color: Colors.grey[500], fontWeight: FontWeight.w600, letterSpacing: 0.5),
          ),
          SizedBox(height: 6),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}

class _JourneyTimeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final steps = ["Applied", "Approved", "Active", "Reviewing", "Completed"];
    final completedCount = 3;
    return Row(
      children: List.generate(steps.length, (i) {
        bool isCompleted = i < completedCount - 1;
        bool isActive = i == completedCount - 1;
        bool isFuture = i >= completedCount;
        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  if (i > 0)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: isCompleted || isActive ? Color(0xFF3B6EF0) : Colors.grey[300],
                      ),
                    ),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? Color(0xFF3B6EF0)
                          : isActive
                          ? Colors.white
                          : Colors.grey[200],
                      shape: BoxShape.circle,
                      border: Border.all(color: isActive ? Color(0xFF3B6EF0) : Colors.transparent, width: 2),
                    ),
                    child: Icon(
                      isCompleted
                          ? Icons.check
                          : isActive
                          ? Icons.play_arrow
                          : Icons.circle,
                      size: isCompleted
                          ? 16
                          : isActive
                          ? 14
                          : 8,
                      color: isCompleted
                          ? Colors.white
                          : isActive
                          ? Color(0xFF3B6EF0)
                          : Colors.grey[400],
                    ),
                  ),
                  if (i < steps.length - 1)
                    Expanded(
                      child: Container(height: 2, color: i < completedCount - 1 ? Color(0xFF3B6EF0) : Colors.grey[300]),
                    ),
                ],
              ),
              SizedBox(height: 6),
              Text(
                steps[i],
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
                  color: isActive
                      ? Color(0xFF3B6EF0)
                      : isFuture
                      ? Colors.grey[400]
                      : Colors.black87,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

class _ResourceItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final IconData trailing;
  const _ResourceItem({required this.icon, required this.title, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(color: Color(0xFFEFF4FF), borderRadius: BorderRadius.circular(8)),
        child: Icon(icon, color: Color(0xFF3B6EF0), size: 18),
      ),
      title: Text(
        title,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
      ),
      trailing: Icon(trailing, color: Colors.grey[400], size: 18),
      contentPadding: EdgeInsets.symmetric(horizontal: 14, vertical: 4),
    );
  }
}
