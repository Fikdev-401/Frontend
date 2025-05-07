import 'package:dartz/dartz.dart';
import 'package:flutter_frontend/models/request/login_request_model.dart';
import 'package:flutter_frontend/models/response/login_response_model.dart';
import 'package:flutter_frontend/services/api_service.dart';

class LoginRepository {
  final apiService = ApiService();

  Future<Either<String, LoginResponseModel>> login(LoginRequestModel requestBody) async {
    try {
      final result = await apiService.login(requestBody);
      return right(result);
    } catch (e) {
      return left('Failed to login: $e');
    }
  }
}