part of 'category_goal_bloc.dart';

@immutable
sealed class CategoryGoalEvent {}

final class LoadCategoryGoal extends CategoryGoalEvent {}