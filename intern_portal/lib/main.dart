import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/pages/login.dart';
import 'package:intern_portal/pages/unified_login.dart';
import 'package:intern_portal/screens/college/admin/admin_dashboard.dart';
import 'package:intern_portal/screens/college/admin/faculty_master.dart';
import 'package:intern_portal/screens/college/admin/student_master.dart';
import 'package:intern_portal/screens/college/faculty/guide/guide_dashboard.dart';
import 'package:intern_portal/screens/college/faculty/guide/report_review.dart';
import 'package:intern_portal/screens/college/faculty/hod/hod_dashboard.dart';
import 'package:intern_portal/screens/college/students/dashboard.dart';
import 'package:intern_portal/screens/college/students/report_view.dart';
import 'package:intern_portal/widgets/custom_snackbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: CustomSnackbar.messengerKey,
      navigatorKey: NavigationService.navigatorKey,
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.interTextTheme(),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: GoogleFonts.inter(color: Colors.grey, fontWeight: FontWeight.bold),
        ),
      ),
      home: const CollegeAdminDashboardScreen(),
    );
  }
}
