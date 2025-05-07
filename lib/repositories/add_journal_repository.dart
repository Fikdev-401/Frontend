


import 'package:dartz/dartz.dart';
import 'package:flutter_frontend/models/request/add_journal_request_model.dart';
import 'package:flutter_frontend/models/response/add_journal_response_model.dart';
import 'package:flutter_frontend/services/api_service.dart';

class AddJournalRepository {
  final apiService = ApiService();

  Future<Either<String, AddJournalResponseModel>> addJournal(AddJournalRequestModel requestBody) async {
    try {
      final result = await apiService.addJournal(requestBody);
      return right(result);
    } catch (e) {
      return left('Failed to login: $e');
    }
  }
}