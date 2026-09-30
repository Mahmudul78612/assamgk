// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chapter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter(
      chapterId: json['chapterId'] as String,
      title: json['title'] as String,
      topics: (json['topics'] as List<dynamic>)
          .map((e) => Topic.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'chapterId': instance.chapterId,
      'title': instance.title,
      'topics': instance.topics,
    };

Topic _$TopicFromJson(Map<String, dynamic> json) => Topic(
      id: json['id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String,
      mcqs: (json['mcqs'] as List<dynamic>)
          .map((e) => MCQ.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'summary': instance.summary,
      'mcqs': instance.mcqs,
    };

MCQ _$MCQFromJson(Map<String, dynamic> json) => MCQ(
      id: json['id'] as String,
      question: json['question'] as String,
      options:
          (json['options'] as List<dynamic>).map((e) => e as String).toList(),
      answer: json['answer'] as String,
    );

Map<String, dynamic> _$MCQToJson(MCQ instance) => <String, dynamic>{
      'id': instance.id,
      'question': instance.question,
      'options': instance.options,
      'answer': instance.answer,
    };
