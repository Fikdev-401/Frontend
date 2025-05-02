import 'package:dio/dio.dart';
import 'package:flutter_frontend/constant/app_constans.dart';
import 'package:flutter_frontend/models/login_request_model.dart';
import 'package:flutter_frontend/models/login_response_model.dart';
import 'package:flutter_frontend/models/register_request_model.dart';
import 'package:flutter_frontend/models/register_response_nodel.dart';

class ApiService {
  final baseUrl = AppConstans.baseUrl;

  final dio = Dio();

  Future<LoginResponseModel> login(LoginRequestModel requestBody) async {
    final response = await dio.post('$baseUrl/api/login', data: requestBody.toJson());
    return LoginResponseModel.fromJson(response.data);
  }

  Future<RegisterResponseModel> register(RegisterRequestModel registerBody) async {
    final response = await dio.post('$baseUrl/api/register', data: registerBody.toJson());
    return RegisterResponseModel.fromJson(response.data);
  }
}