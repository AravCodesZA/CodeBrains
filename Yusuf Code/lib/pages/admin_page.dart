import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> adminTools = [
      {
        'title': 'User Management',
        'subtitle': 'Manage registered users, access levels and roles.',
        'icon': Icons.people_alt,
        'color': const Color(0xFF6EA8FE),
      },
      {
        'title': 'Tool Management',
        'subtitle': 'Add, edit or deactivate AI tools available to users.',
        'icon': Icons.build_circle,
        'color': const Color(0xFFB48CF5),
      },
      {
        'title': 'App Analytics',
        'subtitle': 'Monitor user activity and performance statistics.',
        'icon': Icons.analytics,
        'color': const Color(0xFFFF7058),
      },
      {
        'title': 'Admin Guide',
        'subtitle': 'View documentation, API setup and usage tutorials.',
        'icon': Icons.menu_book,
        'color': const Color(0xFF9BB8FF),
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0E1020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E1020),
        elevation: 0,
        title: Row(
          children: const [
            CircleAvatar(
              backgroundColor: Color(0xFF6EA8FE),
              child: Text('AI', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            SizedBox(width: 8),
            Text('CODEBRAINS', style: TextStyle(letterSpacing: 1.2)),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text('100%', style: TextStyle(fontSize: 12)),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'Admin Dashboard',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9BB8FF),
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Manage the CodeBrains ecosystem efficiently and monitor key metrics.',
              style: TextStyle(fontSize: 14, color: Colors.white70),
            ),
            const SizedBox(height: 30),

            Wrap(
              spacing: 16,
              runSpacing: 16,
              children: adminTools
                  .map((tool) => _AdminCard(
                        icon: tool['icon'],
                        title: tool['title'],
                        subtitle: tool['subtitle'],
                        color: tool['color'],
                      ))
                  .toList(),
            ),
            const SizedBox(height: 40),

            const Text(
              'System Overview',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 14),

            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1D2E),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  _Metric(label: 'Active Users', value: '1,042'),
                  _Metric(label: 'Tools Used', value: '6'),
                  _Metric(label: 'Avg. Session Time', value: '12m 47s'),
                  _Metric(label: 'AI Requests Today', value: '4,321'),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _AdminCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;

  const _AdminCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 16 * 3) / 2,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.25),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 6),
          Text(subtitle,
              style: const TextStyle(color: Colors.white60, fontSize: 12)),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('$title tapped'),
                  duration: const Duration(milliseconds: 700),
                ),
              );
            },
            child: const Text('Open',
                style: TextStyle(color: Color(0xFF6EA8FE), fontSize: 13)),
          ),
        ],
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;

  const _Metric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(color: Colors.white70, fontSize: 13)),
          Text(value,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}
