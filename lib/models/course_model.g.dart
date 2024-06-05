// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      lessons: (json['lessons'] as List<dynamic>)
          .map((e) => Lesson.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String?,
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'lessons': instance.lessons,
      'title': instance.title,
    };

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      courseId: json['courseId'] as String,
      description: json['description'] as String,
      quizes: (json['quizes'] as List<dynamic>)
          .map((e) => Quiz.fromJson(e as Map<String, dynamic>))
          .toList(),
      videoUrl: json['videoUrl'] as String?,
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'courseId': instance.courseId,
      'description': instance.description,
      'quizes': instance.quizes,
      'videoUrl': instance.videoUrl,
    };

Quiz _$QuizFromJson(Map<String, dynamic> json) => Quiz(
      correct: (json['correct'] as num).toInt(),
      options: (json['options'] as List<dynamic>)
          .map((e) => Options.fromJson(e as Map<String, dynamic>))
          .toList(),
      question: json['question'] as String?,
    );

Map<String, dynamic> _$QuizToJson(Quiz instance) => <String, dynamic>{
      'correct': instance.correct,
      'options': instance.options,
      'question': instance.question,
    };

Options _$OptionsFromJson(Map<String, dynamic> json) => Options(
      answer1: json['answer1'] as String?,
      answer2: json['answer2'] as String?,
      answer3: json['answer3'] as String?,
    );

Map<String, dynamic> _$OptionsToJson(Options instance) => <String, dynamic>{
      'answer1': instance.answer1,
      'answer2': instance.answer2,
      'answer3': instance.answer3,
    };
