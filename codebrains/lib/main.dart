import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1a1d2e),
      ),
      home: const UserProfileScreen(),
    );
  }
}

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF6366f1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'AI',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'CODEBRAINS',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                
                // Title
                const Center(
                  child: Text(
                    'User Profile',
                    style: TextStyle(
                      color: Color(0xFF8b5cf6),
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Manage your account information',
                    style: TextStyle(
                      color: Color(0xFF6b7280),
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                
                // Profile Card
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF232640),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF2d3354),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      // Avatar
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: const Color(0xFF4c5a8f),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.white.withOpacity(0.9),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      
                      // User Info
                      _buildInfoRow('Users name'),
                      const SizedBox(height: 16),
                      _buildInfoRow('Users email'),
                      const SizedBox(height: 16),
                      _buildInfoRow('User skill level'),
                      const SizedBox(height: 16),
                      _buildInfoRow('Account Creation date'),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                
                // User Actions Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF232640),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF2d3354),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Center(
                        child: Text(
                          'User Actions',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Edit Profile Button
                      _buildActionButton(
                        icon: Icons.edit_outlined,
                        label: 'Edit Profile',
                        iconColor: const Color(0xFF3b82f6),
                      ),
                      const SizedBox(height: 12),
                      
                      // Change Password Button
                      _buildActionButton(
                        icon: Icons.lock_outline,
                        label: 'Change Password',
                        iconColor: const Color(0xFF10b981),
                      ),
                      const SizedBox(height: 12),
                      
                      // Logout Button
                      _buildActionButton(
                        icon: Icons.logout,
                        label: 'Logout',
                        iconColor: const Color(0xFF06b6d4),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildInfoRow(String label) {
    return Center(
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color iconColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF2d3354),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 22,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF7c3aed), Color(0xFF6366f1)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF232640),
        border: Border(
          top: BorderSide(
            color: const Color(0xFF2d3354),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home_outlined, 'Home', false),
              _buildNavItem(Icons.build_outlined, 'Tools', false),
              _buildNavItem(Icons.add_box_outlined, '', false, isCenter: true),
              _buildNavItem(Icons.school_outlined, 'Learning', false),
              _buildNavItem(Icons.person_outline, 'Profile', true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isActive, {bool isCenter = false}) {
    if (isCenter) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF1a1d2e),
          size: 24,
        ),
      );
    }
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: isActive ? const Color(0xFF8b5cf6) : const Color(0xFF6b7280),
          size: 24,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? const Color(0xFF8b5cf6) : const Color(0xFF6b7280),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}