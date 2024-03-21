import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  int? value;
  String? username;

  Future<void> saveSession(String username, bool status) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("username", username);
    pref.setBool("isLogin", status);
  }

  Future<String?> getUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    username = pref.getString("username");
    return username;
  }

  Future<void> deleteSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}

SessionManager sessionManager = SessionManager();
