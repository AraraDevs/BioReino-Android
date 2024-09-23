import 'dart:convert';

import 'package:bcrypt/bcrypt.dart';
import 'package:bioreino_mobile/controller/dio/dio_client.dart';
import 'package:bioreino_mobile/model/course.dart';
import 'package:bioreino_mobile/model/lesson.dart';
import 'package:bioreino_mobile/model/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class StudentDAO {
  static Student? student;
  static const studentKey = 'student';

  static String _getEndpoint([String? endpoint]) => "user/${endpoint ?? ''}";

  static Future<LoginState> login(
    BuildContext context,
    String email,
    String password,
  ) async {
    final dioClient = DioClient();
    final response = await dioClient.post(
      _getEndpoint('login'),
      {
        'email': email,
        'password': password,
      },
    );

    if (response == null) return LoginState.error;
    if (response.statusCode != 200) {
      if (response.statusCode == 422) {
        return LoginState.wrongCredentials;
      }
      return LoginState.error;
    }

    final data = response.data;
    final token = data['token'];
    final id = data['userId'];

    final studentResponse = await dioClient.get(
      _getEndpoint(),
      token: token,
    );

    if (studentResponse == null) return LoginState.error;
    if (studentResponse.statusCode != 200) {
      if (studentResponse.statusCode == 422) {
        return LoginState.wrongCredentials;
      }
      return LoginState.error;
    }

    final studentData = studentResponse.data;
    student = Student(
      id: id,
      token: token,
      name: studentData['name'],
      plan: studentData['plan'],
      createdAt: DateTime.parse(studentData['createdAt']),
      email: studentData['email'],
      password: password,
      coursesProgress: studentData['coursesProgress'],
      lastCourse: studentData['lastCourse'],
    );
    _storeStudentPrefs(password);
    return LoginState.logged;
  }

  static bool _checkPassword(String password, String hashedPassword) {
    return BCrypt.checkpw(password, hashedPassword);
  }

  static Future<void> _storeStudentPrefs(String password) async {
    if (StudentDAO.student != null) {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();
      StudentDAO.student!.password = password;

      preferences.setString(
        StudentDAO.studentKey,
        jsonEncode(StudentDAO.student?.toMap()),
      );
    }
  }

  static Future<void> logout(BuildContext context) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    await Future.delayed(const Duration(seconds: 1));
    preferences.clear();
    student = null;
    await DefaultCacheManager().emptyCache();
  }

  static Map<String, dynamic> defineQuery() {
    // TODO: Implement defineQuery
    return throw UnimplementedError();
  }

  static Future<void> updateLastCourse(Course course, Lesson? lesson) async {
    final dioClient = DioClient();
    await dioClient.patch(
      _getEndpoint('lastcourse'),
      {
        "courseTitle": course.name,
        "slug": course.slug,
        "professor": course.professor,
        "imageUrl": course.imageUrl,
        "lessonTitle": lesson?.title ?? course.lessons[0].title,
        "lessonDescription":
            lesson?.description ?? course.lessons[0].description,
        "slugLesson": lesson?.slug ?? course.lessons[0].slug,
      },
    );
  }

  static Future<void> updateProgress(Course course, {Lesson? lesson}) async {
    final dioClient = DioClient();
    await dioClient.patch(
      _getEndpoint('courseprogress'),
      {
        "courseData": course.toMap(),
        "lessonData": lesson?.toMap() ?? course.lessons[0].toMap(),
      },
      logId: course.slug,
    );
  }
}

class WrongCredentialsException implements Exception {}

enum LoginState { logged, wrongCredentials, error }
