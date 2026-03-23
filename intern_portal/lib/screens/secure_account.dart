import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/screens/login.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

class SecureAccountPage extends StatefulWidget {
  const SecureAccountPage({super.key});
  @override
  SecureAccountPageState createState() => SecureAccountPageState();
}

class SecureAccountPageState extends State<SecureAccountPage> {
  bool _showOld = false;
  bool _showNew = false;
  bool _showConfirm = false;
  final newPasswordController = TextEditingController();
  bool get hasMinLength => newPasswordController.text.length >= 8;
  bool get hasNumber => RegExp(r'\d').hasMatch(newPasswordController.text);
  bool get hasSpecialChar => RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(newPasswordController.text);
  bool get hasUppercase => RegExp(r'[A-Z]').hasMatch(newPasswordController.text);
  double get passwordStrength {
    int met = 0;
    if (hasMinLength) met++;
    if (hasNumber) met++;
    if (hasSpecialChar) met++;
    if (hasUppercase) met++;
    return met / 4.0;
  }

  @override
  void initState() {
    super.initState();
    newPasswordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CommonAppBar(title: "Secure your Account", showBack: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(color: Color(0xFFEFF4FF), borderRadius: BorderRadius.circular(18)),
              child: Icon(Icons.lock_reset_outlined, color: Color(0xFF3B6EF0), size: 36),
            ),
            SizedBox(height: 20),
            Text(
              "Secure Your Account",
              style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 10),
            Text(
              "Welcome to your first login. Please update your\ntemporary password to continue to the student portal.",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[500], height: 1.6),
            ),
            SizedBox(height: 30),
            _PasswordFieldSection(
              label: "Old Password",
              hint: "Enter current password",
              obscure: !_showOld,
              onToggle: () => setState(() => _showOld = !_showOld),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "New Password",
                style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: newPasswordController,
              obscureText: !_showNew,
              decoration: InputDecoration(
                hintText: "Min. 8 characters",
                hintStyle: GoogleFonts.inter(color: Colors.grey[400], fontSize: 14),
                suffixIcon: IconButton(
                  icon: Icon(
                    _showNew ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    color: Colors.grey[400],
                    size: 20,
                  ),
                  onPressed: () => setState(() => _showNew = !_showNew),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Color(0xFF3B6EF0)),
                ),
              ),
            ),
            SizedBox(height: 10),
            _PasswordStrengthBar(strength: passwordStrength),
            SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _RequirementRow(met: hasMinLength, text: "8+ characters"),
                ),
                Expanded(
                  child: _RequirementRow(met: hasNumber, text: "One number"),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _RequirementRow(met: hasSpecialChar, text: "One special char"),
                ),
                Expanded(
                  child: _RequirementRow(met: hasUppercase, text: "Uppercase letter"),
                ),
              ],
            ),
            SizedBox(height: 20),
            _PasswordFieldSection(
              label: "Confirm New Password",
              hint: "Repeat new password",
              obscure: !_showConfirm,
              onToggle: () => setState(() => _showConfirm = !_showConfirm),
            ),
            SizedBox(height: 28),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3B6EF0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginPage()));
                      },
                      child: Text(
                        "Update Password",
                        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
            SizedBox(height: 22),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(color: Color(0xFFEFF4FF), borderRadius: BorderRadius.circular(12)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.shield_outlined, color: Color(0xFF3B6EF0), size: 22),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Security Tip",
                          style: GoogleFonts.inter(fontWeight: FontWeight.bold, color: Color(0xFF3B6EF0), fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Enable two-factor authentication (2FA) for an extra layer of protection on your account.",
                          style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[600], height: 1.5),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _PasswordFieldSection extends StatelessWidget {
  final String label, hint;
  final bool obscure;
  final VoidCallback onToggle;
  const _PasswordFieldSection({required this.label, required this.hint, required this.obscure, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        SizedBox(height: 8),
        TextField(
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(color: Colors.grey[400], fontSize: 14),
            suffixIcon: IconButton(
              icon: Icon(
                obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                color: Colors.grey[400],
                size: 20,
              ),
              onPressed: onToggle,
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Color(0xFF3B6EF0)),
            ),
          ),
        ),
      ],
    );
  }
}

class _PasswordStrengthBar extends StatelessWidget {
  final double strength;
  const _PasswordStrengthBar({required this.strength});

  @override
  Widget build(BuildContext context) {
    final segments = 4;
    return Row(
      children: List.generate(segments, (i) {
        final filled = (i + 1) / segments <= strength;
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < segments - 1 ? 6 : 0),
            height: 4,
            decoration: BoxDecoration(
              color: filled ? Color(0xFF3B6EF0) : Colors.grey[200],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}

class _RequirementRow extends StatelessWidget {
  final bool met;
  final String text;
  const _RequirementRow({required this.met, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          met ? Icons.check_circle_outline : Icons.radio_button_unchecked,
          size: 16,
          color: met ? Color(0xFF3B6EF0) : Colors.grey[400],
        ),
        SizedBox(width: 6),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: met ? Color(0xFF3B6EF0) : Colors.grey[400],
            fontWeight: met ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
