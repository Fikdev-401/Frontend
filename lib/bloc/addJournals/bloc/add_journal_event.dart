part of 'add_journal_bloc.dart';

@immutable
sealed class AddJournalEvent {}

class AddJournal extends AddJournalEvent {
  final AddJournalRequestModel requestBody;
  AddJournal(this.requestBody);
}

class EditJournal extends AddJournalEvent {
  final AddJournalRequestModel requestBody;
  final int id;
  EditJournal(this.requestBody, this.id);
}
