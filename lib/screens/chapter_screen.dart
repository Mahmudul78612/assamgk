import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/chapter_provider.dart';
import '../models/chapter.dart';

class ChapterScreen extends StatelessWidget {
  final String chapterId;

  const ChapterScreen({super.key, required this.chapterId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chapter Details'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Consumer<ChapterProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(provider.error!),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.setCurrentChapter(chapterId),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          final chapter = provider.currentChapter;
          if (chapter == null) {
            return const Center(child: Text('Chapter not found'));
          }

          return _buildChapterContent(context, chapter);
        },
      ),
    );
  }

  Widget _buildChapterContent(BuildContext context, Chapter chapter) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Text(
          chapter.title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        ...chapter.topics.map((topic) => _buildTopicCard(context, topic)).toList(),
      ],
    );
  }

  Widget _buildTopicCard(BuildContext context, Topic topic) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        title: Text(
          topic.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(topic.summary),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.pushNamed(
            context,
            '/topic',
            arguments: topic,
          );
        },
      ),
    );
  }
}
