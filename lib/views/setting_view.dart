import 'package:flutter/material.dart';

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
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent,
                fontSize: 16,
              ),
            ),
            Switch(
              value: false,
              onChanged: (value) {},
            )
          ],
        ),
      ),
    );
  }
}
