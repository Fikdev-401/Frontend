import 'package:dio/dio.dart';
import 'package:flutter_frontend/data/models/goals.dart';
import 'package:flutter_frontend/utils/session_manager.dart';

class RemoteDatasource {
  final dio = Dio(BaseOptions(baseUrl: 'https://journal.fikdevs.my.id/api'));
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
}
