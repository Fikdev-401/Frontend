

import 'package:dartz/dartz.dart';
import 'package:flutter_frontend/models/request/add_goal_request_model.dart';
import 'package:flutter_frontend/models/response/add_goal_response_model.dart';
import 'package:flutter_frontend/services/api_service.dart';

class AddGoalRepository {
  final apiService = ApiService();

  Future<Either<String, AddGoalResponseModel>> addGoal(AddGoalRequestModel requestBody) async {
    try {
      final result = await apiService.addGoal(requestBody);
      return right(result);
    } catch (e) {
      return left('Failed to login: $e');
    }
  }
}