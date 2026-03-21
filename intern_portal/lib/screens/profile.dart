import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              width: 30, height: 30,
              decoration: BoxDecoration(color: Color(0xFF3B6EF0), borderRadius: BorderRadius.circular(7)),
              child: Icon(Icons.school, color: Colors.white, size: 17),
            ),
            SizedBox(width: 8),
            Text("InternPortal",
                style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 16)),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.notifications_outlined, color: Colors.black87), onPressed: () {}),
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.brown[200],
              child: Icon(Icons.person, size: 18, color: Colors.brown[700]),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey[200]),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Blue profile header card
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
                      width: 70, height: 70,
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
                            Text("Alex Rivera",
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                            SizedBox(width: 6),
                            Container(
                              width: 14, height: 14,
                              decoration: BoxDecoration(color: Colors.greenAccent, shape: BoxShape.circle),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text("Internship No:", style: TextStyle(fontSize: 12, color: Colors.white70)),
                        Text("2021CS101", style: TextStyle(fontSize: 12, color: Colors.white)),
                        Text("Computer Science", style: TextStyle(fontSize: 12, color: Colors.white)),
                        SizedBox(height: 8),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text("VERIFIED STUDENT",
                              style: TextStyle(fontSize: 10, color: Colors.white, fontWeight: FontWeight.w600, letterSpacing: 0.5)),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Personal Information
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Personal Information",
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87)),
                      TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFEFF4FF),
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text("Quick Edit",
                            style: TextStyle(color: Color(0xFF3B6EF0), fontSize: 12, fontWeight: FontWeight.w600)),
                      ),
                    ],
                  ),
                  Text("Update your contact details & basic information.",
                      style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                  SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(child: _InfoField(label: "FULL NAME", value: "Alex Rivera")),
                      SizedBox(width: 16),
                      Expanded(child: _InfoField(label: "REGISTRATION NUMBER", value: "2021CS101")),
                    ],
                  ),
                  SizedBox(height: 6),
                  Text("Your phone number, if be diffid on mime.", style: TextStyle(fontSize: 11, color: Colors.grey[400])),
                  SizedBox(height: 10),

                  Row(
                    children: [
                      Expanded(child: _InfoField(label: "PHONE NUMBER", value: "+1 (555) 012-3456")),
                      SizedBox(width: 16),
                      Expanded(child: _InfoField(label: "EMAIL ADDRESS", value: "alex.rivera@university.edu")),
                    ],
                  ),
                  SizedBox(height: 10),
                  _InfoField(label: "RESIDENTIAL ADDRESS", value: "42 Academic Way, University District, State 90210"),
                  SizedBox(height: 24),

                  // Academic Record
                  Text("Academic Record", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87)),
                  Text("Verified institutional data", style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                  SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(child: _AcademicBox(label: "ENROLLMENT", value: "Comp Science", isBlue: true)),
                      SizedBox(width: 12),
                      Expanded(child: _AcademicBox(label: "YEAR", value: "3rd Year")),
                    ],
                  ),
                  SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _AcademicBox(label: "CURRENT CGPA", value: "3.85 / 4.0")),
                      SizedBox(width: 12),
                      Expanded(child: _AcademicBox(label: "CREDITS EARNED", value: "92 Credits")),
                    ],
                  ),
                  SizedBox(height: 24),

                  // Assigned Internship Guide
                  Text("Assigned Internship Guide",
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87)),
                  SizedBox(height: 12),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: Offset(0, 2))],
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(radius: 22, backgroundColor: Colors.orange[200],
                            child: Icon(Icons.person, color: Colors.orange[700])),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Samantha Collins",
                                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black87)),
                              Text("s.collins@university.edu",
                                  style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(color: Color(0xFFEFF4FF), borderRadius: BorderRadius.circular(8)),
                          child: Icon(Icons.mail_outline, color: Color(0xFF3B6EF0), size: 18),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),

                  // Quick Links
                  Text("Quick Links", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87)),
                  SizedBox(height: 12),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: Offset(0, 2))],
                    ),
                    child: Column(
                      children: [
                        _QuickLinkTile(icon: Icons.help_outline, title: "FAQ & Support"),
                        Divider(height: 1, indent: 50),
                        _QuickLinkTile(icon: Icons.article_outlined, title: "Internship Guidelines"),
                        Divider(height: 1, indent: 50),
                        _QuickLinkTile(icon: Icons.menu_book_outlined, title: "Student Handbook"),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),

                  // Campus Location
                  Text("Campus Location", style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87)),
                  SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: 160,
                      width: double.infinity,
                      color: Color(0xFF2D6B6B),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          // Grid lines simulation
                          CustomPaint(painter: _MapGridPainter()),
                          // Location pin
                          Icon(Icons.location_on, color: Color(0xFF3B6EF0), size: 36),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),

            // Footer
            Container(
              padding: EdgeInsets.symmetric(vertical: 14),
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [
                    Text("ALEX JOHNSON", style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey[600])),
                    Text("ID: 2024-ST-019", style: TextStyle(fontSize: 11, color: Colors.grey[400])),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNav(currentIndex: 4),
    );
  }
}

class _InfoField extends StatelessWidget {
  final String label, value;
  const _InfoField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 10, color: Colors.grey[500], fontWeight: FontWeight.w600, letterSpacing: 0.4)),
        SizedBox(height: 3),
        Text(value, style: TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w500)),
      ],
    );
  }
}

class _AcademicBox extends StatelessWidget {
  final String label, value;
  final bool isBlue;
  const _AcademicBox({required this.label, required this.value, this.isBlue = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 6, offset: Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[500], fontWeight: FontWeight.w600, letterSpacing: 0.4)),
          SizedBox(height: 6),
          Text(value,
              style: TextStyle(
                  fontSize: 14, fontWeight: FontWeight.w600,
                  color: isBlue ? Color(0xFF3B6EF0) : Colors.black87)),
        ],
      ),
    );
  }
}

class _QuickLinkTile extends StatelessWidget {
  final IconData icon;
  final String title;
  const _QuickLinkTile({required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Row(
        children: [
          // Blue icon box
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF3B6EF0), size: 18),
          ),
          const SizedBox(width: 14),
          // Title
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
          // Chevron
          Icon(Icons.chevron_right, color: Colors.grey[400], size: 20),
        ],
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.12)
      ..strokeWidth = 1;
    for (double x = 0; x < size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    // Diagonal lines for road simulation
    final roadPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..strokeWidth = 6;
    canvas.drawLine(Offset(0, size.height * 0.4), Offset(size.width, size.height * 0.4), roadPaint);
    canvas.drawLine(Offset(size.width * 0.5, 0), Offset(size.width * 0.5, size.height), roadPaint);
  }

  @override
  bool shouldRepaint(_) => false;
}

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  const _BottomNav({required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.grey[200]!))),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF3B6EF0),
        unselectedItemColor: Colors.grey[500],
        selectedLabelStyle: TextStyle(fontSize: 9, fontWeight: FontWeight.w600),
        unselectedLabelStyle: TextStyle(fontSize: 9),
        elevation: 0,
        items: [
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