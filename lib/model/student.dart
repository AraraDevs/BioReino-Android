import 'package:bioreino_mobile/controller/dio/dao/student_dao.dart';
import 'package:bioreino_mobile/model/course.dart';
import 'package:bioreino_mobile/model/lesson.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Student {
  final String? id;
  final String token;
  final String name;
  final String plan;
  final DateTime createdAt;
  final String email;
  String? password;
  List<dynamic>? coursesProgress;
  Map<String, dynamic>? lastCourse;

  Student({
    this.id,
    required this.token,
    required this.name,
    required this.plan,
    required this.createdAt,
    required this.email,
    this.password,
    this.coursesProgress,
    this.lastCourse,
  });

  static Future<Student> fromMap(Map<String, dynamic> map) async {
    return Student(
      id: map["_id"],
      token: map["token"],
      name: map["name"],
      plan: map["plan"],
      createdAt: map["createdAt"],
      email: map["email"],
      password: map["password"],
      coursesProgress: map["coursesProgress"],
      lastCourse: map["lastCourse"],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "_id": id,
      "token": token,
      "name": name,
      "plan": plan,
      "createdAt": createdAt.millisecondsSinceEpoch,
      "email": email,
      "password": password,
      "coursesProgress": coursesProgress,
      "lastCourse": lastCourse,
    };
  }

  double getProgress(Course course) {
    for (var progressMap in coursesProgress!) {
      if (progressMap["title"] == course.name) {
        return (progressMap["progress"]).toDouble();
      }
    }
    return 0.0;
  }

  bool isLessonComplete(String courseName, String id) {
    for (var progressMap in coursesProgress!) {
      if (progressMap["title"] == courseName) {
        for (var lessonId in progressMap["lessonsViewed"]) {
          if (lessonId == id) return true;
        }
      }
    }
    return false;
  }

  void addProgress(Course course, {Lesson? lesson}) {
    StudentDAO.updateProgress(course, lesson: lesson);
  }

  void addLastCourse(Course course, {Lesson? lesson}) {
    StudentDAO.updateLastCourse(course, lesson);
  }
}
