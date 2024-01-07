import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:resto_fav_apps/views/list_restaurant_view.dart';

class BottomNavigation extends StatefulWidget {
  static const routeName = "/BottomNavigation";
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  final _controller = PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [
      ListRestaurantView(),
      Scaffold(),
      Scaffold(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems(ColorScheme color) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: color.primary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.favorite),
        title: ("Favorite"),
        activeColorPrimary: color.primary,
        inactiveColorPrimary: Colors.grey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: color.primary,
        inactiveColorPrimary: Colors.grey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: null,
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarsItems(color),
        resizeToAvoidBottomInset: true,
      ),
    );
  }
}
