import 'package:flutter/material.dart';
import '../models/chapter.dart';
import '../services/chapter_service.dart';

class ChapterProvider extends ChangeNotifier {
  final ChapterService _chapterService = ChapterService();
  List<Chapter> _chapters = [];
  Chapter? _currentChapter;
  bool _isLoading = false;
  String? _error;

  List<Chapter> get chapters => _chapters;
  Chapter? get currentChapter => _currentChapter;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> loadChapters() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _chapters = await _chapterService.loadAllChapters();
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> setCurrentChapter(String chapterId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _currentChapter = await _chapterService.loadChapter(chapterId);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
