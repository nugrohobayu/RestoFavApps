import 'package:flutter/material.dart';
import 'package:resto_fav_apps/data/helpers/result_data.dart';
import 'package:resto_fav_apps/data/models/response_restaurant_model.dart';
import 'package:resto_fav_apps/data/models/restaurant_detail_model.dart';
import 'package:resto_fav_apps/data/models/restaurant_model.dart';
import 'package:resto_fav_apps/data/services/restaurant_service.dart';

import '../data/services/base_api.dart';

class RestaurantViewModel extends ChangeNotifier {
  final BaseApi baseApi;
  RestaurantViewModel({required this.baseApi}) {
    getRestaurant();
  }

  late ResultData resultData;
  List<Restaurant>? listRestaurant = [];
  final service = RestaurantService();
  bool isLoading = true;
  TextEditingController ctrlQuery = TextEditingController();
  String? query;

  Future<void> getRestaurant() async {
    try {
      resultData = ResultData.loading;
      notifyListeners();
      final result = await baseApi.getList();
      print('$result riiii');
      if (result.restaurants.isNotEmpty) {
        resultData = ResultData.hasData;
        listRestaurant = result.restaurants;
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
      final result = await baseApi.fetchSearch(value);
      if (result.restaurants.isNotEmpty) {
        resultData = ResultData.hasData;
        listRestaurant = result.restaurants;
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
