import 'package:flutter/material.dart';

class CertificatePage extends StatelessWidget {
  const CertificatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF0F4FF),
      appBar: AppBar(
        backgroundColor: Color(0xFFF0F4FF),
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black87),
        actions: [
          Row(
            children: [
              Container(
                width: 32, height: 32,
                decoration: BoxDecoration(color: Color(0xFF3B6EF0), borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.school, color: Colors.white, size: 18),
              ),
              SizedBox(width: 6),
              Text("InternPortal",
                  style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 15)),
              SizedBox(width: 12),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: CircleAvatar(
              radius: 16,
              backgroundColor: Colors.orange[200],
              child: Icon(Icons.person, size: 18, color: Colors.orange[800]),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 10),

            // Title section
            Text(
              "Internship Certificate",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 4),
            Text(
              "VERIFIED ACHIEVEMENT",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF3B6EF0), letterSpacing: 1.5),
            ),
            SizedBox(height: 12),
            Text(
              "This certificate honors your outstanding performance\nand commitment during the Frontend Development\nExcellence program.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey[600], height: 1.5),
            ),
            SizedBox(height: 24),

            // Certificate card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: .08), blurRadius: 20, offset: Offset(0, 4)),
                ],
              ),
              child: Column(
                children: [
                  // Shield icon
                  // ignore: sized_box_for_whitespace
                  Container(
                    width: 72, height: 72,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.shield, color: Color(0xFF3B6EF0), size: 72),
                        Icon(Icons.check, color: Colors.white, size: 32),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  Text(
                    "CERTIFICATE OF COMPLETION",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF3B6EF0),
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text("This is to certify that",
                      style: TextStyle(fontSize: 13, color: Colors.grey[500])),
                  SizedBox(height: 16),

                  Text(
                    "Alex Johnson",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  SizedBox(height: 16),

                  Text(
                    "has successfully completed a 12-week\nintensive internship in\nFrontend Development Excellence.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.black54, height: 1.6),
                  ),
                  SizedBox(height: 28),

                  // Signature + QR row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("J. Miller",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.black87)),
                          Container(width: 100, height: 1, color: Colors.black45),
                          SizedBox(height: 4),
                          Text("PROGRAM DIRECTOR",
                              style: TextStyle(fontSize: 9, color: Colors.grey[500], letterSpacing: 1)),
                        ],
                      ),
                      Row(
                        children: [
                          // QR code simulation
                          Container(
                            width: 52, height: 52,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(Icons.qr_code_2, color: Colors.white, size: 44),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("TC-2023-8842",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                              Text("VERIFICATION ID",
                                  style: TextStyle(fontSize: 9, color: Colors.grey[500], letterSpacing: 1)),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 22),

            // Download button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.download_rounded, color: Colors.white),
                label: Text("Download as PDF",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3B6EF0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
              ),
            ),
            SizedBox(height: 12),

            // Share button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.share_outlined, color: Colors.black87),
                label: Text("Share Achievement",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87)),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey[300]!),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            SizedBox(height: 18),

            // View Previous
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.arrow_back, color: Colors.grey[600], size: 16),
              label: Text("View Previous Internships",
                  style: TextStyle(color: Colors.grey[600], fontSize: 13)),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNav(currentIndex: 3),
    );
  }
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