import 'package:flutter/material.dart';

class LearningPage extends StatefulWidget {
  const LearningPage({super.key});

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  final List<_Lesson> lessons = [
    _Lesson(
      title: "AI Code Generation Basics",
      description:
      "Learn how to use AI tools like CodeBrains to generate efficient, readable code snippets across languages like Python, Dart, and C#.",
      progress: 0.8,
      color: const Color(0xFF6EA8FE),
      chapters: [
        "What is AI-assisted coding?",
        "Prompt structure and clarity",
        "Understanding model outputs",
        "Real-world examples"
      ],
    ),
    _Lesson(
      title: "Debugging with AI",
      description:
      "Understand how AI identifies bugs, explains logic errors, and suggests fixes in your source code.",
      progress: 0.45,
      color: const Color(0xFFB48CF5),
      chapters: [
        "How AI detects logical issues",
        "Common syntax pitfalls",
        "Debugging in Dart and Flutter",
        "AI-based unit testing"
      ],
    ),
    _Lesson(
      title: "Optimizing Code Performance",
      description:
      "Explore how AI can profile and enhance code performance, reduce redundancy, and improve efficiency.",
      progress: 0.3,
      color: const Color(0xFF4ECDC4),
      chapters: [
        "What makes code efficient?",
        "Reducing computational complexity",
        "Memory management best practices",
        "Benchmarking and analysis"
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1020),
      appBar: AppBar(
        title: const Text(
          "Learning",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF0E1020),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0E1020), Color(0xFF1A1D2E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: lessons.length,
          itemBuilder: (context, index) {
            final lesson = lessons[index];
            return _LessonCard(lesson: lesson);
          },
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 📘 Lesson model
// ---------------------------------------------------------------------------
class _Lesson {
  final String title;
  final String description;
  final double progress;
  final Color color;
  final List<String> chapters;

  _Lesson({
    required this.title,
    required this.description,
    required this.progress,
    required this.color,
    required this.chapters,
  });
}

// ---------------------------------------------------------------------------
// 🧠 Lesson Card UI
// ---------------------------------------------------------------------------
class _LessonCard extends StatefulWidget {
  final _Lesson lesson;
  const _LessonCard({required this.lesson});

  @override
  State<_LessonCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<_LessonCard> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    final lesson = widget.lesson;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF111526),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: lesson.color.withOpacity(0.3), width: 1.4),
        boxShadow: [
          BoxShadow(
            color: lesson.color.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      lesson.color.withOpacity(0.8),
                      lesson.color.withOpacity(0.4)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(Icons.school, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  lesson.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => setState(() => expanded = !expanded),
                icon: Icon(
                  expanded ? Icons.expand_less : Icons.expand_more,
                  color: Colors.white70,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Description
          Text(
            lesson.description,
            style: const TextStyle(color: Colors.white70, fontSize: 13),
          ),

          const SizedBox(height: 16),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: lesson.progress,
              minHeight: 8,
              color: lesson.color,
              backgroundColor: Colors.white10,
            ),
          ),

          const SizedBox(height: 10),

          // Chapters (expandable)
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 300),
            crossFadeState: expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                ...lesson.chapters.map(
                      (chapter) => Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 6),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle_outline,
                            color: Colors.white54, size: 16),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            chapter,
                            style: const TextStyle(
                                color: Colors.white70, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
