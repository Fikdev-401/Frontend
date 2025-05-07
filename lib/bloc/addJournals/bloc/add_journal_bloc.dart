import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/data/datasource/remote_datasource.dart';
import 'package:flutter_frontend/models/request/add_journal_request_model.dart';
import 'package:flutter_frontend/models/response/add_journal_response_model.dart';
import 'package:flutter_frontend/repositories/add_journal_repository.dart';

part 'add_journal_event.dart';
part 'add_journal_state.dart';

class AddJournalBloc extends Bloc<AddJournalEvent, AddJournalState> {
  final repository = AddJournalRepository();
  AddJournalBloc() : super(AddJournalInitial()) {
    on<AddJournal>((event, emit) async {
      emit(AddJournalLoading());
      try {
        final result = await repository.addJournal(event.requestBody);
        result.fold(
          (error) => emit(AddJournalError(error)), 
          (response) => emit(AddJournalLoaded(response))
          );
      } catch (e) {
        emit(AddJournalError(e.toString()));
      }
    });
  }
}
