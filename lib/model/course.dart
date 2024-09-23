import 'package:bioreino_mobile/model/category.dart';
import 'package:bioreino_mobile/model/lesson.dart';

class Course {
  final String name;
  final String professor;
  final String imageUrl;
  final String plan;
  final Category category;
  final String slug;
  final List<Lesson> lessons;

  factory Course.fromMap(Map<String, dynamic> map) {
    final lessons =
        map["lessons"].map<Lesson>((lesson) => Lesson(lesson)).toList();

    final category = Category(map["category"]);
    return Course(
      name: map["title"],
      professor: map["professor"],
      imageUrl: map["imageUrl"],
      slug: map["slug"],
      plan: category.plan ?? "scholar",
      category: category,
      lessons: lessons,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "professor": professor,
      "imageUrl": imageUrl,
      "plan": plan,
      "slug": slug,
      "category": category.toMap(),
      "lessons": lessons.map((lesson) => lesson.toMap()).toList(),
    };
  }

  Course({
    required this.name,
    required this.professor,
    required this.imageUrl,
    required this.plan,
    required this.slug,
    required this.category,
    required this.lessons,
  });
}
