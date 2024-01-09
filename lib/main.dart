import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:resto_fav_apps/data/models/restaurant_model.dart';
import 'package:resto_fav_apps/views/bottom_navigation.dart';
import 'package:resto_fav_apps/views/detail_restaurant_view.dart';
import 'package:resto_fav_apps/views/list_restaurant_view.dart';
import 'package:resto_fav_apps/views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resto Fav',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'PlusJakartaSans',
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFFF9130),
            elevation: 1,
            titleTextStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            )),
        colorScheme: const ColorScheme.light().copyWith(
          primary: const Color(0xFFFF5B22),
          onPrimary: const Color(0xFFFF9130),
          secondary: const Color(0xFFFECDA6),
          onBackground: const Color(0xFFA9A9A9),
        ),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        ListRestaurantView.routeName: (context) => const ListRestaurantView(),
        DetailRestaurantView.routeName: (context) => DetailRestaurantView(
            restaurantModel:
                ModalRoute.of(context)?.settings.arguments as RestaurantModel),
        BottomNavigation.routeName: (context) => const BottomNavigation(),
      },
    );
  }
}
