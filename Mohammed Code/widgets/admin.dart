import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

/// ---------- Palette ----------
class AppColors {
  static const navyBg = Color(0xFF0B1222);     // page background (surface)
  static const cardTop = Color(0xFF141B30);    // gradient top for cards
  static const cardBottom = Color(0xFF1B2442); // gradient bottom for cards
  static const violet = Color(0xFF8B7DEB);     // "Admin Dashboard" title
  static const lightBlue = Color(0xFF58B4FF);  // active highlight / FAB
  static const subtext = Color(0xFFB0B3C4);    // description text
  static const navInactive = Color(0xFF9A9AAF);
  static const logoPurple = Color(0xFF7C5CFC);
  static const logoBlue = Color(0xFF6E8CFF);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin UI Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          surface: AppColors.navyBg,      // Scaffold background
          primary: AppColors.violet,      // accents / headings
          secondary: AppColors.lightBlue, // FAB / highlight
          onSurface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
        ),
        scaffoldBackgroundColor: AppColors.navyBg,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.navyBg,
          foregroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: AppColors.navyBg,
          selectedItemColor: AppColors.lightBlue,
          unselectedItemColor: AppColors.navInactive,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppColors.subtext),
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _navIndex = 0;
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildBrandAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Admin Dashboard',
                style: TextStyle(
                  color: AppColors.violet,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Manage users and application content',
                style: TextStyle(
                  color: AppColors.subtext,
                  fontSize: 12.5,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 20),

              // --- Feature cards ---
              _AdminCard(
                icon: Icons.group_rounded,
                iconBg: Colors.white.withOpacity(0.08),
                title: 'User Management',
                onTap: () {},
              ),
              const SizedBox(height: 14),
              _AdminCard(
                icon: Icons.build_rounded, // tool/cog
                iconBg: Colors.white.withOpacity(0.08),
                title: 'Tool Management',
                onTap: () {},
              ),
              const SizedBox(height: 14),
              _AdminCard(
                icon: Icons.bar_chart_rounded,
                iconBg: Colors.white.withOpacity(0.08),
                title: 'App Analytics',
                onTap: () {},
              ),
              const SizedBox(height: 16),

              // --- Admin Guide block ---
              _AdminGuideBlock(onTap: () {}),

              const SizedBox(height: 32),

              Center(
                child: Column(
                  children: [
                    const Text(
                      'You have pushed the button this many times:',
                      style: TextStyle(fontSize: 12.5),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$_counter',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // --- Center circular button like the mock ---
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        foregroundColor: Colors.white,
        onPressed: () => setState(() => _counter++),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // --- Bottom bar w/ four slots and FAB notch ---
      bottomNavigationBar: BottomAppBar(
        color: AppColors.cardTop, // CHANGED: slightly lighter than page bg
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            children: [
              _BottomItem(
                icon: Icons.home_rounded,
                label: 'Home',
                active: _navIndex == 0,
                onTap: () => setState(() => _navIndex = 0),
              ),
              _BottomItem(
                icon: Icons.apps_rounded,
                label: 'Tool',
                active: _navIndex == 1,
                onTap: () => setState(() => _navIndex = 1),
              ),
              const Spacer(), // space for center FAB
              _BottomItem(
                icon: Icons.receipt_long_rounded,
                label: 'Learning',
                active: _navIndex == 2,
                onTap: () => setState(() => _navIndex = 2),
              ),
              _BottomItem(
                icon: Icons.person_rounded,
                label: 'Profile',
                active: _navIndex == 3,
                onTap: () => setState(() => _navIndex = 3),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildBrandAppBar() {
    return AppBar(
      titleSpacing: 16,
      title: Row(
        children: [
          // Gradient "AI" badge
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.logoPurple, AppColors.logoBlue],
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              'AI',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'CODEBRAINS',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.0,
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------- Widgets ----------

class _AdminCard extends StatelessWidget {
  const _AdminCard({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final Color iconBg;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.cardTop, AppColors.cardBottom],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: iconBg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 56,
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            // Small pill label (to mimic the screenshot button style)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0x1FFFFFFF), // translucent pill
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text(
                'Open',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AdminGuideBlock extends StatelessWidget {
  const _AdminGuideBlock({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Ink(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.cardTop, AppColors.cardBottom],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: const [
              Expanded(
                child: Text(
                  'Admin Guide',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // black circle with info "i"
              CircleAvatar(
                radius: 14,
                backgroundColor: Colors.black,
                child: Icon(Icons.info, size: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomItem extends StatelessWidget {
  const _BottomItem({
    required this.icon,
    required this.label,
    required this.active,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color =
    active ? AppColors.lightBlue : AppColors.navInactive;

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: color),
              const SizedBox(height: 2),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 11,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
