import 'package:flutter/material.dart';
import 'package:intern_portal/screens/certificate.dart';
import 'package:intern_portal/screens/dashboard.dart';
import 'package:intern_portal/screens/internship.dart';
import 'package:intern_portal/screens/profile.dart';
import 'package:intern_portal/screens/report_overview.dart';

class BottomNavController {
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
