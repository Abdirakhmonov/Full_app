import 'package:flutter/material.dart';
import '../models/course_model.dart';
import '../services/course_service.dart';


class CourseProvider with ChangeNotifier {
  Course? course;
  bool isLoading = false;

  final CourseService courseService;

  CourseProvider(this.courseService);

  Future<void> loadCourse() async {
    isLoading = true;
    notifyListeners();
    try {
      course = await courseService.fetchCourse();
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
