import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceServices {
  static Future<void> setLoginCredentials(
      {required String accessToken, required String refreshToken}) async {
    final SharedPreferences sharedPreference =
        await SharedPreferences.getInstance();

    sharedPreference.setString('access_token', accessToken);
    sharedPreference.setString('refresh_token', refreshToken);
  }

  static Future<String?> getAccessToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('access_token');
  }

  static Future<String?> getRefreshToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('refresh_token');
  }
}
