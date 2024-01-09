import 'package:flutter/material.dart';
import 'package:resto_fav_apps/data/helpers/database_helper.dart';
import 'package:resto_fav_apps/data/models/restaurant_model.dart';

enum ResultState {
  loading,
  noData,
  hasData,
  error,
}

class FavoriteViewModel extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  FavoriteViewModel({required this.databaseHelper}) {
    _getRestaurant();
  }
  late ResultState resultData;

  List<RestaurantModel> favourite = [];

  void _getRestaurant() async {
    favourite = await DatabaseHelper().getFavorite();
    notifyListeners();
    if (favourite.isNotEmpty) {
      resultData = ResultState.hasData;
      notifyListeners();
    } else {
      resultData = ResultState.noData;
      notifyListeners();
    }
  }

  void addFavorite(RestaurantModel restaurant) async {
    try {
      await databaseHelper.addFavorite(restaurant);
      _getRestaurant();
    } catch (e) {
      resultData = ResultState.error;
      notifyListeners();
    }
  }

  Future<bool> isFavourite(String id) async {
    final favouriteRestaurant = await databaseHelper.getFavoriteById(id);
    return favouriteRestaurant.isNotEmpty;
  }

  void removeFavourite(String id) async {
    try {
      await databaseHelper.deleteFavorite(id);
      _getRestaurant();
    } catch (e) {
      resultData = ResultState.error;
      notifyListeners();
    }
  }
}
