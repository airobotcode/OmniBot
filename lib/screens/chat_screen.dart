import "package:flutter/material.dart";
import "../models/chat_message.dart";
import "../services/llm_provider.dart";

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<ChatMessage> _messages = [];
  final TextEditingController _textController = TextEditingController();
  
  String _selectedProvider = "Gemini";
  String _selectedModel = "gemini-1.5-pro";

  final Map<String, List<String>> _providerModels = {
    "Claude": ["claude-3-5-sonnet", "claude-3-haiku"],
    "Gemini": ["gemini-1.5-pro", "gemini-1.5-flash"],
    "OpenAI": ["gpt-4o", "gpt-4o-mini"],
  };

  void _handleSend() async {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    _textController.clear();
    final userMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: "user",
      text: text,
      modelName: _selectedModel,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(userMsg);
    });

    LLMProvider provider;
    if (_selectedProvider == "Claude") {
      provider = ClaudeProvider();
    } else if (_selectedProvider == "OpenAI") {
      provider = OpenAIProvider();
    } else {
      provider = GeminiProvider();
    }

    final response = await provider.sendMessage(
      apiKey: "",
      model: _selectedModel,
      messages: [{"role": "user", "content": text}],
    );

    final botMsg = ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      sender: "bot",
      text: response,
      modelName: _selectedModel,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.add(botMsg);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _selectedModel,
            items: (_providerModels[_selectedProvider] ?? []).map((m) {
              return DropdownMenuItem(
                value: m,
                child: Text("$_selectedProvider: $m", style: const TextStyle(fontSize: 14)),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) setState(() => _selectedModel = val);
            },
          ),
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (p) {
              setState(() {
                _selectedProvider = p;
                _selectedModel = _providerModels[p]!.first;
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "Gemini", child: Text("Gemini")),
              const PopupMenuItem(value: "Claude", child: Text("Claude")),
              const PopupMenuItem(value: "OpenAI", child: Text("OpenAI")),
            ],
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg.sender == "user";
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue[100] : Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAlignment.start,
                      children: [
                        Text(msg.text, style: const TextStyle(fontSize: 15)),
                        const SizedBox(height: 4),
                        Text(
                          "${msg.modelName} • ${msg.timestamp.hour}:${msg.timestamp.minute}",
                          style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            color: Theme.of(context).cardColor,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: "输入消息...",
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.horizontal(12),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: _handleSend,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
