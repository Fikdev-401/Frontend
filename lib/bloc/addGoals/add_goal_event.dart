part of 'add_goal_bloc.dart';

@immutable
sealed class AddGoalEvent{}

final class AddGoal extends AddGoalEvent {
  final AddGoalRequestModel requestBody;
  AddGoal({required this.requestBody});
}