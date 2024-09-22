import 'package:bioreino_mobile/controller/dio/dio_client.dart';
import 'package:bioreino_mobile/model/course.dart';
import 'package:flutter/material.dart';

class CoursesDAO {
  static List<Course> coursesList = [];

  static String _getEndpoint([String? endpoint]) => "course/${endpoint ?? ''}";

  static Future<List<Course>> getAll(BuildContext context) async {
    final response = await DioClient().get(_getEndpoint());
    if (response == null) return [];
    if (response.statusCode != 200) return [];

    final data = response.data;

    coursesList = data.map<Course>((course) => Course.fromMap(course)).toList();
    return coursesList;
  }
}
