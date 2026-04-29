import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

class StudentData {
  final String name;
  final String usn;
  final String department;
  final String email;
  final String phone;
  final String status;
  final Color avatarBg;

  const StudentData({
    required this.name,
    required this.usn,
    required this.department,
    required this.email,
    required this.phone,
    required this.status,
    required this.avatarBg,
  });
}

class FacultyWorkloadScreen extends StatefulWidget {
  const FacultyWorkloadScreen({super.key});
  @override
  State<FacultyWorkloadScreen> createState() => _FacultyWorkloadScreenState();
}

class _FacultyWorkloadScreenState extends State<FacultyWorkloadScreen> {
  final List<StudentData> _students = const [
    StudentData(
      name: 'Rahul Sharma',
      usn: '#CS2021',
      department: 'CSE',
      email: 'rahul.sharma@university.edu',
      phone: '+91 91234 56780',
      status: 'ONGOING',
      avatarBg: Color(0xFF1B5E7B),
    ),
    StudentData(
      name: 'Priya Verma',
      usn: '#CS2104',
      department: 'CSE',
      email: 'priya.verma@university.edu',
      phone: '+91 91234 56781',
      status: 'COMPLETED',
      avatarBg: Color(0xFF7B3A2E),
    ),
    StudentData(
      name: 'Arjun Nair',
      usn: '#CS1988',
      department: 'AI',
      email: 'arjun.nair@university.edu',
      phone: '+91 91234 56782',
      status: 'ONGOING',
      avatarBg: Color(0xFF2C3E50),
    ),
    StudentData(
      name: 'Ananya Iyer',
      usn: '#CS2245',
      department: 'CSE',
      email: 'ananya.iyer@university.edu',
      phone: '+91 91234 56783',
      status: 'PENDING APPROVAL',
      avatarBg: Color(0xFF4A2040),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      appBar: CommonAppBar(title: "Guide Workload", showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFacultyProfileCard(),
            const SizedBox(height: 24),
            _buildOverviewHeader(),
            const SizedBox(height: 14),
            ..._students.map((s) => Padding(padding: const EdgeInsets.only(bottom: 12), child: _buildStudentCard(s))),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildFacultyProfileCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: 110,
                height: 130,
                color: const Color(0xFF1B7A8A),
                child: const Icon(Icons.person, size: 70, color: Colors.white70),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'FACULTY PROFILE',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1565C0),
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Dr. Jose Alex Mathew',
                          style: GoogleFonts.inter(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                            height: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.verified, color: Color(0xFF1565C0), size: 18),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Associate Professor',
                    style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w500, color: Colors.black87),
                  ),
                  const SizedBox(height: 2),
                  Text('CSE Department', style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[500])),
                  const SizedBox(height: 10),
                  _buildContactRow(Icons.email_outlined, 'jose.alex@university.edu'),
                  const SizedBox(height: 6),
                  _buildContactRow(Icons.phone_outlined, '+91 98765 43210'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.grey[600]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700]),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'OVERVIEW',
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w700,
            color: Colors.grey[500],
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 6),
        Row(
          children: [
            Text(
              'Assigned Students ',
              style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            Text(
              '(8)',
              style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF1565C0)),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Text(
                    'View All',
                    style: GoogleFonts.inter(fontSize: 14, color: Color(0xFF1565C0), fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 2),
                  Icon(Icons.chevron_right, color: Color(0xFF1565C0), size: 20),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStudentCard(StudentData student) {
    final statusConfig = _getStatusConfig(student.status);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: 68,
                height: 80,
                color: student.avatarBg,
                child: const Icon(Icons.person, color: Colors.white70, size: 42),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          student.name,
                          style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
                        ),
                      ),
                      const SizedBox(width: 8),
                      _buildStatusBadge(student.status, statusConfig['bg'] as Color, statusConfig['text'] as Color),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'USN: ${student.usn}',
                        style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text('•', style: GoogleFonts.inter(color: Colors.grey[400], fontSize: 12)),
                      ),
                      Text(
                        student.department,
                        style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildContactRow(Icons.email_outlined, student.email),
                  const SizedBox(height: 4),
                  _buildContactRow(Icons.phone_outlined, student.phone),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, Color> _getStatusConfig(String status) {
    switch (status) {
      case 'ONGOING':
        return {'bg': const Color(0xFFE8F5E9), 'text': const Color(0xFF2E7D32)};
      case 'COMPLETED':
        return {'bg': const Color(0xFFE8EAF6), 'text': const Color(0xFF3949AB)};
      case 'PENDING APPROVAL':
        return {'bg': const Color(0xFFFFF3E0), 'text': const Color(0xFFE65100)};
      default:
        return {'bg': const Color(0xFFEEEEEE), 'text': Colors.grey};
    }
  }

  Widget _buildStatusBadge(String label, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(20)),
      child: Text(
        label,
        style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w700, color: textColor, letterSpacing: 0.4),
      ),
    );
  }
}
