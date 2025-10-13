import 'package:flutter/material.dart';
import 'Userprofile.dart';
import 'LearningScreen.dart';
import 'Login.dart';
import 'ToolsPage.dart';
import 'colors.dart';

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

//Dynamic nav bar
class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentIndex = 0;

  //DEFINE SCREEN FOR EACH NAV ITEM
  final List<Widget> screens = [
    WelcomeContent(), // first welcome page
    ToolsScreen(),
    LearningScreen(),
    UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index:currentIndex,
        children: screens,
      ),

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.dark_navy,
        selectedItemColor: AppColors.Royal_Purple,
        unselectedItemColor: Colors.white,
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        //overrides scaffold background color
        type: BottomNavigationBarType.fixed,
        items: const[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.build), label: "Tools"),
          BottomNavigationBarItem(icon: Icon(Icons.school), label: "Learning"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}


//First page users see
class WelcomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
              SizedBox(height: 24),
              Text("• Real-time code suggestions and completions",
                  style: TextStyle(color: Colors.white60)),
              Text("• Intelligent bug detection and security analysis",
                  style: TextStyle(color: Colors.white60)),
              Text(
                  "• Multi-language support with contextual understanding",
                  style: TextStyle(color: Colors.white60)),

              SizedBox(height: 20),

              // Get Started Button
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [AppColors.Cornflower_Blue, AppColors.Royal_Purple],
                  ),
                ),
                child: ElevatedButton(

                  //displays login page when button is pushed
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
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
