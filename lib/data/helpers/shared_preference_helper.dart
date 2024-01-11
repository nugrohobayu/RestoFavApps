import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  final Future<SharedPreferences> sharedPreference;

  SharedPreferenceHelper({required this.sharedPreference});

  static const dailyRestaurantSchedule = 'DAILY_SCHEDULE_RESTAURANT';

  Future<bool> get isDailyRestaurantActive async {
    final prefs = await sharedPreference;
    return prefs.getBool(dailyRestaurantSchedule) ?? false;
  }

  void setDailyNotification(bool value) async {
    final prefs = await sharedPreference;
    prefs.setBool(dailyRestaurantSchedule, value);
  }
}
