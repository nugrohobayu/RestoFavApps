import 'package:flutter/material.dart';
import 'package:resto_fav_apps/data/models/detail_restaurant_model.dart';
import 'package:resto_fav_apps/data/services/restaurant_service.dart';

class DetailRestaurantViewModel extends ChangeNotifier {
  DetailRestaurantViewModel(String idRestaurant) {
    getDetailRestaurant(idRestaurant);
  }

  final service = RestaurantService();
  DetailRestaurantModel? detailRestaurant;
  List<Category> listFoods = [];
  List<Category> listDrinks = [];

  getDetailRestaurant(String idRestaurant) async {
    final result = await service.getDetailRestaurant(idRestaurant);
    if (result != null) {
      detailRestaurant = result;
      listFoods = result.menus.foods;
      listDrinks = result.menus.drinks;
    }

    notifyListeners();
  }
}
