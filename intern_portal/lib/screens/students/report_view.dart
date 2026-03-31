import 'package:flutter/material.dart';
import 'package:intern_portal/widgets/appbar_navigation.dart';

class ReportDetailsScreen extends StatelessWidget {
  const ReportDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: CommonAppBar(title: "Report Details", showBack: true),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        children: const [
          _CompanyCard(),
          SizedBox(height: 20),
          _WeeklyReportHeader(),
          SizedBox(height: 12),
          _ActivityDescriptionCard(),
          SizedBox(height: 12),
          _LearningOutcomesCard(),
          SizedBox(height: 12),
          _ChallengesCard(),
          SizedBox(height: 12),
          _AttachmentCard(),
          SizedBox(height: 12),
          _FacultyFeedbackCard(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _CompanyCard extends StatelessWidget {
  const _CompanyCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 56,
                  height: 56,
                  color: const Color(0xFF90CAF9),
                  child: const Icon(Icons.business, color: Colors.white, size: 32),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TechCorp\nSolutions',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 18,
                        height: 1.25,
                        color: Color(0xFF111928),
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Full Stack\nDevelopment',
                      style: TextStyle(fontSize: 13, color: Color(0xFF1A56DB), fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: const Color(0xFFDEF7EC),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFF84E1BC), width: 1),
                ),
                child: const Text(
                  'APPROVED',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF057A55),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0xFFE5E7EB)),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'JOB TITLE',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade500,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Software Engineer\nIntern',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF111928)),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'DATE UPDATED',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade500,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '28 Mar 2026',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF111928)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeeklyReportHeader extends StatelessWidget {
  const _WeeklyReportHeader();
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Weekly Report #12',
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20, color: Color(0xFF111928)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(color: const Color(0xFFE05D1A), borderRadius: BorderRadius.circular(999)),
          child: RichText(
            text: const TextSpan(
              children: [
                TextSpan(
                  text: 'GRADE ',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white, letterSpacing: 0.5),
                ),
                TextSpan(
                  text: '85/100',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w800, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ActivityDescriptionCard extends StatelessWidget {
  const _ActivityDescriptionCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: const Color(0xFFEBF5FF), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.description_outlined, color: Color(0xFF1A56DB), size: 18),
              ),
              const SizedBox(width: 10),
              const Text(
                'Activity Description',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Color(0xFF1A56DB)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'This week focused on the final integration of the authentication module. I attended daily stand-up meetings to synchronize with the backend team. Significant effort was spent on discussing progress regarding the OAuth2.0 flow and executing comprehensive module testing to ensure security compliance.',
            style: TextStyle(fontSize: 14, color: Color(0xFF374151), height: 1.6),
          ),
        ],
      ),
    );
  }
}

class _LearningOutcomesCard extends StatelessWidget {
  const _LearningOutcomesCard();
  static const items = [
    'Advanced understanding of RESTful API architecture and JWT tokens.',
    'Improved cross-functional communication within agile teams.',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: const Color(0xFFF0F4FF), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.auto_awesome, color: Color(0xFF4B5AF0), size: 18),
              ),
              const SizedBox(width: 10),
              const Text(
                'Learning Outcomes',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Color(0xFF111928)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: CircleAvatar(radius: 3.5, backgroundColor: Color(0xFF374151)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(item, style: const TextStyle(fontSize: 14, color: Color(0xFF374151), height: 1.5)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChallengesCard extends StatelessWidget {
  const _ChallengesCard();
  static const items = [
    'Complex API integration hurdles with third-party legacy systems.',
    'Balancing tight documentation deadlines with development tasks.',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: const Color(0xFFFFF3E0), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.warning_amber_rounded, color: Color(0xFFD97706), size: 18),
              ),
              const SizedBox(width: 10),
              const Text(
                'Challenges',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Color(0xFF111928)),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: CircleAvatar(radius: 3.5, backgroundColor: Color(0xFF374151)),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(item, style: const TextStyle(fontSize: 14, color: Color(0xFF374151), height: 1.5)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AttachmentCard extends StatelessWidget {
  const _AttachmentCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(color: const Color(0xFFEBF5FF), borderRadius: BorderRadius.circular(10)),
            child: const Icon(Icons.picture_as_pdf_outlined, color: Color(0xFF1A56DB), size: 22),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Weekly_Log_V12.pdf',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14, color: Color(0xFF111928)),
                ),
                SizedBox(height: 3),
                Text('2.4 MB • Uploaded 2 days ago', style: TextStyle(fontSize: 12, color: Color(0xFF9CA3AF))),
              ],
            ),
          ),
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.download_outlined, color: Color(0xFF374151), size: 20),
          ),
        ],
      ),
    );
  }
}

class _FacultyFeedbackCard extends StatelessWidget {
  const _FacultyFeedbackCard();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(color: const Color(0xFFEBF5FF), borderRadius: BorderRadius.circular(8)),
                child: const Icon(Icons.chat_outlined, color: Color(0xFF1A56DB), size: 18),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Faculty Mentor Feedback',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15, color: Color(0xFF111928)),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Reviewed by Dr. Sarah Mitchell • 30 Mar 2026',
                    style: TextStyle(fontSize: 11, color: Color(0xFF9CA3AF)),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 4,
                  decoration: BoxDecoration(color: const Color(0xFF1A56DB), borderRadius: BorderRadius.circular(4)),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    '"Excellent progress on the authentication module. Your understanding of JWT architecture is clearly reflected in the implementation details. For the next week, ensure that the legacy system integration issues are documented as technical debt for future refactoring."',
                    style: TextStyle(fontSize: 14, color: Color(0xFF374151), fontStyle: FontStyle.italic, height: 1.65),
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
