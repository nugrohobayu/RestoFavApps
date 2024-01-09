import 'package:flutter/material.dart';
import 'package:resto_fav_apps/data/helpers/result_data.dart';
import 'package:resto_fav_apps/data/models/restaurant_model.dart';
import 'package:resto_fav_apps/data/services/restaurant_service.dart';

class RestaurantViewModel extends ChangeNotifier {
  RestaurantViewModel() {
    getRestaurant();
  }

  late ResultData resultData;
  List<RestaurantModel> listRestaurant = [];
  final service = RestaurantService();
  bool isLoading = true;
  TextEditingController ctrlQuery = TextEditingController();
  String? query;

  Future<void> getRestaurant() async {
    try {
      resultData = ResultData.loading;
      notifyListeners();
      final result = await service.getList();
      if (result != null) {
        resultData = ResultData.hasData;
        listRestaurant = result;
        notifyListeners();
      } else {
        resultData = ResultData.noData;
        notifyListeners();
      }
    } catch (error) {
      resultData = ResultData.error;
      notifyListeners();
    }
  }

  Future<void> searchRestaurant(String value) async {
    try {
      resultData = ResultData.loading;
      notifyListeners();
      final result = await service.searchRestaurant(value);
      if (result.isNotEmpty) {
        resultData = ResultData.hasData;
        listRestaurant = result;
        notifyListeners();
      } else {
        resultData = ResultData.noData;
        notifyListeners();
      }
    } catch (error) {
      resultData = ResultData.error;
      notifyListeners();
    }
  }
}
