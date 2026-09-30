import 'package:flutter/material.dart';

class AskAIScreen extends StatefulWidget {
  const AskAIScreen({super.key});

  @override
  State<AskAIScreen> createState() => _AskAIScreenState();
}

class _AskAIScreenState extends State<AskAIScreen> {
  final TextEditingController _questionController = TextEditingController();
  final List<Map<String, String>> _chatHistory = [];
  bool _isLoading = false;

  @override
  void dispose() {
    _questionController.dispose();
    super.dispose();
  }

  Future<void> _askQuestion() async {
    if (_questionController.text.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _chatHistory.add({
        'question': _questionController.text,
        'answer': 'Thinking...',
      });
    });

    // TODO: Implement actual AI integration
    await Future.delayed(const Duration(seconds: 2));
    
    setState(() {
      _isLoading = false;
      _chatHistory.last['answer'] = 'This is a placeholder response. AI integration will be implemented in the future.';
      _questionController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: _chatHistory.length,
            itemBuilder: (context, index) {
              final chat = _chatHistory[index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildQuestion(chat['question']!),
                  const SizedBox(height: 8),
                  _buildAnswer(chat['answer']!),
                  const SizedBox(height: 16),
                ],
              );
            },
          ),
        ),
        _buildInputArea(),
      ],
    );
  }

  Widget _buildQuestion(String question) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(question),
      ),
    );
  }

  Widget _buildAnswer(String answer) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(answer),
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _questionController,
              decoration: const InputDecoration(
                hintText: 'Ask a question about Assam...',
                border: OutlineInputBorder(),
              ),
              enabled: !_isLoading,
              onSubmitted: (_) => _askQuestion(),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: _isLoading ? null : _askQuestion,
            icon: _isLoading
                ? const CircularProgressIndicator()
                : const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
