import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/data/datasource/remote_datasource.dart';
import 'package:flutter_frontend/data/models/goals.dart';

part 'goals_event.dart';
part 'goals_state.dart';

class GoalsBloc extends Bloc<GoalsEvent, GoalsState> {
  final RemoteDatasource remoteDatasource;
  GoalsBloc({required this.remoteDatasource}) : super(GoalsInitial()) {
    on<LoadGoals>((event, emit) async {
      emit(GoalsLoading());
      try {
        final goals = await remoteDatasource.getGoalsById(userId: event.userId);
        emit(GoalsLoaded(goals.data));
      } catch (e) {
        emit(GoalsError(e.toString()));
      }
    });
  }
}

class DeleteGoalBloc extends Bloc<DeleteGoal, GoalsState> {
  final RemoteDatasource remoteDatasource;
  DeleteGoalBloc({required this.remoteDatasource}) : super(DeleteGoalInitial()) {
    on<DeleteGoal>((event, emit) async {
      emit(DeleteGoalLoading());
      try {
        await remoteDatasource.deleteGoal(event.id);
        emit(DeleteGoalSuccess());
      } catch (e) {
        emit(DeleteGoalError(e.toString()));
      }
    });
  }
}