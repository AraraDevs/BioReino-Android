class Lesson {
  String title;
  String description;
  String videoUrl;
  String transcription;
  String id;
  String slug;

  Lesson(Map<String, dynamic> map)
      : title = map["title"],
        description = map["description"],
        videoUrl = map["videoUrl"],
        transcription = map["transcription"],
        id = map["_id"],
        slug = map["slug"];
}
