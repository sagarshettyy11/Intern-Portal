import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;
  bool _keepSignedIn = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Full blue gradient background
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF5B8BFB), Color(0xFF3B6EF0)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Decorative faded column shapes in background
          Positioned.fill(
            child: CustomPaint(painter: _ColumnPatternPainter()),
          ),

          // Main content
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Logo row ──────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.school,
                            color: Color(0xFF3B6EF0), size: 22),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        "InternPortal",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

                // ── Hero text ─────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Empowering your\nprofessional journey\nthrough academic\nexcellence.",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Connecting students with industry leaders to faster\n"
                        "growth, innovation, and practical learning.",
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Spacer keeps the blue section tall (~45 % of screen)
                SizedBox(height: screenHeight * 0.06),

                // ── White login card ──────────────────────────────────────
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(28)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          const Text(
                            "Student Login",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Welcome back! Please enter your details.",
                            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 20),

                          // Internship ID
                          const Text(
                            "Internship ID",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            decoration: InputDecoration(
                              hintText: "Enter your Internship ID",
                              hintStyle: TextStyle(
                                  color: Colors.grey[400], fontSize: 14),
                              prefixIcon: Icon(Icons.badge_outlined,
                                  color: Colors.grey[400], size: 20),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color(0xFF3B6EF0)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Password label + Forgot Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Password",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF3B6EF0),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Password field
                          TextField(
                            obscureText: _obscurePassword,
                            decoration: InputDecoration(
                              hintText: "••••••••",
                              hintStyle: TextStyle(
                                  color: Colors.grey[500], fontSize: 16),
                              prefixIcon: Icon(Icons.lock_outline,
                                  color: Colors.grey[400], size: 20),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  color: Colors.grey[400],
                                  size: 20,
                                ),
                                onPressed: () => setState(
                                    () => _obscurePassword = !_obscurePassword),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 14, horizontal: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.grey[300]!),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(
                                    color: Color(0xFF3B6EF0)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Keep me signed in
                          Row(
                            children: [
                              Checkbox(
                                value: _keepSignedIn,
                                onChanged: (v) =>
                                    setState(() => _keepSignedIn = v!),
                                activeColor: const Color(0xFF3B6EF0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                                side: BorderSide(color: Colors.grey[400]!),
                              ),
                              Text(
                                "Keep me signed in",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[700]),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),

                          // Sign In button
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF3B6EF0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                elevation: 0,
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Sign In",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward,
                                      color: Colors.white, size: 18),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Don't have an account?
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Don't have an account? ",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.grey[600]),
                                children: const [
                                  TextSpan(
                                    text: "Contact Department",
                                    style: TextStyle(
                                      color: Color(0xFF3B6EF0),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // Help Center + Support
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.help_outline,
                                    size: 14, color: Colors.grey[500]),
                                const SizedBox(width: 4),
                                Text("Help Center",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[500])),
                                const SizedBox(width: 16),
                                Icon(Icons.mail_outline,
                                    size: 14, color: Colors.grey[500]),
                                const SizedBox(width: 4),
                                Text("Support",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[500])),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),

                          // Copyright
                          Center(
                            child: Text(
                              "© 2023 University Academic Internship Portal. All rights reserved.",
                              style: TextStyle(
                                  fontSize: 10, color: Colors.grey[400]),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Draws faint decorative pill/column shapes on the blue background
class _ColumnPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.08)
      ..style = PaintingStyle.fill;

    final colWidth = size.width * 0.13;
    final colHeight = size.height * 0.50;
    const topY = 20.0;

    final positions = [
      size.width * 0.28,
      size.width * 0.44,
      size.width * 0.60,
      size.width * 0.76,
    ];

    for (final x in positions) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, topY, colWidth, colHeight),
          Radius.circular(colWidth / 2),
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}