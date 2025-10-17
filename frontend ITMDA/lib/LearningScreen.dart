// Importing necessary Flutter material package for UI components
import 'package:flutter/material.dart';
// Importing custom colors (assumed to be defined in a separate file)
import 'colors.dart';

// Entry point of the application
void main() {
  // Runs the main app widget
  runApp(MyApp());
}

// Main app widget, stateless since it doesn't manage dynamic state
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Sets the initial screen to LearningScreen
      home: LearningScreen(),
      // Defines the app's theme with a dark base and customizations
      theme: ThemeData.dark().copyWith(
        // Transparent background to allow gradient (defined in LearningScreen)
        scaffoldBackgroundColor: Colors.transparent,
        // Card background color using custom color from AppColors
        cardColor: AppColors.Yankees_Blue,
        // Custom text theme for consistent text styling
        textTheme: TextTheme(
          // Primary text style (white)
          bodyLarge: const TextStyle(color: AppColors.textPrimary),
          // Secondary text style (white at 70% opacity)
          bodyMedium: const TextStyle(color: AppColors.textSecondary),
        ),
      ),
    );
  }
}

// Data model for a Course, representing a single course with its properties
class Course {
  final String title; // Course title
  final String subtitle; // Additional info (e.g., lessons and duration)
  final double progress; // Progress as a fraction (0.0 to 1.0)
  final Color iconColor; // Color for the course's icon
  bool isCompleted; // Tracks if the course is fully completed

  Course({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.iconColor,
    this.isCompleted = false, // Default to not completed
  });
}

// Data model for a Learning Path, representing a collection of lessons
class LearningPath {
  final String title; // Path title (e.g., Beginner, Intermediate)
  final String lessons; // Description of lessons (e.g., number of lessons)
  final Color iconColor; // Color for the path's icon

  LearningPath({
    required this.title,
    required this.lessons,
    required this.iconColor,
  });
}

// Data model for an Achievement, representing a user accomplishment
class Achievement {
  final String title; // Achievement title
  final IconData icon; // Icon to display for the achievement
  final Color iconColor; // Color for the achievement's icon
  final String unlockCondition; // Condition to unlock the achievement
  bool isUnlocked; // Tracks if the achievement is unlocked

  Achievement({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.unlockCondition,
    this.isUnlocked = false, // Default to locked
  });
}

// Main screen for the learning section, stateful to manage dynamic state
class LearningScreen extends StatefulWidget {
  @override
  _LearningScreenState createState() => _LearningScreenState();
}

// State class for LearningScreen, managing dynamic data and UI interactions
class _LearningScreenState extends State<LearningScreen> {
  // List of courses with sample data
  final List<Course> courses = [
    Course(
      title: 'AI Code Generation Basics',
      subtitle: '12 lessons + 2h 30min',
      progress: 0.75, // 75% complete
      iconColor: AppColors.Royal_Purple,
    ),
    Course(
      title: 'Debugging with AI Tools',
      subtitle: '8 lessons + 1h 45min',
      progress: 0.40, // 40% complete
      iconColor: AppColors.Cornflower_Blue,
    ),
  ];

  // List of learning paths with sample data
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

  // List of achievements with sample data
  final List<Achievement> achievements = [
    Achievement(
      title: 'First Code',
      icon: Icons.code,
      iconColor: AppColors.Cornflower_Blue,
      unlockCondition: 'Complete any course',
      isUnlocked: true, // This achievement is unlocked
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

  // Animation scale for card tap feedback
  double _cardScale = 1.0;

  // State for the level dropdown
  String _selectedLevel = 'Level 1';
  final List<String> _levels = ['Level 1', 'Level 2', 'Level 3'];

  // Handles card tap animation and shows a snackbar
  void _onCardTap() {
    setState(() {
      _cardScale = 0.95; // Scale down for tap effect
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Tapped on card! Add navigation details here later.')),
    );
    // Reset scale after a short delay
    Future.delayed(const Duration(milliseconds: 150), () {
      setState(() {
        _cardScale = 1.0;
      });
    });
  }

  // Updates the selected level and shows a snackbar
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

  // Navigates to the course detail page
  void _navigateToCourseDetail(Course course) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CourseDetailPage(course: course)),
    );
  }

