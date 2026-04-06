import 'package:flutter/material.dart';

class AddDepartmentApp extends StatelessWidget {
  const AddDepartmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Add Department',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A56DB)),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const AddDepartmentPage(),
    );
  }
}

class AddDepartmentPage extends StatelessWidget {
  const AddDepartmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
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
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: const Color(0xFF374151),
              radius: 18,
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: const [
                Icon(Icons.grid_view_rounded, size: 16, color: Color(0xFF1A56DB)),
                SizedBox(width: 6),
                Text(
                  'DEPARTMENT MANAGEMENT',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1A56DB),
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Add Department',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w800,
                color: Color(0xFF111827),
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Establish a new academic unit within the Central University registry.',
              style: TextStyle(fontSize: 13, color: Color(0xFF6B7280), height: 1.5),
            ),
            const SizedBox(height: 28),

            // Form Card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    // FIX: replaced deprecated withOpacity with withValues
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Department Name
                  const _DeptFieldLabel('Department Name'),
                  const SizedBox(height: 8),
                  const _DeptTextField(hint: 'e.g., Computer Science & Engineering'),
                  const SizedBox(height: 20),

                  // Department Code
                  const _DeptFieldLabel('Department Code'),
                  const SizedBox(height: 8),
                  _DeptTextField(
                    hint: 'E.G., CSE-2024',
                    // FIX: suffix is now properly passed via named parameter
                    suffix: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'UNIQUE',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF374151),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Head of Department
                  const _DeptFieldLabel('Head of Department (HOD)'),
                  const SizedBox(height: 8),
                  const _DeptDropdown(
                    hint: 'Select an academic head',
                    items: ['Dr. Shri Laxmi', 'Dr. Rajesh Kumar', 'Dr. Ananya Murthy'],
                  ),
                  const SizedBox(height: 20),

                  // Info Box
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Icon(Icons.info_outline, size: 18, color: Color(0xFF1A56DB)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'All new departments are automatically assigned to the current 2024-2025 Academic Year. You can modify this in Audit Logs later.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF1E40AF),
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 28),

            // Add Department Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1A56DB),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                  elevation: 0,
                ),
                child: const Text(
                  'Add Department',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Cancel
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: Color(0xFF374151),
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Widgets ────────────────────────────────────────────────────────────────

class _DeptFieldLabel extends StatelessWidget {
  final String text;
  const _DeptFieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Color(0xFF111827),
      ),
    );
  }
}

class _DeptTextField extends StatelessWidget {
  final String hint;
  final Widget? suffix;

  const _DeptTextField({
    required this.hint,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 14, color: Color(0xFF111827)),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Color(0xFFB0B8C9), fontSize: 14),
        suffixIcon: suffix,
        filled: true,
        fillColor: const Color(0xFFF3F5F9),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF1A56DB), width: 1.5),
        ),
      ),
    );
  }
}

class _DeptDropdown extends StatefulWidget {
  final String hint;
  final List<String> items;

  // FIX: removed unused 'value' parameter
  const _DeptDropdown({required this.hint, required this.items});

  @override
  State<_DeptDropdown> createState() => _DeptDropdownState();
}

class _DeptDropdownState extends State<_DeptDropdown> {
  String? _selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF3F5F9),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selected,
          hint: Text(widget.hint,
              style: const TextStyle(color: Color(0xFF9CA3AF), fontSize: 14)),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF6B7280)),
          items: widget.items
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e,
                        style: const TextStyle(fontSize: 14, color: Color(0xFF111827))),
                  ))
              .toList(),
          onChanged: (v) => setState(() => _selected = v),
        ),
      ),
    );
  }
}