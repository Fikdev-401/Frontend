import 'dart:convert';

Goals goalsFromJson(String str) => Goals.fromJson(json.decode(str));

String goalsToJson(Goals data) => json.encode(data.toJson());

class DataGoals{
  final List<Goals> data;
  DataGoals({
    required this.data,
  });

  factory DataGoals.fromJson(Map<String, dynamic> json) => DataGoals(
    data: List<Goals>.from(json["data"].map((x) => Goals.fromJson(x))),
  );
}

class Goals {
    final int id;
    final int userId;
    final String title;
    final String description;
    final int completed;
    final DateTime createdAt;
    final DateTime updatedAt;

    Goals({
        required this.id,
        required this.userId,
        required this.title,
        required this.description,
        required this.completed,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Goals.fromJson(Map<String, dynamic> json) => Goals(
        id: json["id"],
        userId: json["user_id"],
        title: json["title"],
        description: json["description"],
        completed: json["completed"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "description": description,
        "completed": completed,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
