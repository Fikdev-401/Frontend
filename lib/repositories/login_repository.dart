import 'package:dartz/dartz.dart';
import 'package:flutter_frontend/models/request/login_request_model.dart';
import 'package:flutter_frontend/models/response/login_response_model.dart';
import 'package:flutter_frontend/services/api_service.dart';

class LoginRepository {
  final apiService = ApiService();

  Future<Either<String, LoginResponseModel>> login(LoginRequestModel requestBody) async {
    try {
      final response = await apiService.login(requestBody);
      print("Raw login response: ${response.toJson()}");
      return Right(response);
    } catch (e) {
      return Left(e.toString());
    }
  }
}