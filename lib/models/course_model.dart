import 'package:json_annotation/json_annotation.dart';
part 'course_model.g.dart';

@JsonSerializable()

//COURSES
class Course {
  final String? description;
  final String? imageUrl;
  final List<Lesson> lessons;
  final String? title;

  Course({
    required this.description,
    required this.imageUrl,
    required this.lessons,
    required this.title,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return _$CourseFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$CourseToJson(this);
  }
}

//****************************************************************************************************

@JsonSerializable()
//LESSONS
class Lesson {
  final String courseId;
  final String description;
  final List<Quiz> quizes;
  final String? videoUrl;

  Lesson({
    required this.courseId,
    required this.description,
    required this.quizes,
    required this.videoUrl,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return _$LessonFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LessonToJson(this);
  }
}

//*****************************************************************************************************

@JsonSerializable()
//QUIZ
class Quiz {
  final int correct;
  final List<Options> options;
  final String? question;

  Quiz({
    required this.correct,
    required this.options,
    required this.question,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return _$QuizFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$QuizToJson(this);
  }
}

//********************************************************************************************************

@JsonSerializable()

//OPTIONS
class Options {
  final String? answer1;
  final String? answer2;
  final String? answer3;

  Options({
    required this.answer1,
    required this.answer2,
    required this.answer3,
  });

  factory Options.fromJson(Map<String, dynamic> json) {
    return _$OptionsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OptionsToJson(this);
  }
}
