import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/dashboard_models.dart';
import 'package:intern_portal/screens/registration.dart';
import 'package:intern_portal/services/users/student_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';
import 'package:intern_portal/widgets/common_widgets/common_widgets.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});
  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  DashboardModel? dashboard;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadDashboard();
  }

  Future<void> loadDashboard() async {
    final data = await StudentServices.fetchDashboard();
    setState(() {
      dashboard = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (dashboard == null) {
      return Scaffold(body: Center(child: Text("Failed to load dashboard")));
    }
    final d = dashboard!;
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: CommonAppBar(
        showLogo: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const RegistrationPage()));
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF3B6EF0),
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.add, color: Colors.white, size: 18),
            ),
          ),
          Icon(Icons.notifications_outlined, color: Colors.black, size: 24),
          const SizedBox(width: 4),
        ],
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
                      text: "${d.greeting}, ",
                      style: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                      children: [TextSpan(text: "${d.student.name}!")],
                    ),
                  ),
                  SizedBox(height: 8),
                  RichText(
                    text: TextSpan(
                      text: "You are ",
                      style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600]),
                      children: [
                        TextSpan(
                          text: "${d.internship?.completion ?? 0}%",
                          style: GoogleFonts.inter(color: Color(0xFF3B6EF0), fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: " through your internship progress."),
                      ],
                    ),
                  ),
                  SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: (d.internship?.completion ?? 0) / 100,
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
                      style: GoogleFonts.inter(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
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
                      style: GoogleFonts.inter(color: Colors.grey[700], fontSize: 13, fontWeight: FontWeight.bold),
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
                    value: d.internship?.company ?? "Not Assigned",
                    valueStyle: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: _StatCard(
                    label: "PENDING REPORTS",
                    value: d.reports.pending.toString(),
                    valueStyle: GoogleFonts.inter(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF3B6EF0)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 22),
            Text(
              "Internship Journey",
              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 14),
            _JourneyTimeline(steps: dashboard!.journey),
            SizedBox(height: 22),
            Text(
              "Priority Alerts",
              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 12),
            if (d.alerts.isEmpty)
              Container(
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
                child: Text("No alerts right now 🎉", style: GoogleFonts.inter(color: Colors.grey[600])),
              )
            else
              Column(
                children: d.alerts.map((alert) {
                  final isUrgent = alert.type == "urgent";
                  return Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                    decoration: BoxDecoration(
                      color: isUrgent ? Color(0xFFFFF1F1) : Color(0xFFFFF8E6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          isUrgent ? Icons.warning_amber_rounded : Icons.access_time_rounded,
                          color: isUrgent ? Color(0xFFE53935) : Color(0xFFE67E00),
                          size: 24,
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                alert.title,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: isUrgent ? Color(0xFFE53935) : Color(0xFFE67E00),
                                ),
                              ),
                              Text(
                                alert.description,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: isUrgent ? Color(0xFFE53935) : Color(0xFFE67E00),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.chevron_right, color: isUrgent ? Color(0xFFE53935) : Color(0xFFE67E00)),
                      ],
                    ),
                  );
                }).toList(),
              ),
            SizedBox(height: 22),
            Text(
              "Resources for You",
              style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
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
                  ResourceItem(icon: Icons.description_outlined, title: "Guidelines", trailing: Icons.open_in_new),
                  Divider(height: 1, indent: 52),
                  ResourceItem(
                    icon: Icons.article_outlined,
                    title: "Report Template",
                    trailing: Icons.download_outlined,
                  ),
                  Divider(height: 1, indent: 52),
                  ResourceItem(icon: Icons.help_outline, title: "Student FAQ", trailing: Icons.chevron_right),
                  Divider(height: 1, indent: 52),
                  ResourceItem(icon: Icons.group_outlined, title: "Peer Support", trailing: Icons.chevron_right),
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
            style: GoogleFonts.inter(
              fontSize: 10,
              color: Colors.grey[700],
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 6),
          Text(value, style: valueStyle),
        ],
      ),
    );
  }
}

class _JourneyTimeline extends StatelessWidget {
  final List<JourneyStep> steps;
  const _JourneyTimeline({required this.steps});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(steps.length, (i) {
        final step = steps[i];
        bool isCompleted = step.status == "done";
        bool isActive = step.status == "active";
        bool isFuture = step.status == "pending";
        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  if (i != 0)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: (steps[i - 1].status == "done" || steps[i - 1].status == "active")
                            ? const Color(0xFF3B6EF0)
                            : Colors.grey[300],
                      ),
                    ),
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: isCompleted
                          ? const Color(0xFF3B6EF0)
                          : isActive
                          ? Colors.white
                          : Colors.grey[200],
                      shape: BoxShape.circle,
                      border: Border.all(color: isActive ? const Color(0xFF3B6EF0) : Colors.transparent, width: 2),
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
                          ? const Color(0xFF3B6EF0)
                          : Colors.grey[400],
                    ),
                  ),
                  if (i != steps.length - 1)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: (step.status == "done" || step.status == "active")
                            ? const Color(0xFF3B6EF0)
                            : Colors.grey[300],
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 6),
              Align(
                alignment: i == 0
                    ? Alignment.centerLeft
                    : i == steps.length - 1
                    ? Alignment.centerRight
                    : Alignment.center,
                child: Text(
                  step.label,
                  textAlign: i == 0
                      ? TextAlign.left
                      : i == steps.length - 1
                      ? TextAlign.right
                      : TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: isActive ? FontWeight.w800 : FontWeight.w600,
                    color: isActive
                        ? const Color(0xFF0000FF)
                        : isFuture
                        ? Colors.grey[400]
                        : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
