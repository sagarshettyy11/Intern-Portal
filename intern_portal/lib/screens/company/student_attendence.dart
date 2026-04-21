import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

class AttendanceManagementScreen extends StatefulWidget {
  const AttendanceManagementScreen({super.key});
  @override
  State<AttendanceManagementScreen> createState() => _AttendanceManagementScreenState();
}

class _AttendanceManagementScreenState extends State<AttendanceManagementScreen> {
  int _selectedDay = 9;
  String _selectedStatus = 'PRESENT';
  final TextEditingController _remarksController = TextEditingController();
  static const _weekDays = ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'];
  static const _calRows = [
    [30, 31, 1, 2, 3, 4, 5],
    [6, 7, 8, 9, 10, 11, 12],
    [13, 14, 15, 16, 17, 18, 19],
  ];
  static const _dayStatus = <int, String>{
    30: 'prev',
    31: 'prev',
    1: 'present',
    2: 'present',
    3: 'present',
    4: 'holiday',
    5: 'holiday',
    6: 'present',
    7: 'present',
    8: 'present',
    9: 'present',
    10: 'future',
    11: 'holiday',
    12: 'holiday',
    13: 'future',
    14: 'future',
    15: 'future',
    16: 'future',
    17: 'future',
    18: 'holiday',
    19: 'holiday',
  };

