import 'package:flutter/material.dart';
import 'code_block.dart';

class MessageBubble extends StatefulWidget {
  final String text;
  final bool isUser;
  final DateTime time;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isUser,
    required this.time,
  });

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fade;
  late Animation<Offset> _slide;
  late Animation<double> _float;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _slide = Tween<Offset>(
      begin: Offset(0, widget.isUser ? 0.25 : 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _float = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final text = widget.text;
    final isUser = widget.isUser;

    final codeRegExp = RegExp(r'```(.*?)```', dotAll: true);
    final matches = codeRegExp.allMatches(text);
    final parts = text.split(codeRegExp);
    final codeSnippets = matches.map((m) => m.group(1) ?? "").toList();

    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: ScaleTransition(
          scale: _float,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 340),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: isUser
                    ? const LinearGradient(
                  colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                    : const LinearGradient(
                  colors: [Color(0xFF2C2E4A), Color(0xFF1B1E36)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                  color: isUser
                      ? const Color(0xFF8A9EFF).withOpacity(0.4)
                      : const Color(0xFF4E5B9D).withOpacity(0.35),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isUser
                        ? const Color(0xFF667EEA).withOpacity(0.3)
                        : const Color(0xFF2D3E7A).withOpacity(0.4),
                    offset: const Offset(0, 3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment:
                isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < parts.length; i++) ...[
                    if (parts[i].trim().isNotEmpty)
                      Text(
                        parts[i].trim(),
                        style: TextStyle(
                          color: isUser ? Colors.white : Colors.white70,
                          fontSize: 15,
                          height: 1.4,
                        ),
                      ),
                    if (i < codeSnippets.length)
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: CodeBlock(code: codeSnippets[i]),
                      ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
