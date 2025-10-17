import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'models/tool_id.dart';

/// ---------------------------------------------------------------------------
/// 🧠 API SERVICE — CENTRAL AI LOGIC CONTROLLER
/// ---------------------------------------------------------------------------
/// This class manages:
/// - OpenAI API calls
/// - Conversation memory
/// - Teaching mode, difficulty, and tool context
/// - Rule enforcement for AI responses
/// ---------------------------------------------------------------------------
class ApiService {
  // ===========================================================================
  // 🌍 1. API CONFIGURATION
  // ===========================================================================
  static const String _url = 'https://api.openai.com/v1/chat/completions';

  // Stores the current conversation as a list of role-content pairs
  static final List<Map<String, String>> _conversation = [];

  // Stores multiple saved chats (like a local memory system)
  static final Map<String, List<Map<String, String>>> _savedChats = {};

  // ===========================================================================
  // ⚙️ 2. CURRENT STATE (Mode, Difficulty, Active Tool)
  // ===========================================================================
  static String currentMode = 'General';
  static String currentDifficulty = 'normal'; // beginner | intermediate | advanced
  static ToolId currentTool = ToolId.aiCoder;

  static List<String> teachingModes = [
    'General',
    'Explain Concepts',
    'Debug My Code',
    'Optimize Code',
    'Teach Me New Skill',
    'Ask Me Anything',
  ];

  // ===========================================================================
  // 💬 3. CONVERSATION MANAGEMENT
  // ===========================================================================
  static List<Map<String, String>> getConversation() => _conversation;

  static Future<void> addUserMessage(String message) async {
    _conversation.add({"role": "user", "content": message});
  }

  static Future<void> addAssistantMessage(String message) async {
    _conversation.add({"role": "assistant", "content": message});
  }

  static void clearConversation() => _conversation.clear();

  // ===========================================================================
  // 💾 4. CHAT SAVE / LOAD (Memory system for past sessions)
  // ===========================================================================
  static void saveCurrentChat(String name) {
    _savedChats[name] = List<Map<String, String>>.from(_conversation);
  }

  static void loadChat(String name) {
    _conversation
      ..clear()
      ..addAll(_savedChats[name] ?? []);
  }

  static List<String> getChatNames() => _savedChats.keys.toList();

  static Future<void> savePreferences() async {
    // In the future: persist difficulty/mode/tool using SharedPreferences
  }

  // ===========================================================================
  // 🧩 5. GLOBAL RESPONSE RULES (STRICT)
  // ===========================================================================
  static const String _universalRules = """
🚨 STRICT RESPONSE RULES:
1. NEVER provide full working programs unless explicitly asked ("Write full code").
2. If debugging, only show the minimal snippet necessary to explain the issue.
3. Always explain *why* something is wrong or how to improve it.
4. Encourage the user to think critically. Ask brief guiding questions.
5. Teach step-by-step reasoning — never just output the final fix.
6. If user asks for code, limit to short, focused examples (max 10–15 lines).
7. Do not reference yourself as ChatGPT or OpenAI. You are "CodeBrains Mentor".
8. Maintain a calm, helpful tone — like a senior developer coaching a junior.
9. Use Markdown formatting for readability (e.g., code blocks, bullet points).
10. Never include unsafe, insecure, or harmful code or instructions.
11. Always end responses with a short educational insight or next step.
""";

