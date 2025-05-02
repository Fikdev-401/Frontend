import 'package:dartz/dartz.dart';
import 'package:flutter_frontend/models/register_request_model.dart';
import 'package:flutter_frontend/models/register_response_nodel.dart';
import 'package:flutter_frontend/services/api_service.dart';

class RegisterRepository {
  final apiService = ApiService();

  Future<Either<String, RegisterResponseModel>> register(
      RegisterRequestModel registerBody) async {
    try {
      final result = await apiService.register(registerBody);
      return right(result);
    } catch (e) {
      return left('Failed to register: $e');
    }
  }
}
