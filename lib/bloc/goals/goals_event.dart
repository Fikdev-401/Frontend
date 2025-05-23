part of 'goals_bloc.dart';

@immutable
sealed class GoalsEvent  {}

final class LoadGoals extends GoalsEvent {
  final int userId;
  LoadGoals({required this.userId});
}

final class DeleteGoal extends GoalsEvent {
  final int id;
  DeleteGoal({required this.id});
}
