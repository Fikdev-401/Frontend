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
