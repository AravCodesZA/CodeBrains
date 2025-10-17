import 'package:flutter/material.dart';
import '../pages/chat_screen.dart'; // ✅ make sure this path is correct

class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: const Color(0xFF111526),
      shape: const CircularNotchedRectangle(),
      notchMargin: 8.0,
      child: SizedBox(
        height: 65,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home, "Home", 0, context),
            _navItem(Icons.build, "Tools", 1, context),

            // placeholder space for the FAB in the middle
            const SizedBox(width: 50),

            _navItem(Icons.school, "Learning", 2, context),
            _navItem(Icons.person, "Profile", 3, context),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index, BuildContext context) {
    final isActive = currentIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,
              color: isActive ? Colors.white : Colors.white54, size: 24),
          const SizedBox(height: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 12,
                  color: isActive ? Colors.white : Colors.white54)),
        ],
      ),
    );
  }
}
