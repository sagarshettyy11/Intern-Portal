import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/pages/login.dart';
import 'package:intern_portal/pages/unified_login.dart';
import 'package:intern_portal/screens/college/faculty/guide/notification.dart';
import 'package:intern_portal/screens/college/faculty/guide/student_certificates.dart';
import 'package:intern_portal/screens/college/faculty/hod/analytics.dart';
import 'package:intern_portal/screens/college/faculty/hod/hod_dashboard.dart';
import 'package:intern_portal/screens/college/faculty/hod/student_analytics.dart';
import 'package:intern_portal/screens/company/attendance_overview.dart';
import 'package:intern_portal/screens/company/company_profile.dart';
import 'package:intern_portal/screens/company/internships.dart';
import 'package:intern_portal/screens/company/student_attendence.dart';
import 'package:intern_portal/screens/company/upload_certificate.dart';
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
      home: const UnifiedLoginPage(),
      routes: {'/login': (context) => const LoginPage(), '/UnifiedLogin': (context) => const UnifiedLoginPage()},
    );
  }
}
