import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/models/guide/guide_notification_model.dart';
import 'package:intern_portal/screens/college/faculty/guide/send_notfication.dart';
import 'package:intern_portal/services/users/guide_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

class GuideNotifications extends StatefulWidget {
  const GuideNotifications({super.key});
  @override
  State<GuideNotifications> createState() => _GuideNotificationsState();
}

class _GuideNotificationsState extends State<GuideNotifications> {
  SFAlertTab _selectedTab = SFAlertTab.allNotifications;
  List<NotificationModel> notifications = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    setState(() {
      isLoading = true;
    });
    final response = await GuideServices.fetchNotifications();
    if (response != null) {
      setState(() {
        notifications = response.notifications;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

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
                    _buildPageTitle(),
                    const SizedBox(height: 10),
                    _buildTabRow(),
                    const SizedBox(height: 10),
                    _buildAlertsList(),
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
    if (isLoading) {
      return const Center(
        child: Padding(padding: EdgeInsets.all(30), child: CircularProgressIndicator()),
      );
    }
    if (notifications.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Text("No notifications found", style: GoogleFonts.inter(fontSize: 14, color: Colors.grey)),
        ),
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: notifications.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return _buildAlertCard(notifications[index]);
      },
    );
  }

  Widget _buildAlertCard(NotificationModel alert) {
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
                decoration: BoxDecoration(
                  color: getNotificationBgColor(alert.eventType),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  getNotificationIcon(alert.eventType),
                  color: getNotificationColor(alert.eventType),
                  size: 26,
                ),
              ),
              if (!alert.isRead)
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
                        style: GoogleFonts.inter(color: Color(0xFF111827), fontSize: 15, fontWeight: FontWeight.w800),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      formatTime(alert.createdAt),
                      style: GoogleFonts.inter(color: Colors.grey[800], fontSize: 11, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.inter(color: const Color(0xFF374151), fontSize: 13.5, height: 1.45),
                    children: [
                      TextSpan(
                        text: alert.actor.name,
                        style: GoogleFonts.inter(fontWeight: FontWeight.w800),
                      ),
                      TextSpan(text: " ${alert.message}"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  IconData getNotificationIcon(String type) {
    switch (type) {
      case 'guide_message':
        return Icons.chat_bubble;
      case 'report_submitted':
        return Icons.assignment;
      case 'deadline_alert':
        return Icons.warning_rounded;
      default:
        return Icons.notifications;
    }
  }

  Color getNotificationColor(String type) {
    switch (type) {
      case 'guide_message':
        return const Color(0xFFB5860D);
      case 'report_submitted':
        return const Color(0xFF1A56DB);
      case 'deadline_alert':
        return const Color(0xFFDC2626);
      default:
        return Colors.blue;
    }
  }

  Color getNotificationBgColor(String type) {
    switch (type) {
      case 'guide_message':
        return const Color(0xFFF5F0DC);
      case 'report_submitted':
        return const Color(0xFFDCEAFD);
      case 'deadline_alert':
        return const Color(0xFFFEE8E8);
      default:
        return const Color(0xFFE5E7EB);
    }
  }

  String formatTime(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inMinutes < 60) {
      return "${difference.inMinutes}M AGO";
    }
    if (difference.inHours < 24) {
      return "${difference.inHours}H AGO";
    }
    if (difference.inDays == 1) {
      return "YESTERDAY";
    }
    return "${difference.inDays}D AGO";
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
