part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final LoginResponseModel loginData;
  LoginSuccess(this.loginData);
}

final class LoginError extends LoginState {
  final String message;
  LoginError(this.message);
}

final class LogoutSuccess extends LoginState {}