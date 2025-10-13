import 'package:flutter/material.dart';
import 'colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LearningScreen(),
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.transparent, // Allow gradient background
        cardColor: Color(0xFF16213E), // Card background color (adjusted for contrast)
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFFFFFFFF)), // White text
          bodyMedium: TextStyle(color: Color(0xFFB3FFFFFF)), // White at 70% opacity
        ),
      ),
    );
  }
}

// Data models for dynamic content
class Course {
  final String title;
  final String subtitle;
  final double progress;
  final Color iconColor;
  bool isCompleted;

  Course({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.iconColor,
    this.isCompleted = false,
  });
}

class LearningPath {
  final String title;
  final String lessons;
  final Color iconColor;

  LearningPath({
    required this.title,
    required this.lessons,
    required this.iconColor,
  });
}

class Achievement {
  final String title;
  final IconData icon;
  final Color iconColor;
  final String unlockCondition;
  bool isUnlocked;

  Achievement({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.unlockCondition,
    this.isUnlocked = false,
  });
}

class LearningScreen extends StatefulWidget {
  @override
  _LearningScreenState createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  // Dynamic data
  final List<Course> courses = [
    Course(
      title: 'AI Code Generation Basics',
      subtitle: '12 lessons + 2h 30min',
      progress: 0.75,
      iconColor: Color(0xFF7851A9), // Royal Purple
    ),
    Course(
      title: 'Debugging with AI Tools',
      subtitle: '8 lessons + 1h 45min',
      progress: 0.40,
      iconColor: Color(0xFF6495ED), // Cornflower Blue
    ),
  ];

  final List<LearningPath> paths = [
    LearningPath(
      title: 'Beginner',
      lessons: '15 lessons',
      iconColor: Color(0xFF6495ED), // Cornflower Blue
    ),
    LearningPath(
      title: 'Intermediate',
      lessons: '24 lessons',
      iconColor: Color(0xFF7851A9), // Royal Purple
    ),
  ];

  final List<Achievement> achievements = [
    Achievement(
      title: 'First Code',
      icon: Icons.code,
      iconColor: Color(0xFF6495ED), // Cornflower Blue
      unlockCondition: 'Complete any course',
      isUnlocked: true,
    ),
    Achievement(
      title: 'Completed 5 Lessons',
      icon: Icons.star,
      iconColor: Color(0xFF7851A9), // Royal Purple
      unlockCondition: 'Complete 5 lessons across courses',
      isUnlocked: false,
    ),
    Achievement(
      title: 'Master Coder',
      icon: Icons.code_off,
      iconColor: Color(0xFF6495ED), // Cornflower Blue
      unlockCondition: 'Complete all courses',
      isUnlocked: false,
    ),
  ];

  // Animation controllers for card taps (optional, for scale effect)
  double _cardScale = 1.0;

  // Level dropdown state
  String _selectedLevel = 'Level 1';
  final List<String> _levels = ['Level 1', 'Level 2', 'Level 3'];

