part of 'goals_bloc.dart';

@immutable
sealed class GoalsState {}


final class GoalsInitial extends GoalsState {}

final class GoalsLoading extends GoalsState {}

final class GoalsLoaded extends GoalsState {
  final List<Goals> goals;
  GoalsLoaded(this.goals);
}

final class GoalsError extends GoalsState {
  final String message;
  GoalsError(this.message);
}

final class DeleteGoalInitial extends GoalsState {}

final class DeleteGoalLoading extends GoalsState {}

final class DeleteGoalSuccess extends GoalsState {}

final class DeleteGoalError extends GoalsState {
  final String message;
  DeleteGoalError(this.message);
}
