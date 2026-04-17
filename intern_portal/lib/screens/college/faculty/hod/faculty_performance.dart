import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/screens/college/faculty/hod/hod_profile.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class FacultyPerformancePage extends StatelessWidget {
  const FacultyPerformancePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: CommonAppBar(
        showLogo: true,
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => HodProfilePage()));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircleAvatar(radius: 16, child: Icon(Icons.person, size: 18, color: Colors.black)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Text(
                    'Faculty Performance',
                    style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF0000FF)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Real-time academic oversight dashboard',
                    style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[800], fontWeight: FontWeight.w800),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _FacultyStatCard(icon: Icons.badge_outlined, label: 'ACTIVE GUIDES', value: '24'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _FacultyStatCard(icon: Icons.group_outlined, label: 'TOTAL STUDENTS', value: '286'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _FacultyStatCard(
                          icon: Icons.star_border_rounded,
                          iconColor: Colors.amber,
                          label: 'DEPT AVG RATING',
                          value: '4.62',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _FacultyStatCard(
                          icon: Icons.check_box_outlined,
                          label: 'COMPLETION RATE',
                          value: '88.4%',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 22),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Faculty Guide Roster',
                        style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.black87),
                      ),
                      Text(
                        'Sort by Rating',
                        style: GoogleFonts.inter(fontSize: 13, color: Color(0xFF3B6EF0), fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _FacultyCard(
                    name: 'Dr. Sarah Jenkins',
                    role: 'Senior Faculty Lead',
                    students: '12 Students Assigned',
                    rating: 4.9,
                    isPrimary: true,
                  ),
                  const SizedBox(height: 12),
                  _FacultyCard(
                    name: 'Dr. Michael Chen',
                    role: 'Research Coordinator',
                    students: '15 Students Assigned',
                    rating: 4.7,
                    isPrimary: false,
                  ),
                  const SizedBox(height: 12),
                  _FacultyCard(
                    name: 'Dr. Elena Rodriguez',
                    role: 'Thesis Supervisor',
                    students: '9 Students Assigned',
                    rating: 4.8,
                    isPrimary: false,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: HodAppBottomNav(
        currentIndex: 2,
        onTap: (index) => HodBottomNavController.onItemTapped(context, index),
      ),
    );
  }
}

class _FacultyStatCard extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String label;
  final String value;
  const _FacultyStatCard({required this.icon, this.iconColor, required this.label, required this.value});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor ?? const Color(0xFF3B6EF0), size: 24, fontWeight: FontWeight.w800),
          const SizedBox(height: 12),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: Colors.grey[800],
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

class _FacultyCard extends StatelessWidget {
  final String name;
  final String role;
  final String students;
  final double rating;
  final bool isPrimary;
  const _FacultyCard({
    required this.name,
    required this.role,
    required this.students,
    required this.rating,
    required this.isPrimary,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[800],
                  child: Icon(Icons.person, size: 36, color: Colors.grey[500]),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 15, color: Colors.black87),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      role,
                      style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[800], fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.school_outlined, size: 13, color: Colors.grey[800]),
                        const SizedBox(width: 4),
                        Text(
                          students,
                          style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700], fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Rating badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(color: const Color(0xFFFFF8E1), borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                    const SizedBox(width: 3),
                    Text(
                      rating.toString(),
                      style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w800, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: isPrimary
                ? ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B6EF0),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      elevation: 0,
                    ),
                    child: Text(
                      'View Workload',
                      style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14),
                    ),
                  )
                : OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey[200]!),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color(0xFFF4F6FB),
                    ),
                    child: Text(
                      'View Workload',
                      style: GoogleFonts.inter(color: Color(0xFF0000FF), fontWeight: FontWeight.w800, fontSize: 14),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
