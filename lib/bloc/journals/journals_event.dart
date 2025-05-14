part of 'journals_bloc.dart';

@immutable
sealed class JournalsEvent  {}

final class LoadJournals extends JournalsEvent {
  final int userId;
  LoadJournals({required this.userId});
}

final class DeleteJournal extends JournalsEvent {
  final int id;
  DeleteJournal({required this.id});
}


