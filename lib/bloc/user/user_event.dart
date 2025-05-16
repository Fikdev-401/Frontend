part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class GetUserById extends UserEvent {
  final int id;
  GetUserById({required this.id});
}