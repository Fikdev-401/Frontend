part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}


final class Register extends RegisterEvent {
  final RegisterRequestModel registerBody;

  Register(this.registerBody);
}