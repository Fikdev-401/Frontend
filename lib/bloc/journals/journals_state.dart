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

