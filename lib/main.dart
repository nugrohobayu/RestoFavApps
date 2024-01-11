import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:resto_fav_apps/data/helpers/shared_preference_helper.dart';
import 'package:resto_fav_apps/data/models/response_restaurant_model.dart';
import 'package:resto_fav_apps/viewmodel/favorite_view_model.dart';
import 'package:resto_fav_apps/viewmodel/restaurant_view_model.dart';
import 'package:resto_fav_apps/viewmodel/scheduling_view_model.dart';
import 'package:resto_fav_apps/viewmodel/shared_preference_view_model.dart';
import 'package:resto_fav_apps/views/bottom_navigation.dart';
import 'package:resto_fav_apps/views/detail_restaurant_view.dart';
import 'package:resto_fav_apps/views/list_restaurant_view.dart';
import 'package:resto_fav_apps/views/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/helpers/database_helper.dart';
import 'data/helpers/notification_helper.dart';
import 'data/services/background_service.dart';
import 'data/services/base_api.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initIsolate();
  await AndroidAlarmManager.initialize();
  await notificationHelper.initNotification(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => SchedulingViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) =>
                FavoriteViewModel(databaseHelper: DatabaseHelper()),
          ),
          ChangeNotifierProvider(
            create: (context) => RestaurantViewModel(baseApi: BaseApi()),
          ),
          ChangeNotifierProvider(
            create: (context) => SharedPreferenceViewModel(
                sharedPreferenceHelper: SharedPreferenceHelper(
                    sharedPreference: SharedPreferences.getInstance())),
          )
        ],
        builder: (context, child) {
          return Consumer<SharedPreferenceViewModel>(
              builder: (context, provider, child) {
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
                ListRestaurantView.routeName: (context) =>
                    const ListRestaurantView(),
                DetailRestaurantView.routeName: (context) =>
                    DetailRestaurantView(
                        restaurant: ModalRoute.of(context)?.settings.arguments
                            as Restaurant),
                BottomNavigation.routeName: (context) =>
                    const BottomNavigation(),
              },
            );
          });
        });
  }
}
