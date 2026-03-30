import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/common_widgets/common_widgets.dart';
import 'package:intern_portal/widgets/common_widgets/profile_widgets.dart';

class FacultyProfilePage extends StatelessWidget {
  const FacultyProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: CommonAppBar(title: "Guide Profile", showBack: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Center(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      width: 90,
                      height: 90,
                      color: const Color(0xFF1A5C6B),
                      child: const Icon(Icons.person, color: Colors.white, size: 54),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: const BoxDecoration(color: Color(0xFF2563EB), shape: BoxShape.circle),
                      child: const Icon(Icons.settings, color: Colors.white, size: 13),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Dr. Aristhanes Murthy',
              style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 4),
            Text(
              'ACADEMIC LEAD & ADMINISTRATOR',
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: Color(0xFF2563EB),
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeader(icon: Icons.person_outline, title: "Personal Information"),
                        const SizedBox(height: 16),
                        InfoField(label: 'FULL NAME', value: 'Dr. Aristhanes Murthy'),
                        const SizedBox(height: 12),
                        InfoField(label: 'CONTACT NUMBER', value: '+1 (555) 234-8901', icon: Icons.phone_outlined),
                        const SizedBox(height: 12),
                        InfoField(label: 'EMAIL ADDRESS', value: 'a.murthy@faculty.edu', icon: Icons.mail_outline),
                        const SizedBox(height: 12),
                        InfoField(label: 'DESIGNATION', value: 'Head of Department'),
                        const SizedBox(height: 12),
                        InfoField(label: 'BRANCH', value: 'Computer Science & Engineering'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  SectionHeader(icon: Icons.person_outline, title: "Academic Resources"),
                  const SizedBox(height: 12),
                  QuickLinkTile(icon: Icons.help_outline, title: "FAQ & Support"),
                  Divider(height: 1, indent: 50),
                  QuickLinkTile(icon: Icons.article_outlined, title: "Internship Guidelines"),
                  Divider(height: 1, indent: 50),
                  QuickLinkTile(icon: Icons.menu_book_outlined, title: "Student Handbook"),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, color: const Color(0xFF2563EB), size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Campus Location',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Main Block, Level 4',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 13, color: Colors.black87),
                        ),
                        Text('HOD Suite - Room 402', style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[500])),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(height: 130, width: double.infinity, color: const Color(0xFF1A5C6B)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.logout_rounded, color: Colors.white, size: 18),
                      label: const Text(
                        'Logout',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color(0xFF0000FF),
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
