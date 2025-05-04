
import 'dart:convert';


class DataCategoryGoals {
  final List<CategoryGoals> data;

  DataCategoryGoals({required this.data});

  factory DataCategoryGoals.fromJson(Map<String, dynamic> json) => DataCategoryGoals(
    data: List<CategoryGoals>.from(json["data"].map((x) => CategoryGoals.fromJson(x))),
  );
}

CategoryGoals categoryGoalsFromJson(String str) => CategoryGoals.fromJson(json.decode(str));

String categoryGoalsToJson(CategoryGoals data) => json.encode(data.toJson());

class CategoryGoals {
    final int id;
    final String title;
    final DateTime createdAt;
    final DateTime updatedAt;

    CategoryGoals({
        required this.id,
        required this.title,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CategoryGoals.fromJson(Map<String, dynamic> json) => CategoryGoals(
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
