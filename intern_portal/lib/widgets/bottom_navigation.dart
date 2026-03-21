import 'package:flutter/material.dart';

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
        selectedLabelStyle: const TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 9),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'DASHBOARD'),
          BottomNavigationBarItem(icon: Icon(Icons.work_outline), label: 'INTERNSHIPS'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'REPORTS'),
          BottomNavigationBarItem(icon: Icon(Icons.verified_user_outlined), label: 'CERTIFICATES'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'PROFILE'),
        ],
      ),
    );
  }
}
