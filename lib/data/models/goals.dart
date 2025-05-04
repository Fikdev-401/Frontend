import 'dart:convert';

class DataGoals {
  final List<Goals> data;

  DataGoals({required this.data});

  factory DataGoals.fromJson(Map<String, dynamic> json) => DataGoals(
    data: List<Goals>.from(json["data"].map((x) => Goals.fromJson(x))),
  );
}


// Enum untuk status
enum GoalStatus { belum, proses, selesai }

GoalStatus goalStatusFromString(String status) =>
    GoalStatus.values.firstWhere((e) => e.name == status);

String goalStatusToString(GoalStatus status) => status.name;

// Fungsi konversi dari dan ke JSON
Goals goalsFromJson(String str) => Goals.fromJson(json.decode(str));
String goalsToJson(Goals data) => json.encode(data.toJson());

// Model kategori
class GoalCategory {
  final int id;
  final String title;
  final DateTime createdAt;
  final DateTime updatedAt;

  GoalCategory({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
  });

  factory GoalCategory.fromJson(Map<String, dynamic> json) => GoalCategory(
        id: json["id"],
        title: json["title"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

// Model goal utama
class Goals {
  final int id;
  final int userId;
  final int categoryGoalId;
  final String title;
  final String desc;
  final GoalStatus status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final GoalCategory category;

  Goals({
    required this.id,
    required this.userId,
    required this.categoryGoalId,
    required this.title,
    required this.desc,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
  });

  factory Goals.fromJson(Map<String, dynamic> json) => Goals(
        id: json["id"],
        userId: json["user_id"],
        categoryGoalId: json["category_goal_id"],
        title: json["title"],
        desc: json["desc"],
        status: goalStatusFromString(json["status"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        category: GoalCategory.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "category_goal_id": categoryGoalId,
        "title": title,
        "desc": desc,
        "status": status.name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "category": category.toJson(),
      };
}
