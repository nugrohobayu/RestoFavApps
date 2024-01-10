import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodel/scheduling_view_model.dart';

class SettingView extends StatelessWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Container(
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
            Consumer<SchedulingViewModel>(builder: (context, provider, child) {
              return Switch(
                value: provider.isScheduled,
                onChanged: (value) {
                  provider.scheduledRestaurant(value);
                },
              );
            })
          ],
        ),
      ),
    );
  }
}
