import 'package:flutter/material.dart';
import 'package:resto_fav_apps/data/models/restaurant_model.dart';
import 'package:resto_fav_apps/data/services/restaurant_service.dart';

class RestaurantViewModel extends ChangeNotifier {
  RestaurantViewModel() {
    getRestaurant();
  }
  List<RestaurantModel> listRestaurant = [];
  final service = RestaurantService();

  getRestaurant() async {
    final result = await service.getList();
    if (result != null) {
      listRestaurant = result;
    }
    notifyListeners();
  }
}
