import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/data/datasource/remote_datasource.dart';
import 'package:flutter_frontend/data/models/caregory_goals.dart';

part 'category_goal_event.dart';
part 'category_goal_state.dart';

class CategoryGoalBloc extends Bloc<CategoryGoalEvent, CategoryGoalState> {
  final RemoteDatasource remoteDatasource;
  CategoryGoalBloc({required this.remoteDatasource}) : super(CategoryGoalInitial()) {
    on<LoadCategoryGoal>((event, emit) async {
      emit(CategoryGoalLoading());
      try {
        final dataCategoryGoals = await remoteDatasource.getCategoryGoal();
        emit(CategoryGoalLoaded(dataCategoryGoals.data));
      } catch (e) {
        emit(CategoryGoalError(e.toString()));
      }
    });
  }
}
