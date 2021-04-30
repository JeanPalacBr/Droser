import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;
  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  String get username => _sharedPrefs.getString(keyUsername) ?? "";

  void setusername(String value) {
    _sharedPrefs.setString(keyUsername, value);
  }

  Future<void> auth(String user, String token, String email) async {
    _sharedPrefs.setString("usrname", username);
    _sharedPrefs.setString("email", email);
    _sharedPrefs.setString("tokn", token);
  }
}

const String keyUsername = "key_username";
final sharedPrefs = SharedPrefs();
