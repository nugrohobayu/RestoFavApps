import 'package:flutter/material.dart';
import 'package:resto_fav_apps/assets/assets.dart';
import 'package:resto_fav_apps/views/bottom_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _initialize();
  }

  _initialize() async {
    await Future.delayed(const Duration(seconds: 4)).then((value) async {
      Navigator.pushReplacementNamed(
        context,
        BottomNavigation.routeName,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Stack(
          children: [
            Image.asset(Assets.bgSplash),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(Assets.splashLeft, width: 40),
                Padding(
                  padding: const EdgeInsets.only(top: 100.0),
                  child: Image.asset(
                    Assets.splashRight,
                    width: 50,
                  ),
                ),
              ],
            ),
            Center(
              child: Image.asset(
                Assets.logo,
                width: 200,
              ),
            )
          ],
        ),
      ),
    );
  }
}
