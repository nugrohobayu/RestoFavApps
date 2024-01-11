import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_fav_apps/viewmodel/shared_preference_view_model.dart';

import '../viewmodel/scheduling_view_model.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Consumer<SharedPreferenceViewModel>(
          builder: (context, provider, child) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Restaurant Notification ',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              Consumer<SchedulingViewModel>(
                  builder: (context, schedule, child) {
                return Switch(
                  value: provider.isDailyActiveNotif,
                  onChanged: (value) {
                    provider.enableDailyActive(value);
                    schedule.scheduledRestaurant(value);
                  },
                );
              })
            ],
          ),
        );
      }),
    );
  }
}
