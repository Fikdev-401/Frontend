import 'package:flutter_frontend/constant/app_constans.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  Future<void> saveSession(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(AppConstans.tokenKey, token);
  }

  Future<String> getToken() async {
    final pref = await SharedPreferences.getInstance();

    final token = pref.getString(AppConstans.tokenKey);
    return token ?? '';
  }

  Future<void> removeSession() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(AppConstans.tokenKey);
  }
}
