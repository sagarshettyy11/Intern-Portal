import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/models/company/attendance_model.dart';
import 'package:intern_portal/services/users/company_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intl/intl.dart';

class AttendanceManagementScreen extends StatefulWidget {
  final AttendanceStudent student;
  const AttendanceManagementScreen({super.key, required this.student});
  @override
  State<AttendanceManagementScreen> createState() => _AttendanceManagementScreenState();
}

class _AttendanceManagementScreenState extends State<AttendanceManagementScreen> {
  int _selectedDay = 9;
  String _selectedStatus = 'PRESENT';
  DateTime _currentMonth = DateTime.now();
  final TextEditingController _remarksController = TextEditingController();
  static const _weekDays = ['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'];
  List<List<DateTime?>> _generateCalendar(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);
    int startWeekday = firstDay.weekday; // 1 = Monday
    int totalDays = lastDay.day;
    List<List<DateTime?>> weeks = [];
    List<DateTime?> week = [];
    for (int i = 1; i < startWeekday; i++) {
      week.add(null);
    }
    for (int day = 1; day <= totalDays; day++) {
      week.add(DateTime(month.year, month.month, day));
      if (week.length == 7) {
        weeks.add(week);
        week = [];
      }
    }
    if (week.isNotEmpty) {
      while (week.length < 7) {
        week.add(null);
      }
      weeks.add(week);
    }
    return weeks;
  }

  AttendanceInfo? info;
  List<AttendanceLog> logs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final res = await CompanyService.fetchStudentAttendance(widget.student.internshipId);
    setState(() {
      info = res?.info;
      logs = res?.logs ?? [];
      isLoading = false;
    });
  }

  /* Color _dotColor(String key) {
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
  } */

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
                info?.name ?? '',
                style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 20, color: Color(0xFF111827)),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: getStatusBg(info?.status ?? ''),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${info?.attendance ?? 0}% ${info?.status ?? ''}',
                  style: GoogleFonts.inter(color: Color(0xFFE02424), fontSize: 11, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          Text(
            'ID: ${info?.regNo ?? ''}',
            style: GoogleFonts.inter(color: Color(0xFF6B7280), fontSize: 13, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          Column(
            children: [
              Row(
                children: [
                  _infoCol('DOMAIN', info?.domain ?? ''),
                  const SizedBox(width: 28),
                  _infoCol('ROLE', info?.jobTitle ?? ''),
                ],
              ),
              Row(children: [_infoCol('DEPARTMENT', info?.department ?? '')]),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'CURRENT ATTENDANCE',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                ),
              ),
              Text(
                '${info?.attendance ?? 0}%',
                style: GoogleFonts.inter(color: Color(0xFFE02424), fontWeight: FontWeight.w800, fontSize: 14),
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

  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'critical':
        return const Color(0xFFE02424);
      case 'warning':
        return const Color(0xFFF0A500);
      case 'at risk':
        return const Color(0xFFF59E0B);
      default:
        return const Color(0xFF1A56DB);
    }
  }

  Color getStatusBg(String status) {
    switch (status.toLowerCase()) {
      case 'critical':
        return const Color(0xFFFFE4E4);
      case 'warning':
        return const Color(0xFFFEF3C7);
      case 'at risk':
        return const Color(0xFFFEF3C7);
      default:
        return const Color(0xFFE6F0FF);
    }
  }

  Widget _infoCol(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 10, color: Color(0xFF9CA3AF), fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w800, color: Color(0xFF111827)),
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
              fontWeight: FontWeight.w800,
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
              style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15),
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
              style: GoogleFonts.inter(color: Color(0xFF1A56DB), fontWeight: FontWeight.w800, fontSize: 15),
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
    final weeks = _generateCalendar(_currentMonth);
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
                    DateFormat.yMMMM().format(_currentMonth),
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

          ...weeks.map(
            (row) => Row(
              children: row.map((date) {
                if (date == null) {
                  return Expanded(child: SizedBox(height: 36));
                }

                final isSelected =
                    date.day == _selectedDay && date.month == _currentMonth.month && date.year == _currentMonth.year;

                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _selectedDay = date.day);
                    },
                    child: Container(
                      margin: const EdgeInsets.all(2),
                      height: 36,
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xFF1A56DB) : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text('${date.day}', style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
                      ),
                    ),
                  ),
                );
              }).toList(),
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
      onTap: () {
        setState(() {
          if (icon == Icons.chevron_left) {
            _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
          } else {
            _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
          }
        });
      },
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
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 10, color: Color(0xFF6B7280), fontWeight: FontWeight.w800),
        ),
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
            style: GoogleFonts.inter(fontWeight: FontWeight.w800, fontSize: 16, color: Color(0xFF111827)),
          ),
          const SizedBox(height: 14),
          Text(
            'STATUS',
            style: GoogleFonts.inter(
              fontSize: 11,
              color: Colors.grey[900],
              fontWeight: FontWeight.w800,
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
              fontWeight: FontWeight.w800,
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
              hintStyle: GoogleFonts.inter(color: Colors.grey[600], fontSize: 13, fontWeight: FontWeight.w800),
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
              onPressed: () async {
                final date = DateFormat(
                  'yyyy-MM-dd',
                ).format(DateTime(_currentMonth.year, _currentMonth.month, _selectedDay));
                final success = await CompanyService.markAttendance(
                  internshipId: widget.student.internshipId,
                  date: date,
                  status: _selectedStatus,
                  remarks: _remarksController.text,
                );
                if (success) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Attendance saved")));
                  loadData();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A56DB),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
              child: Text(
                'Save Changes',
                style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 15),
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
                  fontWeight: FontWeight.w900,
                  color: isActive ? const Color(0xFF1A56DB) : Colors.grey[800],
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
