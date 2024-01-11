import 'package:flutter/material.dart';
import 'package:resto_fav_apps/data/helpers/database_helper.dart';
import 'package:resto_fav_apps/data/helpers/result_data.dart';
import 'package:resto_fav_apps/data/models/response_restaurant_model.dart';

class FavoriteViewModel extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  FavoriteViewModel({required this.databaseHelper}) {
    _getRestaurant();
  }
  late ResultData _resultData = ResultData.hasData;
  ResultData get state => _resultData;

  List<Restaurant> _favourite = [];
  List<Restaurant> get favourite => _favourite;

  void _getRestaurant() async {
    _favourite = await DatabaseHelper().getFavorite();
    if (_favourite.isNotEmpty) {
      _resultData = ResultData.hasData;
    } else {
      _resultData = ResultData.noData;
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
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
