import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course_model.dart';

class CourseService {
  final String url =
      'https://todo-app-3fb9c-default-rtdb.firebaseio.com/courses.json';

  Future<Course> fetchCourse() async {
    final response = await http.get(Uri.parse(url));

    final map = jsonDecode(response.body);
    map.forEach((key, value){
      print("$key $value");
    });

    if (response.statusCode == 200) {
      return Course.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Ma'lumot olishda xatolik bor");
    }
  }
}
