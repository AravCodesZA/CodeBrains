import 'package:flutter/material.dart';
import '../api_service.dart';
import '../widgets/message_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _scroll = ScrollController();
  final _input = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _scroll.dispose();
    _input.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final messages = ApiService.getConversation();

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              _buildModeBar(),
              Expanded(
                child: ListView.builder(
                  controller: _scroll,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: messages.length + (_sending ? 1 : 0),
                  itemBuilder: (context, i) {
                    if (_sending && i == messages.length) {
                      return _typingIndicator();
                    }
                    final m = messages[i];
                    final isUser = m["role"] == "user";
                    return MessageBubble(
                      text: m["content"] ?? "",
                      isUser: isUser,
                      time: DateTime.now(),
                    );
                  },
                ),
              ),
              _quickSuggestions(),
              _inputArea(),
            ],
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------
  // 🧠 HEADER SECTION
  // -------------------------------------------------
  Widget _buildHeader() {
    final activeTool = ApiService.currentTool.name.replaceAll('_', ' ').toUpperCase();
    final diff = ApiService.currentDifficulty;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.02),
        border: const Border(
          bottom: BorderSide(color: Color(0x1FFFFFFF)),
        ),
      ),
      child: Row(
        children: [
          _iconBtn(Icons.arrow_back_ios_new, onTap: () => Navigator.pop(context)),
          const SizedBox(width: 10),
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF667EEA), Color(0xFF764BA2)],
              ),
            ),
            child: const Center(
              child: Text("🧠", style: TextStyle(fontSize: 18)),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "CodeBrains • ${activeTool.replaceAll('_', ' ')}",
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Difficulty: ${diff[0].toUpperCase()}${diff.substring(1)}",
                  style:
                  const TextStyle(fontSize: 12, color: Color(0xFF4ECDC4)),
                ),
              ],
            ),
          ),
          _iconBtn(Icons.settings, onTap: _openSettingsPanel),
        ],
      ),
    );
  }

  Widget _iconBtn(IconData icon, {required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Icon(icon, size: 18, color: Colors.white),
      ),
    );
  }

  // -------------------------------------------------
  // 🧭 MODE SELECTOR BAR
  // -------------------------------------------------
  Widget _buildModeBar() {
    return Container(
      height: 44,
      margin: const EdgeInsets.only(top: 8, bottom: 4),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: ApiService.teachingModes.map((mode) {
          final isActive = ApiService.currentMode == mode;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(
                mode,
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
              ),
              selected: isActive,
              onSelected: (_) async {
                setState(() {
                  ApiService.currentMode = mode;
                });
                await ApiService.savePreferences();
              },
              selectedColor: const Color(0xFF667EEA),
              backgroundColor: Colors.white.withOpacity(0.08),
              shape: StadiumBorder(
                side: BorderSide(
                    color: isActive
                        ? const Color(0xFF667EEA)
                        : Colors.white.withOpacity(0.2)),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // -------------------------------------------------
  // 💬 MESSAGE SENDING SECTION
  // -------------------------------------------------
  Widget _inputArea() {
    final canSend = _input.text.trim().isNotEmpty && !_sending;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: _input,
              minLines: 1,
              maxLines: 5,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                hintText: 'Ask me anything about coding…',
                hintStyle: TextStyle(color: Colors.white54),
              ),
              onChanged: (_) => setState(() {}),
            ),
          ),
          const SizedBox(width: 8),
          FloatingActionButton.small(
            onPressed: canSend ? () => _send(_input.text) : null,
            backgroundColor:
            canSend ? const Color(0xFF667EEA) : Colors.white10,
            child: const Icon(Icons.north_east, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Future<void> _send(String text) async {
    if (text.trim().isEmpty) return;
    setState(() => _sending = true);
    await ApiService.addUserMessage(text.trim());
    _input.clear();
    _scrollToEndSoon();

    final reply = await ApiService.sendMessage(text.trim());
    setState(() => _sending = false);
    _scrollToEndSoon();
  }

  void _scrollToEndSoon() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scroll.hasClients) {
        _scroll.animateTo(
          _scroll.position.maxScrollExtent + 120,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // -------------------------------------------------
// ✨ QUICK SUGGESTION CHIPS (insert into input)
// -------------------------------------------------
  Widget _quickSuggestions() {
    final chips = [
      'Debug my code',
      'Optimize performance',
      'Add comments',
      'Explain this snippet',
      'Show me best practices',
      'Teach me step by step',
    ];

    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, i) {
          final text = chips[i];
          return ActionChip(
            label: Text(text),
            backgroundColor: Colors.white.withOpacity(0.08),
            shape: StadiumBorder(
              side: BorderSide(color: Colors.white.withOpacity(0.2)),
            ),
            onPressed: () {
              // Instead of sending, insert text into input box
              setState(() {
                if (_input.text.isEmpty) {
                  _input.text = text;
                } else {
                  // Add at cursor or append nicely
                  _input.text = "${_input.text.trim()} $text";
                }
                _input.selection = TextSelection.fromPosition(
                  TextPosition(offset: _input.text.length),
                );
              });
            },
          );
        },
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemCount: chips.length,
      ),
    );
  }

  // -------------------------------------------------
  // ⏳ TYPING INDICATOR
  // -------------------------------------------------
  Widget _typingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.07),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _dot(0),
            const SizedBox(width: 4),
            _dot(200),
            const SizedBox(width: 4),
            _dot(400),
          ],
        ),
      ),
    );
  }

  Widget _dot(int delay) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.3, end: 1),
      duration: const Duration(milliseconds: 900),
      curve: Curves.easeInOut,
      builder: (_, v, __) => Opacity(
        opacity: v,
        child:
        const CircleAvatar(radius: 3, backgroundColor: Color(0xFF667EEA)),
      ),
      onEnd: () => setState(() {}),
    );
  }

  // -------------------------------------------------
  // ⚙️ SETTINGS PANEL (Save / Load / Clear)
  // -------------------------------------------------
  void _openSettingsPanel() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF0F1626),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final nameCtrl = TextEditingController();
        final chats = ApiService.getChatNames();

        return Padding(
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("⚙️ Settings & Chats",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                const SizedBox(height: 12),

                // Save Chat
                TextField(
                  controller: nameCtrl,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: "Save chat as...",
                    labelStyle: const TextStyle(color: Colors.white70),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.save, color: Colors.white70),
                      onPressed: () {
                        if (nameCtrl.text.trim().isNotEmpty) {
                          ApiService.saveCurrentChat(nameCtrl.text.trim());
                          setState(() {});
                          Navigator.pop(context);
                        }
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white24),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF667EEA)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                const Text("📜 Saved Chats:",
                    style: TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 8),
                chats.isEmpty
                    ? const Text("No saved chats yet.",
                    style: TextStyle(color: Colors.white38))
                    : SizedBox(
                  height: 140,
                  child: ListView.builder(
                    itemCount: chats.length,
                    itemBuilder: (_, i) {
                      final name = chats[i];
                      return ListTile(
                        title: Text(name,
                            style:
                            const TextStyle(color: Colors.white)),
                        trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16,
                            color: Colors.white54),
                        onTap: () {
                          ApiService.loadChat(name);
                          Navigator.pop(context);
                          setState(() {});
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 12),

                ElevatedButton.icon(
                  onPressed: () async {
                    ApiService.clearConversation();
                    Navigator.pop(context);
                    setState(() {});
                  },
                  icon: const Icon(Icons.delete_forever),
                  label: const Text("Clear Current Chat"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF667EEA),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
