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
        cardColor: AppColors.Yankees_Blue, // Card background color (adjusted for contrast)
        textTheme: TextTheme(
          bodyLarge: const TextStyle(color: AppColors.textPrimary), // White text
          bodyMedium: const TextStyle(color: AppColors.textSecondary), // White at 70% opacity
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
      iconColor: AppColors.Royal_Purple,
    ),
    Course(
      title: 'Debugging with AI Tools',
      subtitle: '8 lessons + 1h 45min',
      progress: 0.40,
      iconColor: AppColors.Cornflower_Blue,
    ),
  ];

  final List<LearningPath> paths = [
    LearningPath(
      title: 'Beginner',
      lessons: '15 lessons',
      iconColor: AppColors.Cornflower_Blue,
    ),
    LearningPath(
      title: 'Intermediate',
      lessons: '24 lessons',
      iconColor: AppColors.Royal_Purple,
    ),
  ];

  final List<Achievement> achievements = [
    Achievement(
      title: 'First Code',
      icon: Icons.code,
      iconColor: AppColors.Cornflower_Blue,
      unlockCondition: 'Complete any course',
      isUnlocked: true,
    ),
    Achievement(
      title: 'Completed 5 Lessons',
      icon: Icons.star,
      iconColor: AppColors.Royal_Purple,
      unlockCondition: 'Complete 5 lessons across courses',
      isUnlocked: false,
    ),
    Achievement(
      title: 'Master Coder',
      icon: Icons.code_off,
      iconColor: AppColors.Cornflower_Blue,
      unlockCondition: 'Complete all courses',
      isUnlocked: false,
    ),
  ];

  // Animation controllers for card taps
  double _cardScale = 1.0;

  // Level dropdown state
  String _selectedLevel = 'Level 1';
  final List<String> _levels = ['Level 1', 'Level 2', 'Level 3'];

  void _onCardTap() {
    setState(() {
      _cardScale = 0.95; // Scale down on tap
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tapped on card! Add navigation details here later.')),
    );
    Future.delayed(const Duration(milliseconds: 150), () {
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
    return Container(
      decoration: BoxDecoration(gradient: AppGradients.mainBackground),
      child: Scaffold(
        extendBodyBehindAppBar: true, // Allow body to extend behind AppBar
        backgroundColor: Colors.transparent, // Ensure no default background
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Learning',
            style: TextStyle(color: AppColors.textPrimary),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [AppColors.Cornflower_Blue, AppColors.Royal_Purple],
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedLevel,
                  icon: const Icon(Icons.arrow_drop_down, color: AppColors.textPrimary),
                  style: const TextStyle(color: AppColors.textPrimary),
                  dropdownColor: AppColors.Yankees_Blue,
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
            const SizedBox(width: 8.0),
          ],
        ),
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  'Continue Learning',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ...courses.map((course) => _buildCourseCard(course)).toList(),
              const SizedBox(height: 16),
              Card(
                color: AppColors.Yankees_Blue,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Learning Paths',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                            onPressed: _navigateToLearningPaths,
                            child: const Text(
                              'Explore',
                              style: TextStyle(color: AppColors.Cornflower_Blue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: paths.map((path) => _buildPathCard(path.title, path.lessons, path.iconColor)).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                color: AppColors.Yankees_Blue,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.check_circle, color: AppColors.Cornflower_Blue, size: 40),
                          const SizedBox(width: 16),
                          const Text(
                            'Achievements',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          TextButton(
                            onPressed: _navigateToAchievements,
                            child: const Text(
                              'View All',
                              style: TextStyle(color: AppColors.Cornflower_Blue),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ...achievements.map((achievement) => _buildAchievementCard(achievement)).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Removed navigation bar as per your setup (handled by WelcomeScreen in other code)
      ),
    );
  }

  Widget _buildCourseCard(Course course) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: Matrix4.identity()..scale(_cardScale),
      child: Card(
        color: AppColors.Yankees_Blue,
        child: InkWell(
          onTap: () => _navigateToCourseDetail(course),
          borderRadius: BorderRadius.circular(8),
          child: ListTile(
            leading: Icon(Icons.code, color: course.iconColor, size: 40),
            title: Text(
              course.title,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 16),
            ),
            subtitle: Text(
              course.subtitle,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            trailing: Text(
              '${(course.progress * 100).toInt()}% Complete',
              style: const TextStyle(color: Colors.green, fontSize: 14),
            ),
            contentPadding: const EdgeInsets.all(16.0),
          ),
        ),
      ),
    );
  }

  Widget _buildPathCard(String title, String lessons, Color color) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
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
          color: AppColors.cardTop,
          child: Container(
            width: 140,
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Icon(Icons.star, color: color, size: 40),
                const SizedBox(height: 8),
                Text(title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 16)),
                Text(lessons, style: const TextStyle(color: AppColors.textSecondary)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementCard(Achievement achievement) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_cardScale),
        child: InkWell(
          onTap: _onCardTap,
          borderRadius: BorderRadius.circular(8),
          child: Card(
            color: AppColors.Yankees_Blue,
            child: ListTile(
              leading: Icon(achievement.icon, color: achievement.iconColor, size: 40),
              title: Text(
                achievement.title,
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 16),
              ),
              trailing: achievement.isUnlocked
                  ? const Icon(Icons.check_circle, color: AppColors.Cornflower_Blue, size: 30)
                  : const Icon(Icons.lock, color: Colors.grey, size: 30),
              subtitle: !achievement.isUnlocked
                  ? Text(
                'Locked: ${achievement.unlockCondition}',
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
              )
                  : null,
              contentPadding: const EdgeInsets.all(16.0),
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
    return Container(
      decoration: BoxDecoration(gradient: AppGradients.mainBackground),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            course.title,
            style: const TextStyle(color: AppColors.textPrimary),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: AppColors.Yankees_Blue,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Progress: ${(course.progress * 100).toInt()}%',
                      style: const TextStyle(color: Colors.green, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Lessons: ${course.subtitle}',
                      style: const TextStyle(color: AppColors.textPrimary, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Accessing ${course.title} content...')),
                          );
                        },
                        child: const Text('Start Course'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.Cornflower_Blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
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
    return Container(
      decoration: BoxDecoration(gradient: AppGradients.mainBackground),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Learning Paths',
            style: TextStyle(color: AppColors.textPrimary),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: paths.length,
              itemBuilder: (context, index) {
                final path = paths[index];
                return Card(
                  color: AppColors.Yankees_Blue,
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
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.star, color: path.iconColor, size: 40),
                          const SizedBox(height: 8),
                          Text(
                            path.title,
                            style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            path.lessons,
                            style: const TextStyle(color: AppColors.textSecondary),
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
    return Container(
      decoration: BoxDecoration(gradient: AppGradients.mainBackground),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Beginner Path',
            style: TextStyle(color: AppColors.textPrimary),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lessons (5 total)',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: lessons.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: AppColors.Yankees_Blue,
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          leading: const Icon(Icons.play_circle_outline, color: AppColors.Cornflower_Blue, size: 30),
                          title: Text(
                            lessons[index],
                            style: const TextStyle(color: AppColors.textPrimary),
                          ),
                          trailing: SizedBox(
                            width: 60,
                            child: LinearProgressIndicator(
                              value: (index / lessons.length).toDouble(),
                              backgroundColor: Colors.grey[700],
                              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.Cornflower_Blue),
                              minHeight: 4,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
    return Container(
      decoration: BoxDecoration(gradient: AppGradients.mainBackground),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Intermediate Path',
            style: TextStyle(color: AppColors.textPrimary),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Lessons (8 total)',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: lessons.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: AppColors.Yankees_Blue,
                        margin: const EdgeInsets.only(bottom: 8.0),
                        child: ListTile(
                          leading: const Icon(Icons.play_circle_outline, color: AppColors.Royal_Purple, size: 30),
                          title: Text(
                            lessons[index],
                            style: const TextStyle(color: AppColors.textPrimary),
                          ),
                          trailing: SizedBox(
                            width: 60,
                            child: LinearProgressIndicator(
                              value: (index / lessons.length).toDouble(),
                              backgroundColor: Colors.grey[700],
                              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.Royal_Purple),
                              minHeight: 4,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
    return Container(
      decoration: BoxDecoration(gradient: AppGradients.mainBackground),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Achievements',
            style: TextStyle(color: AppColors.textPrimary),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: achievements.length,
              itemBuilder: (context, index) {
                final achievement = achievements[index];
                return Card(
                  color: AppColors.Yankees_Blue,
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    leading: Icon(achievement.icon, color: achievement.iconColor, size: 40),
                    title: Text(
                      achievement.title,
                      style: const TextStyle(color: AppColors.textPrimary, fontSize: 16),
                    ),
                    trailing: achievement.isUnlocked
                        ? const Icon(Icons.check_circle, color: AppColors.Cornflower_Blue, size: 30)
                        : const Icon(Icons.lock, color: Colors.grey, size: 30),
                    subtitle: !achievement.isUnlocked
                        ? Text(
                      'Locked: ${achievement.unlockCondition}',
                      style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
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
