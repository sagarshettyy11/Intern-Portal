import 'package:flutter/material.dart';
import 'package:intern_portal/screens/faculty/guide/guide_dashboard.dart';
import 'package:intern_portal/screens/faculty/guide/internship_review.dart';
import 'package:intern_portal/screens/faculty/guide/report_review.dart';
import 'package:intern_portal/screens/faculty/guide/internship_request.dart';
import 'package:intern_portal/screens/faculty/guide/student_report.dart';
import 'package:intern_portal/screens/faculty/hod/faculty_performance.dart';
import 'package:intern_portal/screens/faculty/hod/hod_dashboard.dart';
import 'package:intern_portal/screens/faculty/hod/hod_profile.dart';
import 'package:intern_portal/screens/faculty/hod/overall_analytics.dart';
import 'package:intern_portal/screens/faculty/hod/student_performance.dart';
import 'package:intern_portal/screens/students/certificate.dart';
import 'package:intern_portal/screens/students/dashboard.dart';
import 'package:intern_portal/screens/students/internship.dart';
import 'package:intern_portal/screens/students/profile.dart';
import 'package:intern_portal/screens/students/report_overview.dart';

class StudentBottomNavController {
  static void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const DashboardPage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const InternshipsPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportsOverviewPage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const CertificatePage()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfilePage()));
        break;
    }
  }
}

class GuideBottomNavController {
  static void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const GuideDashboardPage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const InternshipRequestsPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentReportsPage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const InternshipReviewPage()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const ReportDetailsPage()));
        break;
    }
  }
}

class HodBottomNavController {
  static void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const HodDashboardPage()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentPerformancePage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const FacultyPerformancePage()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const OverallAnalyticsPage()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const HodProfilePage()));
        break;
    }
  }
}
