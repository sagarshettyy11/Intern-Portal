import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intern_portal/controllers/navigation_controller.dart';
import 'package:intern_portal/models/admin/internship_model.dart';
import 'package:intern_portal/screens/college/admin/admin_profile.dart';
import 'package:intern_portal/screens/college/admin/new_internship_batch.dart';
import 'package:intern_portal/services/users/admin_services.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';
import 'package:intern_portal/widgets/bottom_navigation.dart';

class InternshipMasterScreen extends StatefulWidget {
  const InternshipMasterScreen({super.key});
  @override
  State<InternshipMasterScreen> createState() => _InternshipMasterScreenState();
}

class _InternshipMasterScreenState extends State<InternshipMasterScreen> {
  int selectedNavIndex = 4;
  final TextEditingController _searchController = TextEditingController();
  List<Internship> _batches = [];
  List<Internship> _filteredBatches = [];
  bool isLoading = true;
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loadInternships();
  }

  Future<void> loadInternships() async {
    setState(() => isLoading = true);
    final data = await AdminServices.fetchInternships();
    setState(() {
      _batches = data;
      _filteredBatches = data;
      isLoading = false;
    });
  }

  void _onSearch(String query) {
    setState(() {
      _filteredBatches = _batches
          .where(
            (b) =>
                b.name.toLowerCase().contains(query.toLowerCase()) ||
                b.mode.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    });
  }

  int get _totalCount => _batches.length;
  int get _activeCount => _batches.where((b) => b.status == InternshipStatus.active).length;
  int get _inactiveCount => _batches.where((b) => b.status == InternshipStatus.inactive).length;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: CommonAppBar(
        showLogo: true,
        actions: [
          InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const AdminProfileScreen()));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 12),
              child: CircleAvatar(radius: 16, child: Icon(Icons.person, size: 18, color: Colors.black)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),
                    const SizedBox(height: 16),
                    _buildStatsRow(),
                    const SizedBox(height: 10),
                    _buildSearchRow(),
                    const SizedBox(height: 10),
                    if (isLoading)
                      const Center(child: CircularProgressIndicator())
                    else if (_filteredBatches.isEmpty)
                      const Center(child: Text("No internships found"))
                    else
                      ..._filteredBatches.map((batch) => _buildBatchCard(batch)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AdminAppBottomNav(
        currentIndex: 4,
        onTap: (index) => AdminBottomNavController.onItemTapped(context, index),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Internship Master',
          style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
        ),
        Text(
          'Create and manage internship batches for your college.',
          style: GoogleFonts.inter(fontSize: 14, color: Colors.grey[800], fontWeight: FontWeight.w700),
        ),
      ],
    );
  }

  Widget _buildStatsRow() {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: 'TOTAL',
            value: _totalCount.toString().padLeft(2, '0'),
            valueColor: const Color(0xFF2563EB),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            label: 'ACTIVE',
            value: _activeCount.toString().padLeft(2, '0'),
            valueColor: const Color(0xFFB45309),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _StatCard(
            label: 'INACTIVE',
            value: _inactiveCount.toString().padLeft(2, '0'),
            valueColor: const Color(0xFF475569),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 4, offset: const Offset(0, 2)),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearch,
              decoration: InputDecoration(
                hintText: 'Search batches by name or mode...',
                hintStyle: GoogleFonts.inter(color: Colors.grey[800], fontSize: 14),
                prefixIcon: Icon(Icons.search, color: Colors.grey[800], size: 22),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () async {
            final result = await Navigator.push(context, MaterialPageRoute(builder: (_) => NewBatchDetailsScreen()));

            if (result == true) loadInternships();
          },
          child: Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: const Color(0xFF2563EB), borderRadius: BorderRadius.circular(14)),
            child: const Icon(Icons.add, color: Colors.white, size: 28),
          ),
        ),
      ],
    );
  }

  Widget _buildBatchCard(Internship batch) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        batch.name,
                        style: GoogleFonts.inter(fontSize: 17, fontWeight: FontWeight.w800, color: Color(0xFF0F172A)),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'ID: ${batch.id}',
                        style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[800], fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                ),
                _StatusBadge(status: batch.status),
              ],
            ),
            const SizedBox(height: 14),
            Row(
              children: [
                Expanded(
                  child: _InfoTile(
                    icon: Icons.calendar_today_outlined,
                    iconColor: const Color(0xFF0000FF),
                    label: batch.year,
                  ),
                ),
                Expanded(
                  child: _InfoTile(icon: Icons.access_time, iconColor: const Color(0xFF0000FF), label: batch.duration),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _InfoTile(
                    icon: _modeIcon(batch.mode),
                    iconColor: const Color(0xFF0000FF),
                    label: _modeLabel(batch.mode),
                  ),
                ),
                Expanded(
                  child: _InfoTile(
                    icon: Icons.calendar_month_outlined,
                    iconColor: const Color(0xFF0000FF),
                    label: 'Created: ${batch.createdDate?.toLocal().toString().split(' ')[0] ?? ''}',
                  ),
                ),
              ],
            ),
            const Divider(height: 1, color: Color(0xFFF1F5F9)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => NewBatchDetailsScreen(internship: batch)),
                      );

                      if (result == true) loadInternships();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.edit_outlined, size: 18, color: Colors.grey[800]),
                          SizedBox(width: 6),
                          Text(
                            'Edit',
                            style: GoogleFonts.inter(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () async {
                    final success = await AdminServices.deleteInternship(batch.id);
                    if (success) {
                      loadInternships();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Batch deactivated")));
                    } else {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text("Cannot deactivate (students linked)")));
                    }
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(color: const Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(10)),
                    child: const Icon(
                      Icons.delete_outline,
                      color: Color(0xFFDC2626),
                      size: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _modeIcon(InternshipMode mode) {
    switch (mode) {
      case InternshipMode.online:
        return Icons.laptop_outlined;
      case InternshipMode.offline:
        return Icons.location_on;
      case InternshipMode.hybrid:
        return Icons.people_outline;
    }
  }

  String _modeLabel(InternshipMode mode) {
    switch (mode) {
      case InternshipMode.online:
        return 'Online';
      case InternshipMode.offline:
        return 'On-site';
      case InternshipMode.hybrid:
        return 'Hybrid';
    }
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;
  const _StatCard({required this.label, required this.value, required this.valueColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 4, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              color: Colors.grey[800],
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: GoogleFonts.inter(fontSize: 28, fontWeight: FontWeight.w800, color: valueColor),
          ),
        ],
      ),
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final InternshipStatus status;
  const _StatusBadge({required this.status});
  @override
  Widget build(BuildContext context) {
    final isActive = status == InternshipStatus.active;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isActive ? const Color(0xFFFEF3C7) : const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isActive ? 'ACTIVE' : 'INACTIVE',
        style: GoogleFonts.inter(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          color: isActive ? const Color(0xFFB45309) : const Color(0xFF64748B),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  const _InfoTile({required this.icon, required this.iconColor, required this.label});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            label,
            style: GoogleFonts.inter(fontSize: 13, color: Colors.grey[800], fontWeight: FontWeight.w800),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
