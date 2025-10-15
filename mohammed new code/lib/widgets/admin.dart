import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

/* -------------------------------------------------------------------------- */
/*                             🎨 COLOR PALETTE                              */
/* -------------------------------------------------------------------------- */
class AppColors {
  // Background gradient
  static const darkNavy = Color(0xFF0B1222);
  static const yankeesBlue = Color(0xFF1C2841);

  // Accent gradients (buttons, highlights)
  static const cornflowerBlue = Color(0xFF6495ED);
  static const royalPurple = Color(0xFF7851A9);

  // Text colors
  static const white = Colors.white;
  static const fadedWhite = Color.fromRGBO(255, 255, 255, 0.7);

  // Navigation inactive
  static const navInactive = Color(0xFF8B8FA1);
}

/* -------------------------------------------------------------------------- */
/*                             🌌 APP ROOT WIDGET                             */
/* -------------------------------------------------------------------------- */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard – New Palette',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: const ColorScheme.dark(
          surface: AppColors.darkNavy,
          primary: AppColors.cornflowerBlue,
          secondary: AppColors.royalPurple,
          onSurface: Colors.white,
          onPrimary: Colors.white,
          onSecondary: Colors.white,
        ),
        scaffoldBackgroundColor: AppColors.darkNavy,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.darkNavy,
          foregroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: AppColors.fadedWhite),
          bodyLarge: TextStyle(color: AppColors.white),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                        🏠 HOME PAGE (DASHBOARD UI)                         */
/* -------------------------------------------------------------------------- */
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

      // Gradient background wrapper
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.darkNavy, AppColors.yankeesBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Admin Dashboard',
                  style: TextStyle(
                    color: AppColors.cornflowerBlue,
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.2,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Manage users and application content',
                  style: TextStyle(
                    color: AppColors.fadedWhite,
                    fontSize: 13,
                    height: 1.3,
                  ),
                ),
                const SizedBox(height: 20),

                /* ---------------------------- Dashboard Cards ---------------------------- */
                _AdminCard(
                  icon: Icons.group_rounded,
                  title: 'User Management',
                  onTap: () {},
                ),
                const SizedBox(height: 14),
                _AdminCard(
                  icon: Icons.build_rounded,
                  title: 'Tool Management',
                  onTap: () {},
                ),
                const SizedBox(height: 14),
                _AdminCard(
                  icon: Icons.bar_chart_rounded,
                  title: 'App Analytics',
                  onTap: () {},
                ),
                const SizedBox(height: 16),

                _AdminGuideBlock(onTap: () {}),
                const SizedBox(height: 32),

                /* --------------------------- Floating Counter --------------------------- */
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'You have pushed the button this many times:',
                        style: TextStyle(fontSize: 12.5, color: AppColors.fadedWhite),
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
      ),

      /* -------------------------- Floating Action Button -------------------------- */
      floatingActionButton: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.cornflowerBlue, AppColors.royalPurple],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          onPressed: () => setState(() => _counter++),
          elevation: 0,
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      /* ------------------------------ Bottom NavBar ------------------------------ */
      bottomNavigationBar: BottomAppBar(
        color: AppColors.yankeesBlue,
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
                label: 'Tools',
                active: _navIndex == 1,
                onTap: () => setState(() => _navIndex = 1),
              ),
              const Spacer(),
              _BottomItem(
                icon: Icons.receipt_long_rounded,
                label: 'Reports',
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

  /* ------------------------------ AppBar Section ------------------------------ */
  AppBar _buildBrandAppBar() {
    return AppBar(
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.cornflowerBlue, AppColors.royalPurple],
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

/* -------------------------------------------------------------------------- */
/*                              💠 DASHBOARD CARD                             */
/* -------------------------------------------------------------------------- */
class _AdminCard extends StatelessWidget {
  const _AdminCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
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
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.yankeesBlue, AppColors.darkNavy],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.cornflowerBlue, AppColors.royalPurple],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.dashboard, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
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

/* -------------------------------------------------------------------------- */
/*                              📘 ADMIN GUIDE BLOCK                           */
/* -------------------------------------------------------------------------- */
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
            colors: [AppColors.yankeesBlue, AppColors.darkNavy],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
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
              CircleAvatar(
                radius: 14,
                backgroundColor: AppColors.royalPurple,
                child: Icon(Icons.info, size: 16, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                           🔘 BOTTOM NAV ITEM WIDGET                         */
/* -------------------------------------------------------------------------- */
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
    active ? AppColors.cornflowerBlue : AppColors.navInactive;

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
