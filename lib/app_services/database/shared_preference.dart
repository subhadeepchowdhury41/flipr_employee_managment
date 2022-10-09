import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceServices {
  static void setLoginCredentials() async {
    final SharedPreferences sharedPreference =
        await SharedPreferences.getInstance();

    sharedPreference.setString('access_token', '');
    sharedPreference.setString('refresh_token', '');
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('access_token');
  }

  static Future<String?> getRefreshToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('refresh_token');
  }

  static void _checkAccessTokenDetails() {}

  static void _checkRefreshTokenDetails() {}
}