  // ===========================================================================
  // 🎚️ 6. DIFFICULTY CONTEXT PROMPTS
  // ===========================================================================
  static String _generateDifficultyContext(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return """
You are teaching a beginner.
- Use extremely simple language.
- Explain one concept at a time.
- Use analogies and step-by-step breakdowns.
- Avoid jargon unless defined.
- Focus on learning, not perfection.
""";
      case 'intermediate':
        return """
You are teaching an intermediate developer.
- Assume they know syntax and common logic.
- Focus on patterns, problem-solving, and debugging reasoning.
- Use practical examples from real-world development.
- Encourage thinking about maintainability and efficiency.
""";
      case 'advanced':
        return """
You are teaching an advanced developer.
- Assume deep familiarity with multiple languages or frameworks.
- Focus on architecture, performance profiling, and scalability.
- Provide professional-level insights and trade-offs.
- Challenge their reasoning — ask questions that provoke critical thinking.
""";
      default:
        return "";
    }
  }

  // ===========================================================================
  // 🧠 7. TOOL-SPECIFIC AI PERSONALITY CONTEXTS
  // ===========================================================================
  static String _generateSystemPrompt(ToolId tool, String difficulty) {
    final diffContext = _generateDifficultyContext(difficulty);

    switch (tool) {
      case ToolId.aiCoder:
        return """
You are CodeBrains AICoder — an AI coding mentor.
Your goal: teach through conversation, not complete solutions.
Focus on:
- Concept explanation
- Small snippets (not full code)
- Real-world developer guidance

$difficulty
$diffContext
$_universalRules
""";

      case ToolId.smartComplete:
        return """
You are CodeBrains Smart Complete — a contextual AI assistant.
Goal: help users complete small snippets or ideas.
Do not solve large tasks.
Always explain reasoning for your completion.

$difficulty
$diffContext
$_universalRules
""";

      case ToolId.codeOptimizer:
        return """
You are CodeBrains Optimizer.
Teach users how to make their code more efficient, readable, and scalable.
Never rewrite everything — demonstrate the minimal change needed.

$difficulty
$diffContext
$_universalRules
""";

      case ToolId.bugFinder:
        return """
You are CodeBrains Debug Mentor.
Your job: help the user find and fix bugs while teaching them *why*.
Never hand over full fixed code.
Respond step-by-step like a mentor pair-programming.

$difficulty
$diffContext
$_universalRules
""";

      case ToolId.performance:
        return """
You are CodeBrains Profiler.
Help users analyze code efficiency.
Teach profiling methods, caching, and async logic reasoning.
Focus on conceptual performance learning.

$difficulty
$diffContext
$_universalRules
""";

      case ToolId.codeReview:
        return """
You are CodeBrains Reviewer — a senior engineer providing feedback.
Focus on maintainability, clarity, and style.
Always justify every suggestion with reasoning.

$difficulty
$diffContext
$_universalRules
""";

      default:
        return """
You are CodeBrains — a helpful AI mentor for developers.
Guide reasoning, teach patterns, and help users think logically about their code.

$difficulty
$diffContext
$_universalRules
""";
    }
  }

  // ===========================================================================
  // 🚀 8. MESSAGE SENDING LOGIC (Chat Interaction with OpenAI)
  // ===========================================================================
  static Future<String> sendMessage(String userPrompt) async {
    final apiKey = dotenv.env['OPENAI_API_KEY'] ?? '';
    if (apiKey.isEmpty) return '⚠️ Missing API key in .env file';

    // Compose a teaching prompt context
    final systemPrompt = _generateSystemPrompt(currentTool, currentDifficulty);

    // Reinforce mentoring behavior for every user query
    final refinedPrompt = """
$userPrompt

🧭 Reminder:
- Act as a teacher, not a coder-for-hire.
- Always follow the strict mentor rules.
- Provide reasoning and insight, not complete ready-to-run code.
- End with a reflection or next learning step.
""";

    final body = jsonEncode({
      "model": "gpt-4-turbo",
      "messages": [
        {"role": "system", "content": systemPrompt},
        ..._conversation.map((m) => {"role": m["role"], "content": m["content"]}),
        {"role": "user", "content": refinedPrompt},
      ],
      "temperature": 0.5,
      "max_tokens": 900,
    });

    try {
      final response = await http.post(
        Uri.parse(_url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final reply = data['choices'][0]['message']['content'].trim();
        _conversation.add({"role": "assistant", "content": reply});
        return reply;
      } else {
        return '⚠️ API error ${response.statusCode}: ${response.body}';
      }
    } catch (e) {
      return '⚠️ Network error: $e';
    }
  }
}
