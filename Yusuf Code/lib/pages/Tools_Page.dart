import 'package:flutter/material.dart';
import '../api_service.dart';
import '../models/tool_id.dart';
import 'chat_screen.dart';

class ToolsPage extends StatefulWidget {
  final VoidCallback? onGoToChat; // 👈 callback to switch tab to Chat

  const ToolsPage({Key? key, this.onGoToChat}) : super(key: key);

  @override
  State<ToolsPage> createState() => _ToolsPageState();
}

class _ToolsPageState extends State<ToolsPage> {
  ToolId? _selectedTool;
  String _selectedDifficulty = ApiService.currentDifficulty;

  final List<_ToolCardData> _cards = [
    _ToolCardData(
        id: ToolId.aiCoder,
        title: 'AI Coder',
        subtitle: 'Learn & Create',
        color: const Color(0xFF6EA8FE),
        icon: Icons.code),
    _ToolCardData(
        id: ToolId.smartComplete,
        title: 'Smart Complete',
        subtitle: 'Autofill & Predict',
        color: const Color(0xFF6EA8FE),
        icon: Icons.auto_mode),
    _ToolCardData(
        id: ToolId.codeOptimizer,
        title: 'Code Optimizer',
        subtitle: 'Improve & Simplify',
        color: const Color(0xFF6EA8FE),
        icon: Icons.tune),
    _ToolCardData(
        id: ToolId.bugFinder,
        title: 'Bug Finder',
        subtitle: 'Detect & Explain',
        color: const Color(0xFFB48CF5),
        icon: Icons.bug_report),
    _ToolCardData(
        id: ToolId.performance,
        title: 'Performance',
        subtitle: 'Measure & Analyze',
        color: const Color(0xFFB48CF5),
        icon: Icons.speed),
    _ToolCardData(
        id: ToolId.codeReview,
        title: 'Code Review',
        subtitle: 'Feedback & Guidance',
        color: const Color(0xFFB48CF5),
        icon: Icons.reviews),
  ];

  // When a tool is selected
  void _onToolSelect(ToolId id) async {
    setState(() => _selectedTool = id);
    ApiService.currentTool = id;

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("${id.name.replaceAll('_', ' ').toUpperCase()} selected"),
      duration: const Duration(milliseconds: 800),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.blueAccent.withOpacity(0.8),
    ));

    await Future.delayed(const Duration(milliseconds: 300));

    // 👇 Push Back Button To Chat
    if (widget.onGoToChat != null) {
      widget.onGoToChat!();
    } else {
      // fallback for direct use (e.g., testing standalone)
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const ChatScreen()),
      );
    }
  }

  void _onDifficultyChange(String diff) {
    setState(() => _selectedDifficulty = diff);
    ApiService.currentDifficulty = diff.toLowerCase();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Difficulty set to ${diff.toUpperCase()}"),
        duration: const Duration(milliseconds: 700),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.greenAccent.withOpacity(0.8),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E1020),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E1020),
        elevation: 0,
        title: const Text('CodeBrains Tools'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            // 🔁 Go to Chat tab instead of Navigator.pop
            if (widget.onGoToChat != null) {
              widget.onGoToChat!();
            }
          },
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _difficultySelector(),
            const SizedBox(height: 20),
            _sectionHeader('Code Helpers'),
            const SizedBox(height: 12),
            _grid(_cards.take(3).toList()),
            const SizedBox(height: 30),
            _sectionHeader('Debugging & Analysis'),
            const SizedBox(height: 12),
            _grid(_cards.skip(3).toList()),
          ],
        ),
      ),
    );
  }

  // Section header
  Widget _sectionHeader(String title) {
    return Row(
      children: [
        const Icon(Icons.bolt, color: Colors.white70, size: 18),
        const SizedBox(width: 8),
        Text(title,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
      ],
    );
  }

  // Grid of tool cards
  Widget _grid(List<_ToolCardData> items) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: items
          .map((d) => _ToolCard(
        data: d,
        isSelected: _selectedTool == d.id,
        onSelect: _onToolSelect,
      ))
          .toList(),
    );
  }

  // 🎚️ Difficulty Selector (linked to ApiService)
  Widget _difficultySelector() {
    final options = ['Beginner', 'Intermediate', 'Advanced'];
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1D2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Learning Difficulty',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white)),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            children: options.map((diff) {
              final active =
                  _selectedDifficulty.toLowerCase() == diff.toLowerCase();
              return ChoiceChip(
                label: Text(diff,
                    style: TextStyle(
                        color: active ? Colors.white : Colors.white70,
                        fontWeight:
                        active ? FontWeight.bold : FontWeight.normal)),
                selected: active,
                selectedColor: const Color(0xFF6EA8FE),
                backgroundColor: const Color(0xFF111526),
                onSelected: (_) => _onDifficultyChange(diff),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

// -------------------------------------------------------------------
// 🧩 Tool Card Component
// -------------------------------------------------------------------
class _ToolCardData {
  final ToolId id;
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  const _ToolCardData({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
  });
}

class _ToolCard extends StatefulWidget {
  final _ToolCardData data;
  final bool isSelected;
  final Function(ToolId) onSelect;
  const _ToolCard({
    required this.data,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  State<_ToolCard> createState() => _ToolCardState();
}

class _ToolCardState extends State<_ToolCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    _scale = Tween<double>(begin: 1.0, end: 0.95).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.data;
    final active = widget.isSelected;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) async {
        _controller.reverse();
        await Future.delayed(const Duration(milliseconds: 100));
        widget.onSelect(d.id);
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          width: (MediaQuery.of(context).size.width - 16 * 3) / 2,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF111526),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: active ? d.color : Colors.white12,
              width: active ? 1.6 : 1,
            ),
            boxShadow: [
              if (active)
                BoxShadow(
                  color: d.color.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: d.color.withOpacity(0.25),
                child: Icon(d.icon, color: Colors.white, size: 20),
              ),
              const SizedBox(height: 14),
              Text(d.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Colors.white)),
              const SizedBox(height: 4),
              Text(d.subtitle,
                  style:
                  const TextStyle(color: Colors.greenAccent, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
