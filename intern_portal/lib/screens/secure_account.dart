// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intern_portal/screens/login.dart';

class SecureAccountPage extends StatefulWidget {
  const SecureAccountPage({super.key});

  @override
  _SecureAccountPageState createState() => _SecureAccountPageState();
}

class _SecureAccountPageState extends State<SecureAccountPage> {
  bool _showOld = false;
  bool _showNew = false;
  bool _showConfirm = false;

  final _newPasswordController = TextEditingController();

  bool get _hasMinLength => _newPasswordController.text.length >= 8;
  bool get _hasNumber => RegExp(r'\d').hasMatch(_newPasswordController.text);
  bool get _hasSpecialChar => RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(_newPasswordController.text);
  bool get _hasUppercase => RegExp(r'[A-Z]').hasMatch(_newPasswordController.text);

  double get _passwordStrength {
    int met = 0;
    if (_hasMinLength) met++;
    if (_hasNumber) met++;
    if (_hasSpecialChar) met++;
    if (_hasUppercase) met++;
    return met / 4.0;
  }

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: TextButton(
          onPressed: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: Color(0xFF3B6EF0)),
        ),
        title: Text(
          "Secure Your Account",
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 16),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey[100]),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          children: [
            // Lock icon
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(color: Color(0xFFEFF4FF), borderRadius: BorderRadius.circular(18)),
              child: Icon(Icons.lock_reset_outlined, color: Color(0xFF3B6EF0), size: 36),
            ),
            SizedBox(height: 20),

            // Title
            Text(
              "Secure Your Account",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            SizedBox(height: 10),
            Text(
              "Welcome to your first login. Please update your\ntemporary password to continue to the student\nportal.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 13, color: Colors.grey[500], height: 1.6),
            ),
            SizedBox(height: 30),

            // Old Password
            _PasswordFieldSection(
              label: "Old Password",
              hint: "Enter current password",
              obscure: !_showOld,
              onToggle: () => setState(() => _showOld = !_showOld),
            ),
            SizedBox(height: 20),

            // New Password
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "New Password",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _newPasswordController,
              obscureText: !_showNew,
              decoration: InputDecoration(
                hintText: "Min. 8 characters",
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
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

            // Strength bar
            _PasswordStrengthBar(strength: _passwordStrength),
            SizedBox(height: 12),

            // Requirements checklist
            Row(
              children: [
                Expanded(
                  child: _RequirementRow(met: _hasMinLength, text: "8+ characters"),
                ),
                Expanded(
                  child: _RequirementRow(met: _hasNumber, text: "One number"),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _RequirementRow(met: _hasSpecialChar, text: "One special char"),
                ),
                Expanded(
                  child: _RequirementRow(met: _hasUppercase, text: "Uppercase letter"),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Confirm New Password
            _PasswordFieldSection(
              label: "Confirm New Password",
              hint: "Repeat new password",
              obscure: !_showConfirm,
              onToggle: () => setState(() => _showConfirm = !_showConfirm),
            ),
            SizedBox(height: 28),

            // Update Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF3B6EF0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
            SizedBox(height: 22),

            // Security Tip
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
                          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF3B6EF0), fontSize: 14),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Enable two-factor authentication (2FA) for an extra layer of protection on your account.",
                          style: TextStyle(fontSize: 12, color: Colors.grey[600], height: 1.5),
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
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
        ),
        SizedBox(height: 8),
        TextField(
          obscureText: obscure,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
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
          style: TextStyle(
            fontSize: 12,
            color: met ? Color(0xFF3B6EF0) : Colors.grey[400],
            fontWeight: met ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
