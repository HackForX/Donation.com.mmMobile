import 'package:shared_preferences/shared_preferences.dart';

class MySharedPref {
  // prevent making instance
  MySharedPref._();

  // get storage
  static late SharedPreferences _sharedPreferences;

  static const String _token = 'token';
  static const String _userName = 'userName';
  static const String _email = 'email';


  static const String _userId = 'userId';

  /// init get storage services
  static Future<void> init(SharedPreferences sharedPreferences) async {
    _sharedPreferences = sharedPreferences;
  }

  static Future<void> setToken(String token) =>
      _sharedPreferences.setString(_token, token);

  static String? getToken() => _sharedPreferences.getString(_token);

  static Future<void> setUserName(String name) =>
      _sharedPreferences.setString(_userName, name);

  static String? getUserName() => _sharedPreferences.getString(_userName);

  static Future<void> setEmail(String email) =>
      _sharedPreferences.setString(_email, email);

  static String? getEmail() => _sharedPreferences.getString(_email);

  static Future<void> setUserId(int userId) =>
      _sharedPreferences.setInt(_userId, userId);

  static int? getUserId() => _sharedPreferences.getInt(_userId);
  static Future<void> clear() async => await _sharedPreferences.clear();
}
