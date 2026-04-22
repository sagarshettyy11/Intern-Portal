import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/screens/college/faculty/guide/send_notfication.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

enum SFAlertTab { allNotifications, reports, mentors }

enum SFBottomNavTab { dashboard, messages, alerts, library }

class SFAlertItem {
  final String title;
  final String body;
  final String boldName;
  final String time;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final bool hasUnreadDot;
  final String? groupLabel;

  const SFAlertItem({
    required this.title,
    required this.body,
    required this.boldName,
    required this.time,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    this.hasUnreadDot = false,
    this.groupLabel,
  });
}

class GuideNotifications extends StatefulWidget {
  const GuideNotifications({super.key});
  @override
  State<GuideNotifications> createState() => _GuideNotificationsState();
}

class _GuideNotificationsState extends State<GuideNotifications> {
  SFAlertTab _selectedTab = SFAlertTab.allNotifications;
  final List<SFAlertItem> _alerts = const [
    SFAlertItem(
      title: 'New Report Submitted',
      boldName: 'Rahul Sharma',
      body: ' has uploaded the final internship performance summary.',
      time: '2M AGO',
      icon: Icons.check_box_outlined,
      iconBgColor: Color(0xFFDCEAFD),
      iconColor: Color(0xFF1A56DB),
      hasUnreadDot: true,
    ),
    SFAlertItem(
      title: 'Direct Message',
      boldName: 'Priya Kapur',
      body: ' requested a meeting regarding the upcoming workshop.',
      time: '1H AGO',
      icon: Icons.chat_bubble,
      iconBgColor: Color(0xFFF5F0DC),
      iconColor: Color(0xFFB5860D),
    ),
    SFAlertItem(
      title: 'Onboarding Complete',
      boldName: 'System Admin',
      body: ' confirmed 12 new scholar registrations for Q3.',
      time: 'YESTERDAY',
      icon: Icons.verified_user,
      iconBgColor: Color(0xFFDCE8F5),
      iconColor: Color(0xFF3B6EA5),
      groupLabel: 'YESTERDAY',
    ),
    SFAlertItem(
      title: 'Deadline Alert',
      boldName: '',
      body: 'Budget approvals for the summer internship program are due in 48 hours.',
      time: 'YESTERDAY',
      icon: Icons.warning_rounded,
      iconBgColor: Color(0xFFFEE8E8),
      iconColor: Color(0xFFDC2626),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: CommonAppBar(title: "Notifications", showBack: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    _buildPageTitle(),
                    const SizedBox(height: 20),
                    _buildTabRow(),
                    const SizedBox(height: 20),
                    _buildAlertsList(),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildFAB(),
    );
  }

  Widget _buildPageTitle() {
    return Text(
      'Alerts & Updates',
      style: GoogleFonts.inter(
        color: Color(0xFF111827),
        fontSize: 30,
        fontWeight: FontWeight.w900,
        letterSpacing: -0.5,
      ),
    );
  }

  Widget _buildTabRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildTabChip('All Notifications', SFAlertTab.allNotifications),
          const SizedBox(width: 10),
          _buildTabChip('Reports', SFAlertTab.reports),
          const SizedBox(width: 10),
          _buildTabChip('Mentors', SFAlertTab.mentors),
        ],
      ),
    );
  }

  Widget _buildTabChip(String label, SFAlertTab tab) {
    final bool isSelected = _selectedTab == tab;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = tab),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A56DB) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: isSelected ? const Color(0xFF1A56DB) : const Color(0xFFD1D5DB)),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            color: isSelected ? Colors.white : const Color(0xFF374151),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildAlertsList() {
    List<Widget> items = [];
    for (int i = 0; i < _alerts.length; i++) {
      final alert = _alerts[i];
      if (alert.groupLabel != null) {
        items.add(
          Padding(
            padding: const EdgeInsets.only(top: 8, bottom: 12),
            child: Text(
              alert.groupLabel!,
              style: GoogleFonts.inter(
                color: Color(0xFF6B7280),
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.1,
              ),
            ),
          ),
        );
      }
      items.add(_buildAlertCard(alert));
      if (i < _alerts.length - 1 && _alerts[i + 1].groupLabel == null) {
        items.add(const SizedBox(height: 12));
      }
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: items);
  }

  Widget _buildAlertCard(SFAlertItem alert) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(color: alert.iconBgColor, borderRadius: BorderRadius.circular(12)),
                child: Icon(alert.icon, color: alert.iconColor, size: 26),
              ),
              if (alert.hasUnreadDot)
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(color: Color(0xFFEF4444), shape: BoxShape.circle),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        alert.title,
                        style: GoogleFonts.inter(color: Color(0xFF111827), fontSize: 15, fontWeight: FontWeight.w700),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      alert.time,
                      style: GoogleFonts.inter(color: Color(0xFF9CA3AF), fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(color: Color(0xFF374151), fontSize: 13.5, height: 1.45),
                    children: alert.boldName.isNotEmpty
                        ? [
                            TextSpan(
                              text: alert.boldName,
                              style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                            ),
                            TextSpan(text: alert.body),
                          ]
                        : [TextSpan(text: alert.body)],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => SendNotificationPage()));
      },
      backgroundColor: const Color(0xFF1A56DB),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Icon(Icons.send, color: Colors.white, size: 22),
    );
  }
}
