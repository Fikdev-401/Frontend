part of 'category_journal_bloc.dart';

@immutable
sealed class CategoryJournalEvent {}

final class LoadCategoryJournal extends CategoryJournalEvent {}