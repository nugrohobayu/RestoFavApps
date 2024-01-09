import 'package:flutter/material.dart';
import 'package:resto_fav_apps/data/helpers/database_helper.dart';
import 'package:resto_fav_apps/data/helpers/result_data.dart';
import 'package:resto_fav_apps/data/models/restaurant_model.dart';

class FavoriteViewModel extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  FavoriteViewModel({required this.databaseHelper}) {
    _getRestaurant();
  }
  late ResultData _resultData;
  ResultData get state => _resultData;

  List<RestaurantModel> _favourite = [];
  List<RestaurantModel> get favourite => _favourite;

  void _getRestaurant() async {
    _favourite = await DatabaseHelper().getFavorite();
    notifyListeners();
    if (_favourite.isNotEmpty) {
      _resultData = ResultData.hasData;
      notifyListeners();
    } else {
      _resultData = ResultData.noData;
      notifyListeners();
    }
  }

  void addFavorite(RestaurantModel restaurant) async {
    try {
      await databaseHelper.addFavorite(restaurant);
      _getRestaurant();
    } catch (e) {
      _resultData = ResultData.error;
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
      _resultData = ResultData.error;
      notifyListeners();
    }
  }
}
