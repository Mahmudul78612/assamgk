import 'package:json_annotation/json_annotation.dart';

part 'chapter.g.dart';

@JsonSerializable()
class Chapter {
  final String chapterId;
  final String title;
  final List<Topic> topics;

  Chapter({
    required this.chapterId,
    required this.title,
    required this.topics,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => _$ChapterFromJson(json);
  Map<String, dynamic> toJson() => _$ChapterToJson(this);
}

@JsonSerializable()
class Topic {
  final String id;
  final String title;
  final String summary;
  final List<MCQ> mcqs;

  Topic({
    required this.id,
    required this.title,
    required this.summary,
    required this.mcqs,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);
  Map<String, dynamic> toJson() => _$TopicToJson(this);
}

@JsonSerializable()
class MCQ {
  final String id;
  final String question;
  final List<String> options;
  final String answer;

  MCQ({
    required this.id,
    required this.question,
    required this.options,
    required this.answer,
  });

  factory MCQ.fromJson(Map<String, dynamic> json) => _$MCQFromJson(json);
  Map<String, dynamic> toJson() => _$MCQToJson(this);
}
