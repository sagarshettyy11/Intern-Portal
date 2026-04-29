import 'package:flutter/material.dart';
import 'package:intern_portal/screens/college/admin/admin_dashboard.dart';
import 'package:intern_portal/screens/college/admin/department_master.dart';
import 'package:intern_portal/screens/college/admin/faculty_master.dart';
import 'package:intern_portal/screens/college/admin/internship_master.dart';
import 'package:intern_portal/screens/college/admin/student_master.dart';
import 'package:intern_portal/screens/college/faculty/guide/faculty_profile.dart';
import 'package:intern_portal/screens/college/faculty/guide/guide_dashboard.dart';
import 'package:intern_portal/screens/college/faculty/guide/internship_review.dart';
import 'package:intern_portal/screens/college/faculty/guide/report_review.dart';
import 'package:intern_portal/screens/college/faculty/guide/internship_request.dart';
import 'package:intern_portal/screens/college/faculty/guide/student_certificates.dart';
import 'package:intern_portal/screens/college/faculty/guide/student_report.dart';
import 'package:intern_portal/screens/college/faculty/hod/analytics.dart';
import 'package:intern_portal/screens/college/faculty/hod/faculty_performance.dart';
import 'package:intern_portal/screens/college/faculty/hod/hod_dashboard.dart';
import 'package:intern_portal/screens/college/faculty/hod/hod_profile.dart';
import 'package:intern_portal/screens/college/faculty/hod/overall_analytics.dart';
import 'package:intern_portal/screens/college/faculty/hod/student_performance.dart';
import 'package:intern_portal/screens/college/students/certificate.dart';
import 'package:intern_portal/screens/college/students/dashboard.dart';
import 'package:intern_portal/screens/college/students/internship.dart';
import 'package:intern_portal/screens/college/students/profile.dart';
import 'package:intern_portal/screens/college/students/report_overview.dart';
import 'package:intern_portal/screens/company/attendance_overview.dart';
import 'package:intern_portal/screens/company/certificate_list.dart';
import 'package:intern_portal/screens/company/company_profile.dart';
import 'package:intern_portal/screens/company/internships.dart';

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
        Navigator.push(context, MaterialPageRoute(builder: (_) => const CertificatesScreen()));
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
        Navigator.push(context, MaterialPageRoute(builder: (_) => const CertificatesPage()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const FacultyProfilePage()));
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
        Navigator.push(context, MaterialPageRoute(builder: (_) => const AnalyticsScreen()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const HodProfilePage()));
        break;
    }
  }
}

class AdminBottomNavController {
  static void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const CollegeAdminDashboardScreen()));
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const FacultyMasterPage()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const StudentsListScreen()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const DepartmentMasterPage()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const InternshipMasterScreen()));
        break;
    }
  }
}

class CompanyBottomNavController {
  static void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        break;
      case 1:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const InternshipRequestsScreen()));
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const AttendanceOverviewScreen()));
        break;
      case 3:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const CertificatesListScreen()));
        break;
      case 4:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const CompanyProfileScreen()));
        break;
    }
  }
}
