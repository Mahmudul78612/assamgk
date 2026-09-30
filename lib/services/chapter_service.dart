import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/chapter.dart';

class ChapterService {
  Future<Chapter> loadChapter(String chapterId) async {
    try {
      final String jsonString = await rootBundle.loadString('assets/json/chapter$chapterId.json');
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      return Chapter.fromJson(jsonMap);
    } catch (e) {
      throw Exception('Failed to load chapter $chapterId: $e');
    }
  }

  Future<List<Chapter>> loadAllChapters() async {
    List<Chapter> chapters = [];
    for (int i = 1; i <= 20; i++) {
      try {
        chapters.add(await loadChapter(i.toString()));
      } catch (e) {
        print('Error loading chapter $i: $e');
      }
    }
    return chapters;
  }
}
