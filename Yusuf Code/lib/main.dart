import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'pages/home_page.dart';
import 'pages/tools_page.dart';
import 'pages/chat_screen.dart';
import 'pages/learning_page.dart';
import 'pages/profile_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🌍 Load environment variables safely
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("⚠️ Could not load .env file: $e");
  }

  runApp(const CodeBrainsApp());
}

class CodeBrainsApp extends StatelessWidget {
  const CodeBrainsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CodeBrains AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0E1020),
        primaryColor: const Color(0xFF6EA8FE),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF0E1020),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF0E1020),
          elevation: 0,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

// -----------------------------------------------------------------------------
// 🧭 Main Screen with Bottom Navigation + Smart Back Navigation Memory
// -----------------------------------------------------------------------------
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  int _previousIndex = 0; // 🧠 remembers last tab before current
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomePage(),
      ToolsPage(
        onGoToChat: () {
          setState(() {
            _previousIndex = _currentIndex;
            _currentIndex = 2; // 🔁 go to Chat tab
          });
        },
      ),
      ChatScreen(
        onBackToTools: () {
          setState(() {
            _previousIndex = _currentIndex;
            _currentIndex = 1; // 🔁 go back to Tools tab
          });
        },
      ),
      const LearningPage(),
      const ProfilePage(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      _previousIndex = _currentIndex;
      _currentIndex = index;
    });
  }

  Future<bool> _onWillPop() async {
    // 🔙 If user presses phone’s back button, go to previous tab instead of closing app
    if (_currentIndex != _previousIndex) {
      setState(() {
        final temp = _currentIndex;
        _currentIndex = _previousIndex;
        _previousIndex = temp;
      });
      return false; // Don’t exit the app
    }
    return true; // Exit app if already on the same tab
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: const Color(0xFF0E1020),
        body: _pages[_currentIndex],

        // 🟣 Center Floating Button (opens Chat)
        floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
            ? FloatingActionButton(
          backgroundColor: Colors.white,
          elevation: 6,
          shape: const CircleBorder(),
          onPressed: () {
            setState(() {
              _previousIndex = _currentIndex;
              _currentIndex = 2; // Chat tab
            });
          },
          child:
          const Icon(Icons.add, color: Color(0xFF0E1020), size: 26),
        )
            : null,
        floatingActionButtonLocation:
        FloatingActionButtonLocation.centerDocked,

        // 🟦 Custom Bottom Navigation Bar
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xFF1A1D2E),
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // LEFT SIDE (Home + Tools)
                Row(
                  children: [
                    _navItem(Icons.home, "Home", 0),
                    _navItem(Icons.build, "Tools", 1),
                  ],
                ),
                // RIGHT SIDE (Learning + Profile)
                Row(
                  children: [
                    _navItem(Icons.school, "Learning", 3),
                    _navItem(Icons.person, "Profile", 4),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final isActive = _currentIndex == index;
    return MaterialButton(
      minWidth: 70,
      onPressed: () => _onTabTapped(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: isActive ? const Color(0xFF6EA8FE) : Colors.white54,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.white54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