  void _onCardTap() {
    setState(() {
      _cardScale = 0.95; // Scale down on tap
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Tapped on card! Add navigation details here later.')),
    );
    Future.delayed(Duration(milliseconds: 150), () {
      setState(() {
        _cardScale = 1.0; // Scale back
      });
    });
  }

  void _onLevelChanged(String? newLevel) {
    if (newLevel != null && newLevel != _selectedLevel) {
      setState(() {
        _selectedLevel = newLevel;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selected level: $newLevel')),
      );
    }
  }

  void _navigateToCourseDetail(Course course) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CourseDetailPage(course: course)),
    );
  }

  void _navigateToLearningPaths() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LearningPathsPage(paths: paths)),
    );
  }

  void _navigateToAchievements() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AchievementsPage(achievements: achievements)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Learning',
          style: TextStyle(color: Color(0xFFFFFFFF)), // White text
        ),
        actions: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF6495ED), // Cornflower Blue
                  Color(0xFF7851A9), // Royal Purple
                ],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedLevel,
                icon: Icon(Icons.arrow_drop_down, color: Color(0xFFFFFFFF)),
                style: TextStyle(color: Color(0xFFFFFFFF)),
                dropdownColor: Color(0xFF16213E),
                onChanged: _onLevelChanged,
                items: _levels.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          SizedBox(width: 8.0),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A252F), // Dark Navy
              Color(0xFF1C2526), // Yankees Blue
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Continue Learning',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...courses.map((course) => _buildCourseCard(course)).toList(),
              SizedBox(height: 16),
              Card(
                color: Color(0xFF16213E),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Learning Paths',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: _navigateToLearningPaths,
                            child: Text(
                              'Explore',
                              style: TextStyle(color: Color(0xFF6495ED)), // Cornflower Blue
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: paths.map((path) => _buildPathCard(path.title, path.lessons, path.iconColor)).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Card(
                color: Color(0xFF16213E),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.check_circle, color: Color(0xFF6495ED), size: 40), // Cornflower Blue
                          SizedBox(width: 16),
                          Text(
                            'Achievements',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: _navigateToAchievements,
                            child: Text(
                              'View All',
                              style: TextStyle(color: Color(0xFF6495ED)), // Cornflower Blue
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      ...achievements.map((achievement) => _buildAchievementCard(achievement)).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      //TODO - REMOVED NAV BAR
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.transparent,
      //   selectedItemColor: Color(0xFF6495ED), // Cornflower Blue
      //   unselectedItemColor: Color(0xFFB3FFFFFF), // White at 70% opacity
      //   showSelectedLabels: false,
      //   showUnselectedLabels: true,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Padding(
      //         padding: EdgeInsets.only(bottom: 4.0),
      //         child: Icon(Icons.home, size: 24),
      //       ),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Padding(
      //         padding: EdgeInsets.only(bottom: 4.0),
      //         child: Icon(Icons.build, size: 24),
      //       ),
      //       label: 'Tools',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: SizedBox(
      //         height: 24,
      //         child: Container(
      //           decoration: BoxDecoration(
      //             gradient: LinearGradient(
      //               begin: Alignment.centerLeft,
      //               end: Alignment.centerRight,
      //               colors: [
      //                 Color(0xFF6495ED), // Cornflower Blue
      //                 Color(0xFF7851A9), // Royal Purple
      //               ],
      //             ),
      //             shape: BoxShape.circle,
      //           ),
      //           padding: EdgeInsets.all(4.0),
      //           child: Icon(Icons.add, color: Color(0xFFFFFFFF), size: 16),
      //         ),
      //       ),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Padding(
      //         padding: EdgeInsets.only(bottom: 4.0),
      //         child: Icon(Icons.school, size: 24),
      //       ),
      //       label: 'Learning',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Padding(
      //         padding: EdgeInsets.only(bottom: 4.0),
      //         child: Icon(Icons.person, size: 24),
      //       ),
      //       label: 'Profile',
      //     ),
      //   ],
      //   currentIndex: 2, // Highlight the "add" button
      //   type: BottomNavigationBarType.fixed,
      // ),
    );
  }

  Widget _buildCourseCard(Course course) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      transform: Matrix4.identity()..scale(_cardScale),
      child: Card(
        color: Color(0xFF16213E),
        child: InkWell(
          onTap: () => _navigateToCourseDetail(course),
          borderRadius: BorderRadius.circular(8),
          child: ListTile(
            leading: Icon(Icons.code, color: course.iconColor, size: 40),
            title: Text(
              course.title,
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
            ),
            subtitle: Text(
              course.subtitle,
              style: TextStyle(color: Color(0xFFB3FFFFFF)),
            ),
            trailing: Text(
              '${(course.progress * 100).toInt()}% Complete',
              style: TextStyle(color: Colors.green, fontSize: 14),
            ),
            contentPadding: EdgeInsets.all(16.0),
          ),
        ),
      ),
    );
  }

  Widget _buildPathCard(String title, String lessons, Color color) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      transform: Matrix4.identity()..scale(_cardScale),
      child: InkWell(
        onTap: () {
          if (title == 'Beginner') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => BeginnerPage()),
            );
          } else if (title == 'Intermediate') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => IntermediatePage()),
            );
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Card(
          color: Color(0xFF1A252F), // Dark Navy
          child: Container(
            width: 140,
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                Icon(Icons.star, color: color, size: 40),
                SizedBox(height: 8),
                Text(title, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16)),
                Text(lessons, style: TextStyle(color: Color(0xFFB3FFFFFF))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementCard(Achievement achievement) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_cardScale),
        child: InkWell(
          onTap: _onCardTap,
          borderRadius: BorderRadius.circular(8),
          child: Card(
            color: Color(0xFF16213E),
            child: ListTile(
              leading: Icon(achievement.icon, color: achievement.iconColor, size: 40),
              title: Text(
                achievement.title,
                style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
              ),
              trailing: achievement.isUnlocked
                  ? Icon(Icons.check_circle, color: Color(0xFF6495ED), size: 30)
                  : Icon(Icons.lock, color: Colors.grey, size: 30),
              subtitle: !achievement.isUnlocked
                  ? Text(
                'Locked: ${achievement.unlockCondition}',
                style: TextStyle(color: Color(0xFFB3FFFFFF), fontSize: 12),
              )
                  : null,
              contentPadding: EdgeInsets.all(16.0),
            ),
          ),
        ),
      ),
    );
  }
}