  Color _dotColor(String key) {
    switch (key) {
      case 'present':
        return const Color(0xFF1A56DB);
      case 'absent':
        return const Color(0xFFE02424);
      case 'leave':
        return const Color(0xFFF0A500);
      case 'holiday':
        return const Color(0xFFD1D5DB);
      default:
        return Colors.transparent;
    }
  }

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F8),
      appBar: CommonAppBar(title: "Add Attendance", showBack: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStudentCard(),
            const SizedBox(height: 14),
            _buildStatsRow(),
            const SizedBox(height: 14),
            _buildActionButtons(),
            const SizedBox(height: 14),
            _buildCalendarCard(),
            const SizedBox(height: 14),
            _buildUpdateEntryCard(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Alex Johnson',
                style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 20, color: Color(0xFF111827)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: const Color(0xFFFFE4E4), borderRadius: BorderRadius.circular(20)),
                child: Text(
                  '0% CRITICAL',
                  style: GoogleFonts.inter(color: Color(0xFFE02424), fontSize: 11, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text('ID: STU-2026-0882', style: GoogleFonts.inter(color: Color(0xFF6B7280), fontSize: 13)),
          const SizedBox(height: 14),
          Row(
            children: [
              _infoCol('DOMAIN', 'Software Engineering'),
              const SizedBox(width: 28),
              _infoCol('ACADEMIC YEAR', 'Junior Year • Sem 2'),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CURRENT ATTENDANCE',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
              Text(
                '0%',
                style: GoogleFonts.inter(color: Color(0xFFE02424), fontWeight: FontWeight.w700, fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 6),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: 0.005,
              minHeight: 7,
              backgroundColor: const Color(0xFFE5E7EB),
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFE02424)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCol(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            color: Color(0xFF9CA3AF),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.7,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF111827)),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(child: _statCard('MONTHLY AVG', '68%', const Color(0xFF1A56DB))),
        const SizedBox(width: 12),
        Expanded(child: _statCard('WORKING DAYS', '22 Days', const Color(0xFFF0A500))),
      ],
    );
  }

  Widget _statCard(String label, String value, Color accent) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border(left: BorderSide(color: accent, width: 4)),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 10,
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w800, color: Color(0xFF111827)),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.upload_rounded, color: Colors.white, size: 18),
            label: Text(
              'Upload',
              style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1A56DB),
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.download_rounded, color: Color(0xFF1A56DB), size: 18),
            label: Text(
              'Report',
              style: GoogleFonts.inter(color: Color(0xFF1A56DB), fontWeight: FontWeight.w600, fontSize: 15),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              side: const BorderSide(color: Color(0xFF1A56DB), width: 1.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarCard() {
    return _card(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.calendar_month_outlined, color: Color(0xFF1A56DB), size: 20),
                  SizedBox(width: 8),
                  Text(
                    'April 2026',
                    style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xFF111827)),
                  ),
                ],
              ),
              Row(
                children: [_chevronBtn(Icons.chevron_left), const SizedBox(width: 2), _chevronBtn(Icons.chevron_right)],
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Day labels
          Row(
            children: _weekDays
                .map(
                  (d) => Expanded(
                    child: Center(
                      child: Text(
                        d,
                        style: GoogleFonts.inter(fontSize: 11, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 6),
          ..._calRows.map(
            (row) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: row.map((day) {
                  final status = _dayStatus[day] ?? 'future';
                  final isPrev = status == 'prev';
                  final isFuture = status == 'future';
                  final isSelected = day == _selectedDay && !isPrev;
                  final dotColor = _dotColor(status);
                  return Expanded(
                    child: GestureDetector(
                      onTap: (!isPrev && !isFuture) ? () => setState(() => _selectedDay = day) : null,
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        height: 36,
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF1A56DB) : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: (!isSelected && !isPrev && !isFuture && status != 'holiday')
                              ? Border.all(color: dotColor.withValues(alpha: 0.25), width: 1.2)
                              : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$day',
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : (isPrev || isFuture)
                                    ? const Color(0xFFD1D5DB)
                                    : status == 'holiday'
                                    ? const Color(0xFFD1D5DB)
                                    : dotColor,
                              ),
                            ),
                            if (!isSelected && !isPrev && !isFuture && status != 'holiday')
                              Container(
                                margin: const EdgeInsets.only(top: 2),
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _legendItem(const Color(0xFF1A56DB), 'PRESENT'),
              _legendItem(const Color(0xFFE02424), 'ABSENT'),
              _legendItem(const Color(0xFFF0A500), 'LEAVE'),
              _legendItem(const Color(0xFFD1D5DB), 'HOLIDAY'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _chevronBtn(IconData icon) {
    return GestureDetector(
      onTap: () {},
      child: Icon(icon, color: const Color(0xFF6B7280), size: 22),
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2)),
        ),
        const SizedBox(width: 4),
        Text(label, style: GoogleFonts.inter(fontSize: 10, color: Color(0xFF6B7280))),
      ],
    );
  }

  Widget _buildUpdateEntryCard() {
    return _card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Update Entry: April $_selectedDay',
            style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 14),
          Text(
            'STATUS',
            style: GoogleFonts.inter(
              fontSize: 11,
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _statusBtn('PRESENT', Icons.check_circle_outline),
              const SizedBox(width: 8),
              _statusBtn('ABSENT', Icons.cancel_outlined),
              const SizedBox(width: 8),
              _statusBtn('LEAVE', Icons.event_note_outlined),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            'REMARKS',
            style: GoogleFonts.inter(
              fontSize: 11,
              color: Color(0xFF9CA3AF),
              fontWeight: FontWeight.w700,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _remarksController,
            maxLines: 3,
            style: GoogleFonts.inter(fontSize: 13),
            decoration: InputDecoration(
              hintText: 'e.g. Attended guest lecture on Cloud Computing...',
              hintStyle: GoogleFonts.inter(color: Color(0xFFD1D5DB), fontSize: 13),
              filled: true,
              fillColor: const Color(0xFFF9FAFB),
              contentPadding: const EdgeInsets.all(12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF1A56DB)),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A56DB),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Text(
                'Save Changes',
                style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusBtn(String label, IconData icon) {
    final isActive = _selectedStatus == label;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedStatus = label),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: isActive ? const Color(0xFF1A56DB) : const Color(0xFFE5E7EB),
              width: isActive ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(10),
            color: isActive ? const Color(0xFFF0F4FF) : Colors.white,
          ),
          child: Column(
            children: [
              Icon(icon, size: 20, color: isActive ? const Color(0xFF1A56DB) : const Color(0xFF9CA3AF)),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isActive ? const Color(0xFF1A56DB) : const Color(0xFF9CA3AF),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, 2))],
      ),
      padding: const EdgeInsets.all(16),
      child: child,
    );
  }
}
