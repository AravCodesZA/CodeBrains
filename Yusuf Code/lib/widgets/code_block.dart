import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/vs2015.dart';

class CodeBlock extends StatelessWidget {
  final String code;

  const CodeBlock({super.key, required this.code});

  /// Detects language tag like ```dart or ```python
  String _detectLanguage(String input) {
    final match = RegExp(r'```(\w+)').firstMatch(input);
    return match != null ? match.group(1)! : 'plaintext';
  }

  /// Cleans Markdown fences ```lang ... ```
  String _cleanCode(String input) {
    return input
        .replaceAll(RegExp(r'```[\w]*'), '')
        .replaceAll('```', '')
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    final language = _detectLanguage(code);
    final cleanCode = _cleanCode(code);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: HighlightView(
          cleanCode,
          language: language,
          theme: vs2015Theme,
          textStyle: const TextStyle(
            fontFamily: 'SourceCodePro',
            fontSize: 13,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
