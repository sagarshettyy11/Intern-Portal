class ApiEndpoints {
  static const String baseUrl = 'http://192.168.1.5/internportal';
  static const String auth = '$baseUrl/auth';
  static const String base = '$baseUrl/api';

  static String loginUrl = "$auth/login.php";
  static String certificateFile = "$baseUrl/uploads/certificates/";
  static String fileUrl(String path) {
    return "$baseUrl/$path";
  }

  // Student Portal
  static String dashboard = "$baseUrl/student/dashboard.php";
  static String profile = "$baseUrl/student/profile.php";
  static String internship = "$baseUrl/student/my_internship.php";
  static String registeration = "$baseUrl/student/register.php";
  static String reports = "$baseUrl/student/submit_reports.php";
  static String overview = "$baseUrl/student/reports_overview.php";
  static String notifications = "$baseUrl/student/notification.php";
  static String myCertificate = "$baseUrl/student/certificate.php";

  // Unified Portal
  // Guide
  static String guideDashboard = "$baseUrl/college/guide/dashboard.php";
  static String request = "$baseUrl/college/guide/students_request.php";
  static String requestDetails = "$baseUrl/college/guide/request_detail.php";
  static String report = "$baseUrl/college/guide/reports.php";
  static String reportDetails = "$baseUrl/college/guide/report_detail.php";
  static String guideProfile = "$baseUrl/college/guide/profile.php";
  static String studentCertificate = "$baseUrl/college/guide/certificate.php";
  static String guideNotifications = "$baseUrl/college/guide/notifications.php";

  // Head of Department
  static String hodProfile = "$baseUrl/college/hod/profile.php";
  static String studentPerformance = "$baseUrl/college/hod/students.php";
  static String hodDashboard = "$baseUrl/college/hod/dashboard.php";
  static String guidePerformance = "$baseUrl/college/hod/guide.php";
  static String analytics = "$baseUrl/college/hod/reports.php";
  static String studentAnalytics = "$baseUrl/college/hod/student_reports.php";

  // Admin
  static String adminDepartment = "$baseUrl/college/admin/department.php";
  static String faculty = "$baseUrl/college/admin/faculty.php";
  static String student = "$baseUrl/college/admin/student.php";
  static String adminInternship = "$baseUrl/college/admin/internship_master.php";
  static String adminProfile = "$baseUrl/college/admin/profile.php";
  static String adminDashboard = "$baseUrl/college/admin/dashboard.php";

  // Company
  static String internshipReq = "$baseUrl/company/internship.php";
  static String certificate = "$baseUrl/company/certificate_overview.php";
  static String companyProfile = "$baseUrl/company/profile.php";
  static String uploadCertificate = "$baseUrl/company/certificate_upload.php";
  static String attendance = "$baseUrl/company/attendance_overview.php";
  static String addAttendance = "$baseUrl/company/attendance_management.php";
}
