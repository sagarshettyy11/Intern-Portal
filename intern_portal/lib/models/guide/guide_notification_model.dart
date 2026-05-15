enum SFAlertTab { allNotifications, reports, mentors }

enum SFBottomNavTab { dashboard, messages, alerts, library }

class NotificationModel {
  final int notificationId;
  final String eventType;
  final String title;
  final String message;
  final bool isRead;
  final ActorModel actor;
  final int? reportId;
  final int? internshipId;
  final String? attachmentUrl;
  final DateTime createdAt;
  NotificationModel({
    required this.notificationId,
    required this.eventType,
    required this.title,
    required this.message,
    required this.isRead,
    required this.actor,
    this.reportId,
    this.internshipId,
    this.attachmentUrl,
    required this.createdAt,
  });
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['notification_id'] ?? 0,
      eventType: json['event_type'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      isRead: json['is_read'] == true || json['is_read'] == 1,
      actor: json['actor'] != null ? ActorModel.fromJson(json['actor']) : ActorModel.empty(),
      reportId: json['report_id'],
      internshipId: json['internship_id'],
      attachmentUrl: json['attachment_url'],
      createdAt: DateTime.tryParse(json['created_at'] ?? '') ?? DateTime.now(),
    );
  }
}

class ActorModel {
  final int id;
  final String name;
  final String role;
  ActorModel({required this.id, required this.name, required this.role});
  factory ActorModel.fromJson(Map<String, dynamic> json) {
    return ActorModel(id: json['id'] ?? 0, name: json['name'] ?? '', role: json['role'] ?? '');
  }
  factory ActorModel.empty() {
    return ActorModel(id: 0, name: '', role: '');
  }
}

class StudentModel {
  final int studentId;
  final String name;
  final String? deptCode;
  StudentModel({required this.studentId, required this.name, this.deptCode});
  factory StudentModel.fromJson(Map<String, dynamic> json) {
    return StudentModel(studentId: json['student_id'] ?? 0, name: json['name'] ?? '', deptCode: json['dept_code']);
  }
}

class NotificationResponse {
  final int unreadCount;
  final List<NotificationModel> notifications;
  final List<StudentModel> myStudents;
  NotificationResponse({required this.unreadCount, required this.notifications, required this.myStudents});
  factory NotificationResponse.fromJson(Map<String, dynamic> json) {
    return NotificationResponse(
      unreadCount: json['unread_count'] ?? 0,
      notifications: (json['notifications'] as List? ?? []).map((e) => NotificationModel.fromJson(e)).toList(),
      myStudents: (json['my_students'] as List? ?? []).map((e) => StudentModel.fromJson(e)).toList(),
    );
  }
}
