import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_frontend/data/datasource/remote_datasource.dart';
import 'package:flutter_frontend/data/models/category_journal.dart';

part 'category_journal_event.dart';
part 'category_journal_state.dart';

class CategoryJournalBloc extends Bloc<CategoryJournalEvent, CategoryJournalState> {
  final RemoteDatasource remoteDatasource;
  CategoryJournalBloc({required this.remoteDatasource}) : super(CategoryJournalInitial()) {
    on<LoadCategoryJournal>((event, emit) async {
      try {
        final categoryJournal = await remoteDatasource.getCategoryJournal();
        emit(CategoryJournalLoaded(categoryJournal));
      } catch (e) {
        emit(CategoryJournalError(e.toString()));
      }
    });
  }
}
