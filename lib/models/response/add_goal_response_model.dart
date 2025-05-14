class AddGoalResponseModel {
  final String title;
  final String desc;
  final String status;

  AddGoalResponseModel({
    required this.title,
    required this.desc,
    required this.status,
  });

  factory AddGoalResponseModel.fromJson(Map<String, dynamic> json) {
    return AddGoalResponseModel(
      title: json['title'] ?? '',
      desc: json['desc'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
