import 'package:flutter/material.dart';
import 'package:resto_fav_apps/data/helpers/notification_helper.dart';
import 'package:resto_fav_apps/views/detail_restaurant_view.dart';
import 'package:resto_fav_apps/views/list_favorite_view.dart';
import 'package:resto_fav_apps/views/list_restaurant_view.dart';
import 'package:resto_fav_apps/views/setting_view.dart';
import 'package:resto_fav_apps/views/video_player_view.dart';

class BottomNavigation extends StatefulWidget {
  static const routeName = "/BottomNavigation";
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int selectedIndex = 0;
  NotificationHelper notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    notificationHelper.configureSelectNotificationSubject(
      DetailRestaurantView.routeName,
    );
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    List<Widget> listWidget = [
      const ListRestaurantView(),
      const ListFavoriteView(),
      const SettingView(),
      const VideoPlayerView()
    ];

    List<Widget> listNavDestination = const [
      NavigationDestination(
        selectedIcon: Icon(Icons.home),
        icon: Icon(Icons.home_outlined),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Icon(Icons.favorite),
        label: 'Favorite',
      ),
      NavigationDestination(
        icon: Icon(Icons.settings),
        label: 'Settings',
      ),
      NavigationDestination(
        icon: Icon(Icons.video_call),
        label: 'Video',
      ),
    ];

    return Scaffold(
      appBar: null,
      body: listWidget[selectedIndex],
      bottomNavigationBar: NavigationBar(
        indicatorColor: color.secondary,
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            selectedIndex = index;
          });
        },
        destinations: listNavDestination,
      ),
    );
  }
}
