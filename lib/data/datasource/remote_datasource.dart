import 'package:dio/dio.dart';
import 'package:flutter_frontend/data/models/caregory_goals.dart';
import 'package:flutter_frontend/data/models/goals.dart';
import 'package:flutter_frontend/data/models/journals.dart';
import 'package:flutter_frontend/utils/session_manager.dart';

class RemoteDatasource {
  final dio = Dio(BaseOptions(baseUrl: 'https://journal-v2.fikdevs.my.id/api'));
  final session = SessionManager();

  Future<DataGoals> getGoalsById({ required int userId }) async {
    final token = await session.getToken(); // ambil token dari SharedPreferences

    final response = await dio.get(
      '/goals?user_id=$userId',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    print('Tipe data: ${response.data.runtimeType}');
    print('Isi response: ${response.data}');

    return DataGoals.fromJson(response.data);
  }
  Future<DataJournals> getJournalById({ required int userId }) async {
    final token = await session.getToken(); // ambil token dari SharedPreferences

    final response = await dio.get(
      '/journals?user_id=$userId',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );

    return DataJournals.fromJson(response.data);
  }
  Future<DataCategoryGoals> getCategoryGoal( ) async {
    final token = await session.getToken(); // ambil token dari SharedPreferences

    final response = await dio.get(
      '/category-goal',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      ),
    );
    return DataCategoryGoals.fromJson(response.data);
  }

}
