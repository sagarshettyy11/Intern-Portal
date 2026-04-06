import 'package:flutter/material.dart';

class ScholarFlowApp extends StatelessWidget {
  const ScholarFlowApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScholarFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A56DB)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const FacultyMasterPage(),
    );
  }
}

class Faculty {
  final String name;
  final String initials;
  final String role; // 'HOD' | 'GUIDE'
  final bool isActive;
  final String department;
  final String designation;
  final String? email;
  final String? phone;

  const Faculty({
    required this.name,
    required this.initials,
    required this.role,
    required this.isActive,
    required this.department,
    required this.designation,
    this.email,
    this.phone,
  });
}

// ─────────────────────────────────────────────
// Main page
// ─────────────────────────────────────────────
class FacultyMasterPage extends StatefulWidget {
  const FacultyMasterPage({super.key});

  @override
  State<FacultyMasterPage> createState() => _FacultyMasterPageState();
}

class _FacultyMasterPageState extends State<FacultyMasterPage> {
  int _selectedIndex = 1; // Faculty tab selected by default

  final List<Faculty> _facultyList = const [
    Faculty(
      name: 'Shri Laxmi',
      initials: 'SL',
      role: 'HOD',
      isActive: true,
      department: 'Information Science Engineering',
      designation: 'Assistant Professor',
      email: 'shri.laxmi@university.edu',
      phone: '+91 98765 43210',
    ),
    Faculty(
      name: 'Rajesh Kumar',
      initials: 'RK',
      role: 'GUIDE',
      isActive: true,
      department: 'Computer Science Engineering',
      designation: 'Professor',
      email: 'rajesh.k@university.edu',
      phone: '+91 91234 56789',
    ),
    Faculty(
      name: 'Ananya Murthy',
      initials: 'AM',
      role: 'GUIDE',
      isActive: false,
      department: 'Mechanical Engineering',
      designation: 'Associate Professor',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: _buildAppBar(),
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNav(),
      floatingActionButton: _buildFAB(),
    );
  }

  // ── AppBar ──────────────────────────────────
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: const Icon(Icons.menu, color: Color(0xFF1A56DB)),
      title: const Text(
        'Scholar Flow',
        style: TextStyle(
          color: Color(0xFF1A56DB),
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
      ),
      actions: [
        CircleAvatar(
          backgroundColor: const Color(0xFF1A56DB),
          radius: 18,
          child: const Text('AU',
              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  // ── Body ────────────────────────────────────
  Widget _buildBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('ADMINISTRATION',
                      style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1A56DB),
                          letterSpacing: 1.2)),
                  SizedBox(height: 4),
                  Text('Faculty Master',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827))),
                  SizedBox(height: 4),
                  Text('Manage institutional human resources and roles.',
                      style: TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                ],
              ),
              IconButton(
                icon: const Icon(Icons.more_vert, color: Color(0xFF6B7280)),
                onPressed: () {},
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Search bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                )
              ],
            ),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search faculty...',
                      hintStyle: TextStyle(color: Color(0xFF9CA3AF), fontSize: 14),
                      prefixIcon: Icon(Icons.search, color: Color(0xFF9CA3AF)),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A56DB).withValues(alpha : 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.filter_list, color: Color(0xFF1A56DB), size: 20),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Faculty cards
          ..._facultyList.map((f) => _FacultyCard(
                faculty: f,
                onResetPassword: () => _showResetPasswordDialog(f),
                onDeactivate: () => _showDeactivateDialog(f),
              )),
        ],
      ),
    );
  }

  // ── Bottom nav ──────────────────────────────
  Widget _buildBottomNav() {
    final items = [
      (Icons.dashboard_outlined, 'DASHBOARD'),
      (Icons.school_outlined, 'FACULTY'),
      (Icons.people_outline, 'STUDENTS'),
      (Icons.work_outline, 'INTERNSHIPS'),
      (Icons.person_outline, 'PROFILE'),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, -2))],
      ),
      child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF1A56DB),
        unselectedItemColor: const Color(0xFF9CA3AF),
        selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
        backgroundColor: Colors.transparent,
        elevation: 0,
        items: items
            .map((e) => BottomNavigationBarItem(icon: Icon(e.$1), label: e.$2))
            .toList(),
      ),
    );
  }

  // ── FAB ─────────────────────────────────────
  Widget _buildFAB() {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: const Color(0xFF1A56DB),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Icon(Icons.person_add, color: Colors.white),
    );
  }

  // ── Dialogs ─────────────────────────────────
  void _showResetPasswordDialog(Faculty faculty) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _ResetPasswordSheet(faculty: faculty),
    );
  }

  void _showDeactivateDialog(Faculty faculty) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _DeactivateFacultySheet(faculty: faculty),
    );
  }
}

// ─────────────────────────────────────────────
// Faculty Card
// ─────────────────────────────────────────────
class _FacultyCard extends StatelessWidget {
  final Faculty faculty;
  final VoidCallback onResetPassword;
  final VoidCallback onDeactivate;

