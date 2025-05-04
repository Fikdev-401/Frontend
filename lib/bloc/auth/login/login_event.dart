part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}


final class Login extends LoginEvent {
  final LoginRequestModel requestBody;

  Login(this.requestBody);
}

final class Logout extends LoginEvent {
  
}