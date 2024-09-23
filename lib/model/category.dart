class Category {
  final String name;
  final String? plan;
  final String id;
  final String value;

  Category(Map<String, dynamic> map)
      : name = map["name"],
        plan = map["plan"],
        id = map["_id"],
        value = map["value"];

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "plan": plan,
      "_id": id,
      "value": value,
    };
  }
}
