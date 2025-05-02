part of 'register_bloc.dart';

@immutable
class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterResponseModel registerBody;

  RegisterSuccess(this.registerBody);
}

class RegisterError extends RegisterState {
  final String error;
  RegisterError(this.error);
}
