class DataJournals {
  final List<Journal> data;

  DataJournals({required this.data});

  factory DataJournals.fromJson(Map<String, dynamic> json) {
    return DataJournals(
      data: List<Journal>.from(json["data"].map((x) => Journal.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
  }
}

class Journal {
  final int id;
  final int userId;
  final int categoryJournalId;
  final String title;
  final String desc;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CategoryJournal category;

  Journal({
    required this.id,
    required this.userId,
    required this.categoryJournalId,
    required this.title,
    required this.desc,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
  });

  factory Journal.fromJson(Map<String, dynamic> json) {
    return Journal(
      id: json["id"],
      userId: json["user_id"],
      categoryJournalId: json["category_journal_id"],
      title: json["title"],
      desc: json["desc"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
      category: CategoryJournal.fromJson(json["category"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "category_journal_id": categoryJournalId,
      "title": title,
      "desc": desc,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
      "category": category.toJson(),
    };
  }
}

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

  factory CategoryJournal.fromJson(Map<String, dynamic> json) {
    return CategoryJournal(
      id: json["id"],
      title: json["title"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };
  }
}
