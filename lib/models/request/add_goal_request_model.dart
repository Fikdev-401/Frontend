class AddGoalRequestModel {
  final String title;
  final String desc;
  final String status;
  final int? categoryGoalId; // sesuai nama kolom di tabel

  AddGoalRequestModel({
    required this.title,
    required this.desc,
    required this.status,
    required this.categoryGoalId,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'desc': desc,
    'status': status,
    'category_goal_id': categoryGoalId, // <-- key harus sama dengan di backend
  };
}
