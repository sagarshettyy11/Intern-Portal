import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/models/student/notification_models.dart';
import 'package:intern_portal/screens/college/faculty/guide/certificate_viewer.dart';
import 'package:intern_portal/services/api_endpoints.dart';
import 'package:intern_portal/services/users/student_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:path_provider/path_provider.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  static const Color primaryBlue = Color(0xFF1A3FBB);
  static const Color lightBlue = Color(0xFFE8EEFF);
  static const Color bgColor = Color(0xFFF2F4F7);
  static const Color textDark = Color(0xFF1A1A2E);
  static const Color textGrey = Color(0xFF9AA0B4);
  static const Color cardWhite = Colors.white;
  List<NotificationModel> notifications = [];
  int unreadCount = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      final data = await StudentServices.fetchNotifications();
      setState(() {
        notifications = data['notifications'];
        unreadCount = data['unread'];
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: CommonAppBar(title: "Notfications", showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            _buildInboxHeader(),
            const SizedBox(height: 16),
            if (notifications.isEmpty) _buildEmptyCard() else ...notifications.map((n) => _buildNotificationCard(n)),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _buildInboxHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'STATUS UPDATE',
          style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.4, color: primaryBlue),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Text(
              'Inbox',
              style: GoogleFonts.inter(fontSize: 30, fontWeight: FontWeight.bold, color: textDark),
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(color: primaryBlue, borderRadius: BorderRadius.circular(20)),
              child: Text(
                '$unreadCount unread',
                style: GoogleFonts.inter(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildNotificationCard(NotificationModel item) {
    return GestureDetector(
      onTap: () async {
        if (!item.isRead) {
          final success = await StudentServices.markNotificationRead(item.id);
          if (success) {
            setState(() {
              item.isRead = true;
              unreadCount = unreadCount > 0 ? unreadCount - 1 : 0;
            });
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: !item.isRead ? cardWhite : const Color(0xFFF8F9FC),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: !item.isRead ? 0.06 : 0.03),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildIconBox(getIcon(item.eventType), !item.isRead),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.title,
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      fontWeight: !item.isRead ? FontWeight.bold : FontWeight.w600,
                      color: !item.isRead ? textDark : const Color(0xFF444444),
                    ),
                  ),
                ),
                if (!item.isRead)
                  const Padding(
                    padding: EdgeInsets.only(top: 2),
                    child: CircleAvatar(radius: 5, backgroundColor: Colors.red),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 48),
              child: Text(
                item.message,
                style: GoogleFonts.inter(fontSize: 13, color: !item.isRead ? textDark : textGrey),
              ),
            ),
            const SizedBox(height: 4),
            const Divider(height: 1, color: Color(0xFFEEEFF3)),
            const SizedBox(height: 6),
            // Footer Row
            Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(color: const Color(0xFFEEEFF3), borderRadius: BorderRadius.circular(6)),
                  child: Icon(Icons.business_outlined, size: 13, color: Colors.grey[800]),
                ),
                const SizedBox(width: 7),
                Text(
                  item.actorName ?? "System",
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[800], fontWeight: FontWeight.w500),
                ),

                const Spacer(),
                if (item.attachmentUrl != null) ...[
                  GestureDetector(
                    onTap: () async {
                      try {
                        final url = ApiEndpoints.fileUrl(item.attachmentUrl!);
                        final dir = await getTemporaryDirectory();
                        final fileName = item.attachmentUrl!.split('/').last;
                        final savePath = "${dir.path}/$fileName";
                        await Dio().download(url, savePath);
                        if (!context.mounted) return;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => AttachmentViewer(file: File(savePath))),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(const SnackBar(content: Text('Failed to open attachment')));
                      }
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.attach_file_rounded, size: 14, color: primaryBlue),
                        const SizedBox(width: 3),
                        Text(
                          'View Attachment',
                          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: primaryBlue),
                        ),
                      ],
                    ),
                  ),
                ] else
                  Text(item.timeAgo, style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[800])),
              ],
            ),
            if (item.attachmentUrl != null) ...[
              const SizedBox(height: 4),
              Align(
                alignment: Alignment.centerRight,
                child: Text(item.timeAgo, style: GoogleFonts.inter(fontSize: 12, color: textGrey)),
              ),
            ],
          ],
        ),
      ),
    );
  }

  IconData getIcon(String type) {
    switch (type) {
      case 'MESSAGE':
        return Icons.mail_outline;
      case 'REPORT':
        return Icons.assignment_outlined;
      case 'CERTIFICATE':
        return Icons.verified_outlined;
      default:
        return Icons.notifications_none;
    }
  }

  Widget _buildIconBox(IconData icon, bool isUnread) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: isUnread ? lightBlue : const Color(0xFFEEEFF3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, size: 22, color: isUnread ? primaryBlue : textGrey),
    );
  }

  Widget _buildEmptyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FC),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE4E6EE), width: 1),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Icon(Icons.image_outlined, size: 40, color: Colors.grey.shade300),
              Icon(Icons.settings, size: 18, color: Colors.grey.shade300),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'No more notifications',
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: textDark),
          ),
          const SizedBox(height: 6),
          Text(
            'You\'re all caught up for today. New alerts\nwill appear here as they arrive.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(fontSize: 12.5, height: 1.5, color: textGrey),
          ),
        ],
      ),
    );
  }
}
