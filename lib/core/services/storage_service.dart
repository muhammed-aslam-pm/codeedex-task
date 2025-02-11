import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static const String tokenKey = 'token';
  static const String userIdKey = 'userId';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  Future<void> saveAuthData(String token, String userId) async {
    await _prefs.setString(tokenKey, token);
    await _prefs.setString(userIdKey, userId);
  }

  String? getToken() => _prefs.getString(tokenKey);
  String? getUserId() => _prefs.getString(userIdKey);

  Future<void> clearAuthData() async {
    await _prefs.remove(tokenKey);
    await _prefs.remove(userIdKey);
  }
}
