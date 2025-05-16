import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/data/datasource/remote_datasource.dart';
import 'package:flutter_frontend/data/models/users.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final remote = RemoteDatasource();
  UserBloc() : super(UserInitial()) {
    on<GetUserById>((event, emit) async {
      emit(UserLoading());
      try {
        final user = await remote.getUserById(id: event.id);
        emit(UserLoaded(data: user.data));
      } catch (e) {
        emit(UserError(message: e.toString()));
      }
    });
  }
}
