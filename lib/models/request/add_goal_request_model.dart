class AddGoalRequestModel {
  final String title;
  final String desc;
  final int categoryGoalId; // sesuai nama kolom di tabel

  AddGoalRequestModel({
    required this.title,
    required this.desc,
    required this.categoryGoalId,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'desc': desc,
    'category_goal_id': categoryGoalId, // <-- key harus sama dengan di backend
  };
}
