import 'package:dio/dio.dart';
import 'package:flutter_frontend/constant/app_constans.dart';
import 'package:flutter_frontend/models/request/add_goal_request_model.dart';
import 'package:flutter_frontend/models/request/add_journal_request_model.dart';
import 'package:flutter_frontend/models/response/add_goal_response_model.dart';
import 'package:flutter_frontend/models/request/login_request_model.dart';
import 'package:flutter_frontend/models/response/add_journal_response_model.dart';
import 'package:flutter_frontend/models/response/login_response_model.dart';
import 'package:flutter_frontend/models/request/register_request_model.dart';
import 'package:flutter_frontend/models/response/register_response_nodel.dart';
import 'package:flutter_frontend/utils/session_manager.dart';

class ApiService {
  final baseUrl = AppConstans.baseUrl;
  final sessionManager = SessionManager();

  final dio = Dio();

  Future<LoginResponseModel> login(LoginRequestModel requestBody) async {
    final response =
        await dio.post('$baseUrl/api/login', data: requestBody.toJson());
    print("Raw API response: ${response.data}");
    return LoginResponseModel.fromJson(response.data);
  }

  Future<RegisterResponseModel> register(
      RegisterRequestModel registerBody) async {
    final response =
        await dio.post('$baseUrl/api/register', data: registerBody.toJson());
    return RegisterResponseModel.fromJson(response.data);
  }

  Future<AddGoalResponseModel> addGoal(AddGoalRequestModel requestBody) async {
    final token = await sessionManager
        .getToken(); // ambil dari SharedPreferences, misalnya
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
  Future<AddJournalResponseModel> addJournal(AddJournalRequestModel requestBody) async {
    final token = await sessionManager
        .getToken(); // ambil dari SharedPreferences, misalnya
    final response = await dio.post(
      '$baseUrl/api/journals',
      data: requestBody.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return AddJournalResponseModel.fromJson(response.data);
  }

  Future<AddJournalResponseModel> editJournal(AddJournalRequestModel requestBody, int id) async {
    final token = await sessionManager
        .getToken(); // ambil dari SharedPreferences, misalnya
    final response = await dio.put(
      '$baseUrl/api/journals/$id',
      data: requestBody.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    return AddJournalResponseModel.fromJson(response.data);
  }
  Future<AddGoalResponseModel> editGoal(AddGoalRequestModel requestBody, int id) async {
    final token = await sessionManager
        .getToken(); // ambil dari SharedPreferences, misalnya
    final response = await dio.put(
      '$baseUrl/api/goals/$id',
      data: requestBody.toJson(),
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    print(response.data);
    return AddGoalResponseModel.fromJson(response.data);
  }


}
