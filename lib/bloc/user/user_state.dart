part of 'user_bloc.dart';

@immutable
sealed class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserLoaded extends UserState {
  final User data;
  UserLoaded({required this.data});
}

class UserError extends UserState {
  final String message;

  UserError({required this.message});
}
