import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const AppBottomNav({super.key, required this.currentIndex, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF3B6EF0),
        unselectedItemColor: Colors.grey[500],
        selectedLabelStyle: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.w800),
        unselectedLabelStyle: GoogleFonts.inter(fontSize: 9, fontWeight: FontWeight.w800),
        elevation: 0,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded, fontWeight: FontWeight.bold), label: 'DASHBOARD'),
          BottomNavigationBarItem(icon: Icon(Icons.work_outline, fontWeight: FontWeight.bold), label: 'INTERNSHIPS'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart , fontWeight: FontWeight.bold), label: 'REPORTS'),
          BottomNavigationBarItem(icon: Icon(Icons.verified_user_outlined, fontWeight: FontWeight.bold), label: 'CERTIFICATES'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline, fontWeight: FontWeight.bold), label: 'PROFILE'),
        ],
      ),
    );
  }
}
