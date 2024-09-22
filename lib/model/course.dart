import 'package:bioreino_mobile/controller/dio/dao/categories_dao.dart';
import 'package:bioreino_mobile/model/category.dart';
import 'package:bioreino_mobile/model/lesson.dart';

class Course {
  final String name;
  final String professor;
  final String imageUrl;
  final String plan;
  final Category category;
  final List<Lesson> lessons;

  factory Course.fromMap(Map<String, dynamic> map) {
    Category getCategory(String name) {
      for (var category in CategoriesDAO.categories) {
        if (category.name == name) return category;
      }
      return Category({"plan": "scholar", "name": ""});
    }

    final lessons =
        map["lessons"].map<Lesson>((lesson) => Lesson(lesson)).toList();

    final category = getCategory(map["category"]["name"]);
    return Course(
      name: map["title"],
      professor: map["professor"],
      imageUrl: map["imageUrl"],
      plan: category.plan,
      category: category,
      lessons: lessons,
    );
  }

  Course({
    required this.name,
    required this.professor,
    required this.imageUrl,
    required this.plan,
    required this.category,
    required this.lessons,
  });
}
