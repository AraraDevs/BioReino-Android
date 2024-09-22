import 'package:bioreino_mobile/model/lesson.dart';
import 'package:flutter/widgets.dart';

class LessonsDAO {
  final String endpoint = "lessons"; 

  static Future<List<Lesson>> getAllFrom(
      String courseTitle, BuildContext context) async {
    return throw UnimplementedError();
  }

  static Future<List<Lesson>> _searchLessons(String courseTitle) async {
    return throw UnimplementedError();
  }

  static void _setLessonsToCourse(
    String courseTitle,
    List<Lesson> lessonsList,
  ) {}
}
