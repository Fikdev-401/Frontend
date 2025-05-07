class AddJournalResponseModel {
  final String title;
  final String desc;

  AddJournalResponseModel({
    required this.title,
    required this.desc,
  });

  factory AddJournalResponseModel.fromJson(Map<String, dynamic> json) {
    return AddJournalResponseModel(
      title: json['title'] ?? '',
      desc: json['desc'] ?? '',
    );
  }
}
