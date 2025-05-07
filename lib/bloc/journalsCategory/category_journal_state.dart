part of 'category_journal_bloc.dart';

@immutable
sealed class CategoryJournalState {}

final class CategoryJournalInitial extends CategoryJournalState {}

final class CategoryJournalLoading extends CategoryJournalState {}

final class CategoryJournalLoaded extends CategoryJournalState {
  final List<CategoryJournal> categoryJournal;
  CategoryJournalLoaded(this.categoryJournal);
}

final class CategoryJournalError extends CategoryJournalState {
  final String message;
  CategoryJournalError(this.message);
}


