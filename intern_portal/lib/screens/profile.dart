import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/student_models.dart';
import 'package:intern_portal/services/users/student_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';
import 'package:intern_portal/widgets/common_widgets/common_widgets.dart';
import 'package:intern_portal/widgets/common_widgets/profile_widgets.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  StudentProfile? profile;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final data = await StudentServices.fetchProfile();
    if (!mounted) return;
    setState(() {
      profile = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (profile == null) {
      return Scaffold(body: Center(child: Text("Failed to load profile")));
    }
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: CommonAppBar(
        showBack: false,
        showLogo: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black, fontWeight: FontWeight.bold),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF4F7FFA), Color(0xFF3B6EF0)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 70,
                      height: 70,
                      color: Colors.teal[300],
                      child: Icon(Icons.person, size: 44, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              profile!.personal.name,
                              style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
                            ),
                            SizedBox(width: 4),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle),
                            ),
                          ],
                        ),
                        Text(
                          "Internship No:",
                          style: GoogleFonts.inter(fontSize: 12, color: Colors.white70, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          profile!.personal.registrationNo,
                          style: GoogleFonts.inter(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          profile!.academic.department,
                          style: GoogleFonts.inter(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            "VERIFIED STUDENT",
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SectionHeader(icon: Icons.person_outline, title: "Personal Information"),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFEFF4FF),
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text(
                          "Quick Edit",
                          style: GoogleFonts.inter(color: Color(0xFF3B6EF0), fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Update your contact details & basic information.",
                    style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: InfoField(label: "FULL NAME", value: profile!.personal.name),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: InfoField(label: "REGISTRATION NUMBER", value: profile!.personal.registrationNo),
                      ),
                    ],
                  ),
                  SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(
                        child: InfoField(label: "PHONE NUMBER", value: profile!.personal.phone),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: InfoField(label: "EMAIL ADDRESS", value: profile!.personal.email),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  InfoField(label: "RESIDENTIAL ADDRESS", value: profile!.personal.address),
                  SizedBox(height: 24),
                  SectionHeader(icon: Icons.school_outlined, title: "Academic Record"),
                  SizedBox(height: 6),
                  Text(
                    "Verified institutional data",
                    style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(
                        child: AcademicBox(label: "ENROLLMENT", value: profile!.academic.department, isBlue: true),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: AcademicBox(label: "YEAR", value: profile!.academic.year),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: AcademicBox(label: "CURRENT CGPA", value: profile!.academic.cgpa?.toString() ?? "N/A"),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: AcademicBox(label: "CREDITS EARNED", value: "92 Credits"),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Assigned Internship Guide",
                    style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: Offset(0, 2)),
                      ],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.orange[200],
                          child: Icon(Icons.person, color: Colors.orange[700]),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                profile!.guide?.name ?? "No guide assigned",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                profile!.guide?.email ?? "No guide assigned",
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Color(0xFFEFF4FF), borderRadius: BorderRadius.circular(8)),
                          child: Icon(
                            Icons.mail_outline,
                            color: Color(0xFF3B6EF0),
                            size: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  SectionHeader(icon: Icons.link, title: "Quick Links"),
                  SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: Offset(0, 2)),
                      ],
                    ),
                    child: Column(
                      children: [
                        QuickLinkTile(icon: Icons.help_outline, title: "FAQ & Support"),
                        Divider(height: 1, indent: 50),
                        QuickLinkTile(icon: Icons.article_outlined, title: "Internship Guidelines"),
                        Divider(height: 1, indent: 50),
                        QuickLinkTile(icon: Icons.menu_book_outlined, title: "Student Handbook"),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  SectionHeader(icon: Icons.location_on, title: "Campus Location"),
                  SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 160,
                      width: double.infinity,
                      color: Color(0xFF2D6B6B),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [Icon(Icons.location_on, color: Color(0xFF3B6EF0), size: 36)],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 14),
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      profile!.personal.name.toUpperCase(),
                      style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: Colors.grey[500]),
                    ),
                    Text(
                      profile!.personal.registrationNo,
                      style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 4,
        onTap: (index) => BottomNavController.onItemTapped(context, index),
      ),
    );
  }
}
