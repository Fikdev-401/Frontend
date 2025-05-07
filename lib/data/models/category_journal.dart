
import 'dart:convert';


class DataCategoryJournal {
  final List<CategoryJournal> data;

  DataCategoryJournal({required this.data});

  factory DataCategoryJournal.fromJson(Map<String, dynamic> json) => DataCategoryJournal(
    data: List<CategoryJournal>.from(json["data"].map((x) => CategoryJournal.fromJson(x))),
  );
}

CategoryJournal categoryJournalFromJson(String str) => CategoryJournal.fromJson(json.decode(str));

String categoryJournalToJson(CategoryJournal data) => json.encode(data.toJson());

class CategoryJournal {
    final int id;
    final String title;
    final DateTime createdAt;
    final DateTime updatedAt;

    CategoryJournal({
        required this.id,
        required this.title,
        required this.createdAt,
        required this.updatedAt,
    });

    factory CategoryJournal.fromJson(Map<String, dynamic> json) => CategoryJournal(
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
