import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/models/register_request_model.dart';
import 'package:flutter_frontend/models/register_response_nodel.dart';
import 'package:flutter_frontend/repositories/register_repository.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final registerRepository = RegisterRepository();
  RegisterBloc() : super(RegisterInitial()) {
    on<Register>((event, emit) async {
      emit(RegisterLoading());
      final result = await registerRepository.register(event.registerBody as RegisterRequestModel);
      result.fold((errorMessage) => emit(RegisterError(errorMessage)), (registerBody) => emit(RegisterSuccess(registerBody)));
    });
  }
}
