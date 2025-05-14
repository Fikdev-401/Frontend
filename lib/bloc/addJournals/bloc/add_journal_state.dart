part of 'add_journal_bloc.dart';

@immutable
sealed class AddJournalState {}

final class AddJournalInitial extends AddJournalState {}

final class AddJournalLoading extends AddJournalState {}

final class AddJournalLoaded extends AddJournalState {
  final AddJournalResponseModel journalData;
  AddJournalLoaded(this.journalData);
}


final class AddJournalError extends AddJournalState {
  final String message;
  AddJournalError(this.message);
}


final class EditJournalLoaded extends AddJournalState {
  final AddJournalResponseModel journalData;
  EditJournalLoaded(this.journalData);
}

final class EditJournalLoading extends AddJournalState {}

final class EditJournalError extends AddJournalState {
  final String message;
  EditJournalError(this.message);
}