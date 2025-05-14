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

class DeleteJournalBloc extends Bloc<DeleteJournal, JournalsState> {
  final RemoteDatasource remoteDatasource;
  DeleteJournalBloc({required this.remoteDatasource}) : super(DeleteJournalInitial()) {
    on<DeleteJournal>((event, emit) async {
      emit(DeleteJournalLoading());
      try {
        await remoteDatasource.deleteJournal(event.id);
        emit(DeleteJournalSuccess());
      } catch (e) {
        emit(DeleteJournalError(message: e.toString()));
      }
    });
  }
}