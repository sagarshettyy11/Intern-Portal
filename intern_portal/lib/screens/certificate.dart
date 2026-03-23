import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

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
                width: 32,
                height: 32,
                decoration: BoxDecoration(color: Color(0xFF3B6EF0), borderRadius: BorderRadius.circular(8)),
                child: Icon(Icons.school, color: Colors.white, size: 18),
              ),
              SizedBox(width: 6),
              Text(
                "InternPortal",
                style: GoogleFonts.inter(color: Colors.black87, fontWeight: FontWeight.w700, fontSize: 15),
              ),
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
            Text(
              "Internship Certificate",
              style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 4),
            Text(
              "VERIFIED ACHIEVEMENT",
              style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF3B6EF0), letterSpacing: 1.5),
            ),
            SizedBox(height: 12),
            Text(
              "This certificate honors your outstanding performance\nand commitment during the Frontend Development\nExcellence program.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[600], height: 1.5),
            ),
            SizedBox(height: 24),
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
                  SizedBox(
                    width: 72,
                    height: 72,
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
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF3B6EF0),
                      letterSpacing: 1.5,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text("This is to certify that", style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[500])),
                  SizedBox(height: 16),
                  Text(
                    "Alex Johnson",
                    style: GoogleFonts.inter(
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
                    style: GoogleFonts.inter(fontSize: 14, color: Colors.black54, height: 1.6),
                  ),
                  SizedBox(height: 28),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "J. Miller",
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              color: Colors.black87,
                            ),
                          ),
                          Container(width: 100, height: 1, color: Colors.black45),
                          SizedBox(height: 4),
                          Text(
                            "PROGRAM DIRECTOR",
                            style: GoogleFonts.inter(fontSize: 9, color: Colors.grey[500], letterSpacing: 1),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(4)),
                            child: Icon(Icons.qr_code_2, color: Colors.white, size: 44),
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "TC-2023-8842",
                                style: GoogleFonts.inter(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87),
                              ),
                              Text(
                                "VERIFICATION ID",
                                style: GoogleFonts.inter(fontSize: 9, color: Colors.grey[500], letterSpacing: 1),
                              ),
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
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.download_rounded, color: Colors.white),
                label: Text(
                  "Download as PDF",
                  style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3B6EF0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 0,
                ),
              ),
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.share_outlined, color: Colors.black87),
                label: Text(
                  "Share Achievement",
                  style: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.black87),
                ),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Colors.grey[300]!),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            SizedBox(height: 18),
            TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.arrow_back, color: Colors.grey[600], size: 16),
              label: Text("View Previous Internships", style: GoogleFonts.inter(color: Colors.grey[600], fontSize: 13)),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNav(
        currentIndex: 3,
        onTap: (index) => BottomNavController.onItemTapped(context, index),
      ),
    );
  }
}
