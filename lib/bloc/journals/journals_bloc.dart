import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/data/datasource/remote_datasource.dart';
import 'package:flutter_frontend/data/models/journals.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'journals_event.dart';
part 'journals_state.dart';

class JournalsBloc extends Bloc<JournalsEvent, JournalsState> {
  final RemoteDatasource remoteDatasource;
  JournalsBloc({required this.remoteDatasource}) : super(JournalsInitial()) {
    on<LoadJournals>((event, emit) async {
      emit(JournalsLoading());
      try {
        final journals = await remoteDatasource.getJournalById(userId: event.userId);
        emit(JournalsLoaded(journals: journals.data));
      } catch (e) {
        emit(JournalsError(message: e.toString()));
      }
    });
  }
}
