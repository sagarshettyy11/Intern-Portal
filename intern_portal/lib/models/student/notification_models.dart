class NotificationModel {
  final int id;
  final String title;
  final String message;
  final String eventType;
  final String? actorName;
  final String? attachmentUrl;
  bool isRead;
  final String timeAgo;

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.eventType,
    this.actorName,
    this.attachmentUrl,
    required this.isRead,
    required this.timeAgo,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['notification_id'],
      title: json['title'],
      message: json['message'],
      eventType: json['event_type'],
      actorName: json['actor_name'],
      attachmentUrl: json['attachment_url'],
      isRead: json['is_read'],
      timeAgo: json['time_ago'],
    );
  }
}