// Course Detail Page
class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({Key? key, required this.course}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          course.title,
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFFFFFF)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A252F), // Dark Navy
              Color(0xFF1C2526), // Yankees Blue
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Card(
              color: Color(0xFF16213E),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max, // Use full available space
                  children: [
                    Text(
                      'Progress: ${(course.progress * 100).toInt()}%',
                      style: TextStyle(color: Colors.green, fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Lessons: ${course.subtitle}',
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                    ),
                    SizedBox(height: 16),
                    Expanded( // Flexible space for future content
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Accessing ${course.title} content...')),
                            );
                          },
                          child: Text('Start Course'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF6495ED), // Cornflower Blue
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Learning Paths Page
class LearningPathsPage extends StatelessWidget {
  final List<LearningPath> paths;

  const LearningPathsPage({Key? key, required this.paths}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Learning Paths',
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFFFFFF)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A252F), // Dark Navy
              Color(0xFF1C2526), // Yankees Blue
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: paths.length,
              itemBuilder: (context, index) {
                final path = paths[index];
                return Card(
                  color: Color(0xFF16213E),
                  child: InkWell(
                    onTap: () {
                      if (path.title == 'Beginner') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => BeginnerPage()),
                        );
                      } else if (path.title == 'Intermediate') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => IntermediatePage()),
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: path.iconColor, size: 40),
                          SizedBox(height: 8),
                          Text(
                            path.title,
                            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            path.lessons,
                            style: TextStyle(color: Color(0xFFB3FFFFFF)),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

// Beginner Page
class BeginnerPage extends StatelessWidget {
  final List<String> lessons = [
    'Introduction to AI Coding',
    'Basic Code Generation Techniques',
    'Understanding AI Tools',
    'First AI Project Setup',
    'Simple Debugging Basics',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Beginner Path',
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFFFFFF)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A252F), // Dark Navy
              Color(0xFF1C2526), // Yankees Blue
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lessons (5 total)',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: lessons.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Color(0xFF16213E),
                        margin: EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          leading: Icon(Icons.play_circle_outline, color: Color(0xFF6495ED), size: 30),
                          title: Text(
                            lessons[index],
                            style: TextStyle(color: Color(0xFFFFFFFF)),
                          ),
                          trailing: SizedBox(
                            width: 60,
                            child: LinearProgressIndicator(
                              value: (index / lessons.length).toDouble(),
                              backgroundColor: Colors.grey[700],
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6495ED)),
                              minHeight: 4,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Reduced padding
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Starting lesson: ${lessons[index]}')),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Intermediate Page
class IntermediatePage extends StatelessWidget {
  final List<String> lessons = [
    'Advanced AI Code Generation',
    'Complex Debugging Scenarios',
    'AI Tool Integration',
    'Building Multi-Module Projects',
    'Performance Optimization with AI',
    'Error Handling Best Practices',
    'Collaborative Coding with AI',
    'Deployment and Testing',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Intermediate Path',
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFFFFFF)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A252F), // Dark Navy
              Color(0xFF1C2526), // Yankees Blue
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lessons (8 total)',
                  style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: lessons.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Color(0xFF16213E),
                        margin: EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          leading: Icon(Icons.play_circle_outline, color: Color(0xFF7851A9), size: 30),
                          title: Text(
                            lessons[index],
                            style: TextStyle(color: Color(0xFFFFFFFF)),
                          ),
                          trailing: SizedBox(
                            width: 60,
                            child: LinearProgressIndicator(
                              value: (index / lessons.length).toDouble(),
                              backgroundColor: Colors.grey[700],
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF7851A9)),
                              minHeight: 4,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Reduced padding
                          onTap: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Starting lesson: ${lessons[index]}')),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Achievements Page
class AchievementsPage extends StatelessWidget {
  final List<Achievement> achievements;

  const AchievementsPage({Key? key, required this.achievements}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Achievements',
          style: TextStyle(color: Color(0xFFFFFFFF)),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFFFFFFFF)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A252F), // Dark Navy
              Color(0xFF1C2526), // Yankees Blue
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                final achievement = achievements[index];
                return Card(
                  color: Color(0xFF16213E),
                  margin: EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    leading: Icon(achievement.icon, color: achievement.iconColor, size: 40),
                    title: Text(
                      achievement.title,
                      style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
                    ),
                    trailing: achievement.isUnlocked
                        ? Icon(Icons.check_circle, color: Color(0xFF6495ED), size: 30)
                        : Icon(Icons.lock, color: Colors.grey, size: 30),
                    subtitle: !achievement.isUnlocked
                        ? Text(
                      'Locked: ${achievement.unlockCondition}',
                      style: TextStyle(color: Color(0xFFB3FFFFFF), fontSize: 12),
                    )
                        : null,
                    onTap: () {
                      if (achievement.isUnlocked) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Details for ${achievement.title}')),
                        );
                      }
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}