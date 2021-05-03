import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static SharedPreferences _sharedPrefs;
  init() async {
    if (_sharedPrefs == null) {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  String get userid => _sharedPrefs.getString("userid") ?? "";
  String get email => _sharedPrefs.getString("email") ?? "";
  String get token => _sharedPrefs.getString("tokn") ?? "";

  // void setusername(String value) {
  //   _sharedPrefs.setString(userid, value);
  // }

  Future<void> auth(String userid, String token, String email) async {
    _sharedPrefs.setString("userid", userid);
    _sharedPrefs.setString("email", email);
    _sharedPrefs.setString("tokn", token);
  }
}

final sharedPrefs = SharedPrefs();
