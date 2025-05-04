import 'package:dio/dio.dart';
import 'package:flutter_frontend/constant/app_constans.dart';
import 'package:flutter_frontend/models/add_goal_request_model.dart';
import 'package:flutter_frontend/models/add_goal_response_model.dart';
import 'package:flutter_frontend/models/login_request_model.dart';
import 'package:flutter_frontend/models/login_response_model.dart';
import 'package:flutter_frontend/models/register_request_model.dart';
import 'package:flutter_frontend/models/register_response_nodel.dart';
import 'package:flutter_frontend/utils/session_manager.dart';

class ApiService {
  final baseUrl = AppConstans.baseUrl;
  final sessionManager = SessionManager();

  final dio = Dio();

  Future<LoginResponseModel> login(LoginRequestModel requestBody) async {
    final response = await dio.post('$baseUrl/api/login', data: requestBody.toJson());
    return LoginResponseModel.fromJson(response.data);
  }

  Future<RegisterResponseModel> register(RegisterRequestModel registerBody) async {
    final response = await dio.post('$baseUrl/api/register', data: registerBody.toJson());
    return RegisterResponseModel.fromJson(response.data);
  }

  Future<AddGoalResponseModel> addGoal(AddGoalRequestModel requestBody) async {
  final token = await sessionManager.getToken(); // ambil dari SharedPreferences, misalnya
  final response = await dio.post(
    '$baseUrl/api/goals',
    data: requestBody.toJson(),
    options: Options(
      headers: {
        'Authorization': 'Bearer $token',
      },
    ),
  );
  return AddGoalResponseModel.fromJson(response.data);
}

}