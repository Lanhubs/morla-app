import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppPrefsService extends GetxService {
  static const String _kFirstTimeKey = 'is_first_time_app_open';
  static const String _kHasLoggedInKey = 'has_logged_in_before';

  late SharedPreferences _prefs;

  Future<AppPrefsService> init() async {
    _prefs = await SharedPreferences.getInstance();
    return this;
  }

  bool get isFirstTimeAppOpen {
    // Defaults to true if the key does not exist
    return _prefs.getBool(_kFirstTimeKey) ?? true;
  }

  Future<void> setFirstTimeAppOpen(bool value) async {
    await _prefs.setBool(_kFirstTimeKey, value);
  }

  bool get hasLoggedInBefore {
    // Defaults to false if the key does not exist
    return _prefs.getBool(_kHasLoggedInKey) ?? false;
  }

  Future<void> setHasLoggedInBefore(bool value) async {
    await _prefs.setBool(_kHasLoggedInKey, value);
  }
}
