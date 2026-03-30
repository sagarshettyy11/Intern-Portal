import 'package:flutter/material.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class FacultyPerformancePage extends StatelessWidget {
  const FacultyPerformancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(color: const Color(0xFF3B6EF0), borderRadius: BorderRadius.circular(6)),
              child: const Icon(Icons.school, color: Colors.white, size: 16),
            ),
            const SizedBox(width: 8),
            const Text(
              'Intern Portal',
              style: TextStyle(color: Color(0xFF3B6EF0), fontWeight: FontWeight.w700, fontSize: 15),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black54),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey[200]),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blue header banner
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HOD Dashboard',
                    style: TextStyle(fontSize: 13, color: Colors.grey[500], fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Faculty Performance',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color(0xFF3B6EF0)),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Real-time academic oversight dashboard',
                    style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stat cards
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

                  // Faculty Guide Roster
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Faculty Guide Roster',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      const Text(
                        'Sort by Rating',
                        style: TextStyle(fontSize: 13, color: Color(0xFF3B6EF0), fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Guide card 1 — primary button
                  _FacultyCard(
                    name: 'Dr. Sarah Jenkins',
                    role: 'Senior Faculty Lead',
                    students: '12 Students Assigned',
                    rating: 4.9,
                    isPrimary: true,
                  ),
                  const SizedBox(height: 12),

                  // Guide card 2 — outline button
                  _FacultyCard(
                    name: 'Dr. Michael Chen',
                    role: 'Research Coordinator',
                    students: '15 Students Assigned',
                    rating: 4.7,
                    isPrimary: false,
                  ),
                  const SizedBox(height: 12),

                  // Guide card 3 — no button (partial, bottom cut off)
                  _FacultyCardNoButton(
                    name: 'Dr. Elena Rodriguez',
                    role: 'Thesis Supervisor',
                    students: '9 Students Assigned',
                    rating: 4.8,
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
          Icon(icon, color: iconColor ?? const Color(0xFF3B6EF0), size: 24),
          const SizedBox(height: 12),
          Text(
            label,
            style: TextStyle(fontSize: 10, color: Colors.grey[500], fontWeight: FontWeight.w600, letterSpacing: 0.4),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

// ── Faculty card with button ──────────────────────────────────────────────────

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
              // Avatar
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 60,
                  height: 60,
                  color: Colors.grey[300],
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
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                    ),
                    const SizedBox(height: 2),
                    Text(role, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.school_outlined, size: 13, color: Colors.grey[400]),
                        const SizedBox(width: 4),
                        Text(students, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
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
                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),

          // View Workload button
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
                    child: const Text(
                      'View Workload',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  )
                : OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.grey[200]!),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      backgroundColor: const Color(0xFFF4F6FB),
                    ),
                    child: const Text(
                      'View Workload',
                      style: TextStyle(color: Color(0xFF3B6EF0), fontWeight: FontWeight.w600, fontSize: 14),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Faculty card without button ───────────────────────────────────────────────

class _FacultyCardNoButton extends StatelessWidget {
  final String name;
  final String role;
  final String students;
  final double rating;

  const _FacultyCardNoButton({required this.name, required this.role, required this.students, required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              width: 60,
              height: 60,
              color: Colors.grey[300],
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
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.black87),
                ),
                const SizedBox(height: 2),
                Text(role, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.school_outlined, size: 13, color: Colors.grey[400]),
                    const SizedBox(width: 4),
                    Text(students, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(color: const Color(0xFFFFF8E1), borderRadius: BorderRadius.circular(20)),
            child: Row(
              children: [
                const Icon(Icons.star_rounded, color: Colors.amber, size: 14),
                const SizedBox(width: 3),
                Text(
                  rating.toString(),
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Bottom nav ────────────────────────────────────────────────────────────────

class _HodBottomNav extends StatelessWidget {
  final int currentIndex;
  const _HodBottomNav({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[200]!)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        elevation: 0,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: currentIndex == 0 ? const Color(0xFF3B6EF0) : Colors.grey[500]),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_outlined, color: currentIndex == 1 ? const Color(0xFF3B6EF0) : Colors.grey[500]),
            label: 'Students',
          ),
          // Active "Guides" pill
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: currentIndex == 2 ? const Color(0xFF3B6EF0) : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.person_pin_outlined, color: currentIndex == 2 ? Colors.white : Colors.grey[500]),
            ),
            label: 'Guides',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_rounded, color: currentIndex == 3 ? const Color(0xFF3B6EF0) : Colors.grey[500]),
            label: 'Analytics',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline, color: currentIndex == 4 ? const Color(0xFF3B6EF0) : Colors.grey[500]),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
