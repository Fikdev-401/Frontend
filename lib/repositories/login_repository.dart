import 'package:dartz/dartz.dart';
import 'package:flutter_frontend/models/login_request_model.dart';
import 'package:flutter_frontend/models/login_response_model.dart';
import 'package:flutter_frontend/services/api_service.dart';

class LoginRepository {
  final apiService = ApiService();

  Future<Either<String, LoginResponseModel>> login(LoginRequestModel registerBody) async {
    try {
      final result = await apiService.login(registerBody);
      return right(result);
    } catch (e) {
      return left('Failed to login: $e');
    }
  }
}