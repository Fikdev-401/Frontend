import 'package:flutter_frontend/constant/app_constans.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  Future<void> saveSession(String token, int id) async {
    final pref = await SharedPreferences.getInstance();
    print("Saving user ID: $id with key: ${AppConstans.userIdKey}");
    await pref.setString(AppConstans.tokenKey, token);
    await pref.setInt(AppConstans.userIdKey, id);
    print("User ID saved successfully");
  }

  Future<String> getToken() async {
    final pref = await SharedPreferences.getInstance();

    final token = pref.getString(AppConstans.tokenKey);
    return token ?? '';
  }

  Future<void> removeSession() async {
    final pref = await SharedPreferences.getInstance();
    await pref.remove(AppConstans.tokenKey);
    await pref.remove(AppConstans.userIdKey);
  }

  Future<int?> getUserId() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getInt(AppConstans.userIdKey);
  }
}
