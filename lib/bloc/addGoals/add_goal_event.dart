part of 'add_goal_bloc.dart';

@immutable
sealed class AddGoalEvent{}

final class AddGoal extends AddGoalEvent {
  final AddGoalRequestModel requestBody;
  AddGoal(this.requestBody);
}

class EditGoal extends AddGoalEvent {
  final AddGoalRequestModel requestBody;
  final int id;
  EditGoal(this.requestBody, this.id);
}