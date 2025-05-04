part of 'category_goal_bloc.dart';

@immutable
sealed class CategoryGoalState {}

final class CategoryGoalInitial extends CategoryGoalState {}

final class CategoryGoalLoading extends CategoryGoalState {}

final class CategoryGoalLoaded extends CategoryGoalState {
  final List<CategoryGoals> dataCategoryGoals;
  CategoryGoalLoaded(this.dataCategoryGoals);
}

final class CategoryGoalError extends CategoryGoalState {
  final String message;
  CategoryGoalError (this.message);
}
