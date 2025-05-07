import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/models/request/add_goal_request_model.dart';
import 'package:flutter_frontend/models/response/add_goal_response_model.dart';
import 'package:flutter_frontend/repositories/add_goal_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_goal_event.dart';
part 'add_goal_state.dart';

class AddGoalBloc extends Bloc<AddGoalEvent, AddGoalState> {
  final repository = AddGoalRepository();
  AddGoalBloc() : super(AddGoalInitial()) {
    on<AddGoal>((event, emit) async {
      emit(AddGoalLoading());
      try {
        final result = await repository.addGoal(event.requestBody);
        result.fold(
          (error) => emit(AddGoalError(error)),
          (response) => emit(AddGoalSuccess(response)),
        );
      } catch (e) {
        emit(AddGoalError(e.toString()));
      }
    });
  }
}
