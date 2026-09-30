import 'package:flutter/material.dart';
import '../models/chapter.dart';

class TopicScreen extends StatefulWidget {
  final Topic topic;

  const TopicScreen({super.key, required this.topic});

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  int _currentQuestionIndex = 0;
  Map<String, String?> _userAnswers = {};
  bool _showResults = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.topic.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSummarySection(),
          const SizedBox(height: 24),
          _buildQuizSection(),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Summary',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(widget.topic.summary),
          ],
        ),
      ),
    );
  }

  Widget _buildQuizSection() {
    if (widget.topic.mcqs.isEmpty) {
      return const SizedBox.shrink();
    }

    final currentQuestion = widget.topic.mcqs[_currentQuestionIndex];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Practice Questions',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Question ${_currentQuestionIndex + 1} of ${widget.topic.mcqs.length}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(currentQuestion.question),
            const SizedBox(height: 16),
            ...currentQuestion.options.map((option) => _buildOptionButton(option, currentQuestion)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentQuestionIndex > 0)
                  TextButton(
                    onPressed: _previousQuestion,
                    child: const Text('Previous'),
                  ),
                if (_currentQuestionIndex < widget.topic.mcqs.length - 1)
                  TextButton(
                    onPressed: _nextQuestion,
                    child: const Text('Next'),
                  ),
                if (_currentQuestionIndex == widget.topic.mcqs.length - 1 && !_showResults)
                  TextButton(
                    onPressed: _showQuizResults,
                    child: const Text('Show Results'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionButton(String option, MCQ question) {
    final isSelected = _userAnswers[question.id] == option;
    final isCorrect = _showResults && option == question.answer;
    final isWrong = _showResults && isSelected && option != question.answer;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ElevatedButton(
        onPressed: _showResults ? null : () => _selectAnswer(question.id, option),
        style: ElevatedButton.styleFrom(
          backgroundColor: isCorrect
              ? Colors.green.withOpacity(0.2)
              : isWrong
                  ? Colors.red.withOpacity(0.2)
                  : isSelected
                      ? Theme.of(context).colorScheme.primaryContainer
                      : null,
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(option),
        ),
      ),
    );
  }

  void _selectAnswer(String questionId, String answer) {
    setState(() {
      _userAnswers[questionId] = answer;
    });
  }

  void _previousQuestion() {
    if (_currentQuestionIndex > 0) {
      setState(() {
        _currentQuestionIndex--;
        _showResults = false;
      });
    }
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < widget.topic.mcqs.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _showResults = false;
      });
    }
  }

  void _showQuizResults() {
    setState(() {
      _showResults = true;
    });

    final totalQuestions = widget.topic.mcqs.length;
    final correctAnswers = widget.topic.mcqs
        .where((q) => _userAnswers[q.id] == q.answer)
        .length;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Results'),
        content: Text(
          'You got $correctAnswers out of $totalQuestions questions correct!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _currentQuestionIndex = 0;
                _showResults = false;
                _userAnswers.clear();
              });
            },
            child: const Text('Try Again'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
