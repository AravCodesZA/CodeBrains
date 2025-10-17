import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Example static user info — replace later with real data or API
    final user = {
      'name': 'John Developer',
      'email': 'john.dev@codebrains.ai',
      'skill': 'Intermediate',
      'created': 'June 2024',
    };

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
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text(
              'User Profile',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9BB8FF),
              ),
            ),
            const SizedBox(height: 20),

            // === Avatar ===
            Center(
              child: CircleAvatar(
                radius: 45,
                backgroundColor: const Color(0xFF6EA8FE).withOpacity(0.25),
                child: const Icon(Icons.person, color: Colors.white, size: 50),
              ),
            ),
            const SizedBox(height: 24),

            // === User Info Card ===
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1D2E),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow('User name', user['name']!),
                  _infoRow('User email', user['email']!),
                  _infoRow('User skill level', user['skill']!),
                  _infoRow('Account Creation date', user['created']!),
                ],
              ),
            ),

            const SizedBox(height: 30),
            const Text(
              'User Actions',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            // === Action Buttons ===
            _ActionButton(
              label: 'Edit Profile',
              icon: Icons.edit,
              colors: const [Color(0xFF6EA8FE), Color(0xFFB48CF5)],
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Edit Profile clicked'),
                    duration: Duration(milliseconds: 800),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _ActionButton(
              label: 'Change Password',
              icon: Icons.lock,
              colors: const [Color(0xFF6EA8FE), Color(0xFFFF7058)],
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Change Password clicked'),
                    duration: Duration(milliseconds: 800),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),
            _ActionButton(
              label: 'Logout',
              icon: Icons.logout,
              colors: const [Color(0xFFFF7058), Color(0xFFB48CF5)],
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Logged out successfully'),
                    duration: Duration(milliseconds: 900),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// === Helper Widget for Info Rows ===
Widget _infoRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 13)),
        Text(value, style: const TextStyle(fontSize: 13)),
      ],
    ),
  );
}

// === Gradient Button Widget ===
class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final List<Color> colors;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.colors,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          height: 50,
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 20),
              const SizedBox(width: 8),
              Text(
                label,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
