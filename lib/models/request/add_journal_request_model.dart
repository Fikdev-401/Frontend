class AddJournalRequestModel {
  final String title;
  final String desc;
  final int? categoryJournalId; // sesuai nama kolom di tabel

  AddJournalRequestModel({
    required this.title,
    required this.desc,
    required this.categoryJournalId,
  });

  get id => null;

  Map<String, dynamic> toJson() => {
    'title': title,
    'desc': desc,
    'category_journal_id': categoryJournalId, // <-- key harus sama dengan di backend
  };
}
