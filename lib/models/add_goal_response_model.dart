class AddGoalResponseModel {
  final String title;
  final String desc;

  AddGoalResponseModel({
    required this.title,
    required this.desc,
  });

  factory AddGoalResponseModel.fromJson(Map<String, dynamic> json) {
    return AddGoalResponseModel(
      title: json['title'] ?? '',
      desc: json['desc'] ?? '',
    );
  }
}
