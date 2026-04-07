import 'package:flutter/material.dart';

class Department {
  final String name;
  final String code;
  final String hodName;
  final int facultyCount;
  final bool isActive;
  final IconData icon;

  const Department({
    required this.name,
    required this.code,
    required this.hodName,
    required this.facultyCount,
    required this.isActive,
    required this.icon,
  });
}

final List<Department> departments = [
  Department(
    name: 'Computer Science Engineering',
    code: 'CSE-01',
    hodName: 'Dr. Alan Turing',
    facultyCount: 42,
    isActive: true,
    icon: Icons.laptop_mac,
  ),
  Department(
    name: 'Information Science Engineering',
    code: 'ISE-04',
    hodName: 'Dr. Grace Hopper',
    facultyCount: 35,
    isActive: true,
    icon: Icons.grid_view_rounded,
  ),
  Department(
    name: 'Electronics & Comm. Eng.',
    code: 'ECE-02',
    hodName: 'Dr. Nikola Tesla',
    facultyCount: 28,
    isActive: false,
    icon: Icons.memory_rounded,
  ),
  Department(
    name: 'Mechanical Engineering',
    code: 'ME-07',
    hodName: 'Dr. James Watt',
    facultyCount: 50,
    isActive: true,
    icon: Icons.settings_rounded,
  ),
];

// ─── Main Page ─────────────────────────────────────────────────────────────────

class DepartmentMasterPage extends StatefulWidget {
  const DepartmentMasterPage({super.key});

  @override
  State<DepartmentMasterPage> createState() => _DepartmentMasterPageState();
}

class _DepartmentMasterPageState extends State<DepartmentMasterPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SafeArea(
        child: Column(
          children: [
            // ── Top App Bar ──
            _buildTopBar(),

            // ── Scrollable Content ──
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // Section label
                    Text(
                      'ACADEMIC MANAGEMENT',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[500],
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Page title
                    const Text(
                      'Department Master',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // ── Action Row ──
                    _buildActionRow(),
                    const SizedBox(height: 20),

                    // ── Department Cards ──
                    ...departments.map(
                      (dept) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: DepartmentMasterCard(department: dept),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // ── Bottom Navigation Bar ──
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // ── Top Bar ─────────────────────────────────────────────────────────────────

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Hamburger + Logo
          Row(
            children: [
              Icon(Icons.menu, color: Colors.grey[700], size: 24),
              const SizedBox(width: 10),
              RichText(
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'Scholar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A56DB),
                        letterSpacing: -0.2,
                      ),
                    ),
                    TextSpan(
                      text: 'Flow',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                        letterSpacing: -0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: const Color(0xFF2C3A6B),
            child: ClipOval(
              child: Container(
                width: 40,
                height: 40,
                color: const Color(0xFF2C3A6B),
                child: const Icon(Icons.person, color: Colors.white, size: 22),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Action Row (Add Button + Filter) ────────────────────────────────────────

  Widget _buildActionRow() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.add_circle, size: 20, color: Colors.white),
            label: const Text(
              'Add Department',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A56DB),
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(width: 10),

        // Filter button
        Container(
          width: 48,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: const Icon(
            Icons.tune_rounded,
            color: Color(0xFF475569),
            size: 22,
          ),
        ),
      ],
    );
  }

  // ── Bottom Navigation Bar ────────────────────────────────────────────────────

  Widget _buildBottomNavBar() {
    final items = [
      DepartmentMasterNavItem(icon: Icons.grid_view_rounded, label: 'DASHBOARD'),
      DepartmentMasterNavItem(icon: Icons.school_outlined, label: 'FACULTY'),
      DepartmentMasterNavItem(icon: Icons.people_outline_rounded, label: 'STUDENTS'),
      DepartmentMasterNavItem(icon: Icons.work_outline_rounded, label: 'INTERNSHIPS'),
      DepartmentMasterNavItem(icon: Icons.person_outline_rounded, label: 'PROFILE'),
    ];

    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final selected = i == _currentIndex;
          return GestureDetector(
            onTap: () => setState(() => _currentIndex = i),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  items[i].icon,
                  size: 24,
                  color: selected
                      ? const Color(0xFF1A56DB)
                      : const Color(0xFF94A3B8),
                ),
                const SizedBox(height: 3),
                Text(
                  items[i].label,
                  style: TextStyle(
                    fontSize: 9,
                    fontWeight:
                        selected ? FontWeight.w700 : FontWeight.w500,
                    color: selected
                        ? const Color(0xFF1A56DB)
                        : const Color(0xFF94A3B8),
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class DepartmentMasterNavItem {
  final IconData icon;
  final String label;
  const DepartmentMasterNavItem({required this.icon, required this.label});
}

// ─── Department Card ───────────────────────────────────────────────────────────

class DepartmentMasterCard extends StatelessWidget {
  final Department department;
  const DepartmentMasterCard({super.key, required this.department});

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header Row ──
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon box
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: department.isActive
                        ? const Color(0xFFEFF6FF)
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    department.icon,
                    color: department.isActive
                        ? const Color(0xFF1A56DB)
                        : const Color(0xFF94A3B8),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),

                // Name & code
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        department.name,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: department.isActive
                              ? const Color(0xFF0F172A)
                              : const Color(0xFF94A3B8),
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'CODE: ${department.code}',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: department.isActive
                              ? const Color(0xFF64748B)
                              : const Color(0xFFB0BFCC),
                          letterSpacing: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),

                // Status badge
                DepartmentMasterStatusBadge(isActive: department.isActive),
              ],
            ),

            const SizedBox(height: 14),

            // ── Info Row ──
            Row(
              children: [
                Expanded(
                  child: DepartmentMasterInfoCell(
                    label: 'HOD NAME',
                    value: department.hodName,
                    isActive: department.isActive,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DepartmentMasterInfoCell(
                    label: 'FACULTY COUNT',
                    value: '${department.facultyCount} Members',
                    isActive: department.isActive,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Status Badge ─────────────────────────────────────────────────────────────

class DepartmentMasterStatusBadge extends StatelessWidget {
  final bool isActive;
  const DepartmentMasterStatusBadge({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isActive
              ? const Color(0xFFD4A017)
              : const Color(0xFFEF4444),
          width: 1.2,
        ),
      ),
      child: Text(
        isActive ? 'ACTIVE' : 'INACTIVE',
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: isActive ? const Color(0xFFD4A017) : const Color(0xFFEF4444),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

// ─── Info Cell ────────────────────────────────────────────────────────────────

class DepartmentMasterInfoCell extends StatelessWidget {
  final String label;
  final String value;
  final bool isActive;

  const DepartmentMasterInfoCell({
    super.key,
    required this.label,
    required this.value,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF94A3B8),
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isActive ? const Color(0xFF0F172A) : const Color(0xFF94A3B8),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}