  const _FacultyCard({
    required this.faculty,
    required this.onResetPassword,
    required this.onDeactivate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top row: avatar + name/badge + action icons
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFFE8EEF9),
                  child: Text(
                    faculty.initials,
                    style: const TextStyle(
                      color: Color(0xFF1A56DB),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Name + badges
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(faculty.name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              color: Color(0xFF111827))),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          _RoleBadge(label: faculty.role),
                          const SizedBox(width: 8),
                          _StatusDot(isActive: faculty.isActive),
                          const SizedBox(width: 4),
                          Text(
                            faculty.isActive ? 'Active' : 'Inactive',
                            style: TextStyle(
                              fontSize: 12,
                              color: faculty.isActive
                                  ? const Color(0xFF16A34A)
                                  : const Color(0xFF9CA3AF),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Action buttons
                Row(
                  children: [
                    _ActionIcon(
                      icon: Icons.edit_outlined,
                      color: const Color(0xFF6B7280),
                      onTap: () {},
                    ),
                    const SizedBox(width: 4),
                    _ActionIcon(
                      icon: Icons.lock_outline,
                      color: const Color(0xFF6B7280),
                      onTap: onResetPassword,
                    ),
                    const SizedBox(width: 4),
                    _ActionIcon(
                      icon: Icons.person_off_outlined,
                      color: faculty.isActive
                          ? const Color(0xFF6B7280)
                          : const Color(0xFFEF4444),
                      onTap: onDeactivate,
                    ),
                  ],
                ),
              ],
            ),

            // Details (only if info exists)
            if (faculty.department.isNotEmpty || faculty.designation.isNotEmpty) ...[
              const SizedBox(height: 14),
              _InfoRow(
                icon: Icons.grid_view_rounded,
                primary: faculty.department,
                secondary: 'Department',
              ),
              const SizedBox(height: 8),
              _InfoRow(
                icon: Icons.school_outlined,
                primary: faculty.designation,
                secondary: 'Designation',
              ),
            ],
            if (faculty.email != null) ...[
              const SizedBox(height: 8),
              _InfoRow(
                icon: Icons.alternate_email,
                primary: faculty.email!,
              ),
            ],
            if (faculty.phone != null) ...[
              const SizedBox(height: 8),
              _InfoRow(
                icon: Icons.phone_outlined,
                primary: faculty.phone!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Small widgets
// ─────────────────────────────────────────────
class _RoleBadge extends StatelessWidget {
  final String label;
  const _RoleBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EEF9),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: Color(0xFF1A56DB),
          fontWeight: FontWeight.w700,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  final bool isActive;
  const _StatusDot({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? const Color(0xFF16A34A) : const Color(0xFF9CA3AF),
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionIcon({required this.icon, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, size: 22, color: color),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String primary;
  final String? secondary;

  const _InfoRow({required this.icon, required this.primary, this.secondary});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: const Color(0xFF9CA3AF)),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(primary,
                style: const TextStyle(
                    fontSize: 13, color: Color(0xFF374151), fontWeight: FontWeight.w500)),
            if (secondary != null)
              Text(secondary!,
                  style: const TextStyle(fontSize: 11, color: Color(0xFF9CA3AF))),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────
// Reset Password Bottom Sheet
// ─────────────────────────────────────────────
class _ResetPasswordSheet extends StatelessWidget {
  final Faculty faculty;
  const _ResetPasswordSheet({required this.faculty});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFD1D5DB),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),

          // Icon + title
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.lock_reset, color: Color(0xFF1A56DB), size: 26),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Reset Password',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF111827))),
                  Text('Reset login password for ${faculty.name}?',
                      style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280))),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Info box
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFBEB),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFDE68A)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Icon(Icons.info_outline, size: 18, color: Color(0xFFD97706)),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'A new password will be auto-generated: first name + last 4 digits of contact number',
                    style: TextStyle(fontSize: 13, color: Color(0xFF92400E)),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Reset button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A56DB),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text('Reset Password',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
            ),
          ),

          const SizedBox(height: 10),

          // Cancel
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel',
                  style: TextStyle(color: Color(0xFF374151), fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Deactivate Faculty Bottom Sheet
// ─────────────────────────────────────────────
class _DeactivateFacultySheet extends StatelessWidget {
  final Faculty faculty;
  const _DeactivateFacultySheet({required this.faculty});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFD1D5DB),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 28),

          // Warning icon
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: const Color(0xFFFEE2E2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.warning_amber_rounded, color: Color(0xFFDC2626), size: 30),
          ),

          const SizedBox(height: 16),

          // Title
          const Text(
            'Deactivate Faculty',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Color(0xFFDC2626)),
          ),

          const SizedBox(height: 12),

          // Description
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: const TextStyle(fontSize: 14, color: Color(0xFF374151), height: 1.5),
              children: [
                const TextSpan(text: 'Are you sure you want to deactivate '),
                TextSpan(
                    text: faculty.name,
                    style: const TextStyle(fontWeight: FontWeight.w700)),
                const TextSpan(text: '? They will no longer be able to log in.'),
              ],
            ),
          ),

          const SizedBox(height: 28),

          // Deactivate button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDC2626),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: const Text('Yes, Deactivate',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w700, fontSize: 15)),
            ),
          ),

          const SizedBox(height: 10),

          // Cancel
          SizedBox(
            width: double.infinity,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel',
                  style: TextStyle(color: Color(0xFF374151), fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }
}