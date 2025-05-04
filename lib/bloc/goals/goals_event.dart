part of 'goals_bloc.dart';

@immutable
sealed class GoalsEvent  {}

final class LoadGoals extends GoalsEvent {
  final int userId;
  LoadGoals({required this.userId});
}