  // Navigates to the learning paths page
  void _navigateToLearningPaths() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LearningPathsPage(paths: paths)),
    );
  }

  // Navigates to the achievements page
  void _navigateToAchievements() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AchievementsPage(achievements: achievements)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Applies a gradient background defined in AppGradients
      decoration: BoxDecoration(gradient: AppGradients.mainBackground),
      child: Scaffold(
        // Extends body behind AppBar for seamless gradient
        extendBodyBehindAppBar: true,
        // Transparent background to show gradient
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // No shadow for a cleaner look
          title: const Text(
            'Learning',
            style: TextStyle(color: AppColors.textPrimary),
          ),
          actions: [
            // Dropdown for selecting levels with a gradient container
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
              // Section header for courses
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
              // Builds course cards dynamically from the courses list
              ...courses.map((course) => _buildCourseCard(course)).toList(),
              const SizedBox(height: 16),
              // Card for learning paths section
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
                          // Button to navigate to full learning paths page
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
                      // Displays learning path cards in a row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: paths.map((path) => _buildPathCard(path.title, path.lessons, path.iconColor)).toList(),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Card for achievements section
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
                          // Button to navigate to full achievements page
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
                      // Builds achievement cards dynamically
                      ...achievements.map((achievement) => _buildAchievementCard(achievement)).toList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        // Navigation bar is handled elsewhere (e.g., WelcomeScreen)
      ),
    );
  }

  // Builds a card for a single course with tap animation and navigation
  Widget _buildCourseCard(Course course) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: Matrix4.identity()..scale(_cardScale), // Scales card on tap
      child: Card(
        color: AppColors.Yankees_Blue,
        child: InkWell(
          onTap: () => _navigateToCourseDetail(course), // Navigates to course details
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

  // Builds a card for a learning path with tap navigation
  Widget _buildPathCard(String title, String lessons, Color color) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      transform: Matrix4.identity()..scale(_cardScale),
      child: InkWell(
        onTap: () {
          // Navigates to specific path page based on title
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

  // Builds a card for an achievement with tap feedback
  Widget _buildAchievementCard(Achievement achievement) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()..scale(_cardScale),
        child: InkWell(
          onTap: _onCardTap, // Triggers tap animation and snackbar
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

// Detail page for a specific course, stateless as it displays static course data
class CourseDetailPage extends StatelessWidget {
  final Course course; // Course data to display

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
            onPressed: () => Navigator.pop(context), // Returns to previous screen
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
                    // Displays course progress
                    Text(
                      'Progress: ${(course.progress * 100).toInt()}%',
                      style: const TextStyle(color: Colors.green, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    // Displays course subtitle (lessons and duration)
                    Text(
                      'Lessons: ${course.subtitle}',
                      style: const TextStyle(color: AppColors.textPrimary, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    // Button to start the course
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

// Page displaying all learning paths in a grid
class LearningPathsPage extends StatelessWidget {
  final List<LearningPath> paths; // List of paths to display

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
              // Grid layout with 2 columns
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
                      // Navigates to specific path page
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

// Page for the Beginner learning path, listing beginner lessons
class BeginnerPage extends StatelessWidget {
  // Sample lesson data for the beginner path
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
                // Section header
                const Text(
                  'Lessons (5 total)',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // List of lessons
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
                              value: (index / lessons.length).toDouble(), // Simulated progress
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

// Page for the Intermediate learning path, listing intermediate lessons
class IntermediatePage extends StatelessWidget {
  // Sample lesson data for the intermediate path
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
                // Section header
                const Text(
                  'Lessons (8 total)',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                // List of lessons
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
                              value: (index / lessons.length).toDouble(), // Simulated progress
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

// Page displaying all achievements in a list
class AchievementsPage extends StatelessWidget {
  final List<Achievement> achievements; // List of achievements to display

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
                      // Shows details for unlocked achievements
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
