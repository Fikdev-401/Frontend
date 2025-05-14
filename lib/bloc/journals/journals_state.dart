part of 'journals_bloc.dart';

@immutable
sealed class JournalsState {} 

final class JournalsInitial extends JournalsState {}

final class JournalsLoading extends JournalsState {}

final class JournalsLoaded extends JournalsState {
  final List<Journal> journals;
  JournalsLoaded({required this.journals});
}

final class JournalsError extends JournalsState {
  final String message;
  JournalsError({required this.message});
}


final class DeleteJournalInitial extends JournalsState {}

final class DeleteJournalLoading extends JournalsState {}

final class DeleteJournalSuccess extends JournalsState {}

final class DeleteJournalError extends JournalsState {
  final String message;
  DeleteJournalError({required this.message});
}