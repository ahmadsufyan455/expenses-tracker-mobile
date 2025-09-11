import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class SessionService {
  static const String _accessTokenKey = 'access_token';
  static const String _tokenTypeKey = 'token_type';
  static const String _expiresInKey = 'expires_in';
  static const String _loginTimeKey = 'login_time';

  final SharedPreferences _prefs;

  SessionService(this._prefs);

  Future<void> saveToken({required String accessToken, required String tokenType, required int expiresIn}) async {
    final loginTime = DateTime.now().millisecondsSinceEpoch;

    await Future.wait([
      _prefs.setString(_accessTokenKey, accessToken),
      _prefs.setString(_tokenTypeKey, tokenType),
      _prefs.setInt(_expiresInKey, expiresIn),
      _prefs.setInt(_loginTimeKey, loginTime),
    ]);
  }

  String? getAccessToken() {
    return _prefs.getString(_accessTokenKey);
  }

  String? getTokenType() {
    return _prefs.getString(_tokenTypeKey);
  }

  bool isLoggedIn() {
    final token = getAccessToken();
    if (token == null || token.isEmpty) return false;

    return !isTokenExpired();
  }

  bool isTokenExpired() {
    final expiresIn = _prefs.getInt(_expiresInKey);
    final loginTime = _prefs.getInt(_loginTimeKey);

    if (expiresIn == null || loginTime == null) return true;

    final expirationTime = loginTime + (expiresIn * 1000);
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    return currentTime >= expirationTime;
  }

  String? getAuthHeader() {
    final tokenType = getTokenType();
    final accessToken = getAccessToken();

    if (tokenType == null || accessToken == null) return null;

    return '$tokenType $accessToken';
  }

  Future<void> clearSession() async {
    await Future.wait([
      _prefs.remove(_accessTokenKey),
      _prefs.remove(_tokenTypeKey),
      _prefs.remove(_expiresInKey),
      _prefs.remove(_loginTimeKey),
    ]);
  }

  DateTime? getLoginTime() {
    final loginTime = _prefs.getInt(_loginTimeKey);
    if (loginTime == null) return null;

    return DateTime.fromMillisecondsSinceEpoch(loginTime);
  }

  Duration? getTokenRemainingTime() {
    final expiresIn = _prefs.getInt(_expiresInKey);
    final loginTime = _prefs.getInt(_loginTimeKey);

    if (expiresIn == null || loginTime == null) return null;

    final expirationTime = loginTime + (expiresIn * 1000);
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    if (currentTime >= expirationTime) return Duration.zero;

    return Duration(milliseconds: expirationTime - currentTime);
  }
}
