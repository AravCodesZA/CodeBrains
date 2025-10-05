import 'package:fl_test/colors.dart';
import 'package:flutter/material.dart';

void main() => runApp(CodeBrainsApp());

class CodeBrainsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.mainBackground,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,


              children: [
                // HEADER
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.Royal_Purple,
                      child: Text("AI", style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(width: 8),
                    Text("CODEBRAINS",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 24),

                // WELCOME TITLE
                Text("Welcome",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 28,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                  "Supercharge your development with AI-learning tools designed for modern software engineers to adapt and utilize AI efficiently.",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                SizedBox(height: 24),

                // FEATURE CARDS
                FeatureCard(
                  icon: Icons.code,
                  title: "AI Code Assistant",
                  description:
                  "AI will help teach, review, and optimize your code with advanced AI that understands context and best practices.",
                  color: Colors.purple,
                ),

                FeatureCard(
                  icon: Icons.lightbulb,
                  title: "Smart Refactoring",
                  description:
                  "Automatically identify code patterns, suggest improvements, and enhance code maintainability.",
                  color: Colors.orange,
                ),

                FeatureCard(
                  icon: Icons.bug_report,
                  title: "Intelligent Debugging",
                  description:
                  "Find bugs faster in your code with AI-powered analysis that provides real-time insights and solutions.",
                  color: Colors.green,
                ),

                SizedBox(height: 24),

                // WHAT'S INSIDE
                Text("What's Inside",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("• Real-time code suggestions and completions",
                    style: TextStyle(color: Colors.white70)),
                Text("• Intelligent bug detection and security analysis",
                    style: TextStyle(color: Colors.white70)),
                Text(
                    "• Multi-language support with contextual understanding",
                    style: TextStyle(color: Colors.white70)),

                SizedBox(height: 40),

                // Get Started Button
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: [AppColors.Cornflower_Blue, AppColors.Royal_Purple ],
                    ),
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Text("Get Started",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),



    // BOTTOM NAVIGATION
      //TODO - MAKE NAV BAR DYNAMIC
    bottomNavigationBar: BottomNavigationBar(
    backgroundColor: Colors.black,
    selectedItemColor: Colors.blueAccent,
    unselectedItemColor: Colors.white54,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
      BottomNavigationBarItem(icon: Icon(Icons.build), label: "Tools"),
      BottomNavigationBarItem(icon: Icon(Icons.school), label: "Learning"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
    ]
    ,
    )
    ,
    );
  }
}

//class that creates feature cards
class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  const FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.dark_navy,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 4),
                  Text(description,
                      style: TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
