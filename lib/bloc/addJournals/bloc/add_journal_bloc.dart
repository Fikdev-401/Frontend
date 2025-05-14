import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          (error) => {
          print('AddJournalError: $error'),
          emit(AddJournalError(error))
          },
          
          (response) => {
            print('AddJournalLoaded: $response'),
            emit(AddJournalLoaded(response))
          }
          );
      } catch (e) {
        emit(AddJournalError(e.toString()));
      }
    }
    );
  }
}

class EditJournalBloc extends Bloc<AddJournalEvent, AddJournalState> {
  final repository = AddJournalRepository();
  EditJournalBloc() : super(AddJournalInitial()) {
    on<EditJournal>((event, emit) async {
      emit(EditJournalLoading());
      try {
        final result = await repository.editJournal(event.requestBody, event.id);
        result.fold(
          (error) => emit(EditJournalError(error)),
          (response) => emit(EditJournalLoaded(response))
        );
        
      } catch (e) {
        emit(EditJournalError(e.toString()));
      }
    });
  }
}