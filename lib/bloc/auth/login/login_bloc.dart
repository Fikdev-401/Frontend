import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/models/request/login_request_model.dart';
import 'package:flutter_frontend/models/response/login_response_model.dart';
import 'package:flutter_frontend/repositories/login_repository.dart';
import 'package:flutter_frontend/utils/session_manager.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final repository = LoginRepository();
  LoginBloc() : super(LoginInitial()) {
    on<Login>((event, emit) async {
      emit(LoginLoading());
      final result = await repository.login(event.requestBody);
      result.fold(
        (errorMessage) => emit(LoginError(errorMessage)),
        (loginData) {
          final sessionManager = SessionManager();
          sessionManager.saveSession(loginData.token, loginData.id);
          emit(LoginSuccess(loginData));
        });
    });

    on<Logout>((event, emit) async {
      final sessionManager = SessionManager();
      await sessionManager.removeSession();
      emit(LogoutSuccess());
    });
  }
}
