part of 'add_goal_bloc.dart';

@immutable
sealed class AddGoalState {}

final class AddGoalInitial extends AddGoalState {}

final class AddGoalLoading extends AddGoalState {}

final class AddGoalSuccess extends AddGoalState {
  final AddGoalResponseModel goalData;
  AddGoalSuccess(this.goalData);
}

final class AddGoalError extends AddGoalState {
  final String message;
  AddGoalError(this.message);
}

final class EditGoalLoaded extends AddGoalState {
  final AddGoalResponseModel goalData;
  EditGoalLoaded(this.goalData);
}

final class EditGoalLoading extends AddGoalState {}

final class EditGoalError extends AddGoalState {
  final String message;
  EditGoalError(this.message);
}