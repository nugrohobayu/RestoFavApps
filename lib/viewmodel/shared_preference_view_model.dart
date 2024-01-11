import 'package:flutter/material.dart';
import 'package:resto_fav_apps/data/helpers/shared_preference_helper.dart';

class SharedPreferenceViewModel extends ChangeNotifier {
  SharedPreferenceHelper sharedPreferenceHelper;
  SharedPreferenceViewModel({required this.sharedPreferenceHelper}) {
    _dailyActiveNotif();
  }

  bool _isDailyActiveNotif = false;
  bool get isDailyActiveNotif => _isDailyActiveNotif;

  void _dailyActiveNotif() async {
    _isDailyActiveNotif = await sharedPreferenceHelper.isDailyRestaurantActive;
    notifyListeners();
  }

  void enableDailyActive(bool value) {
    sharedPreferenceHelper.setDailyNotification(value);
    _dailyActiveNotif();
  }
}
