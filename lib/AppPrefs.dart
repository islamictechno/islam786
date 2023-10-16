import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static SharedPreferences? _preferences;

  static const _keyStatus = 'status';



  static Future init() async => _preferences = await SharedPreferences.getInstance();

  static Future setPhoneNumber(String username) async =>
      await _preferences?.setString(_keyStatus, 'false');

  static String? getPhoneNumber() => _preferences?.getString(_keyStatus);

}
