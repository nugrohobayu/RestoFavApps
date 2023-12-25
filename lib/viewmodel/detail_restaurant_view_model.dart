import 'package:flutter/material.dart';
import 'package:resto_fav_apps/data/models/detail_restaurant_model.dart';
import 'package:resto_fav_apps/data/models/request_review_model.dart';
import 'package:resto_fav_apps/data/services/restaurant_service.dart';

enum ResultData {
  loading,
  noData,
  hasData,
  error,
}

class DetailRestaurantViewModel extends ChangeNotifier {
  DetailRestaurantViewModel(String idRestaurant) {
    getDetailRestaurant(idRestaurant);
  }

  late ResultData resultData;
  final service = RestaurantService();
  final TextEditingController ctrlName = TextEditingController();
  final TextEditingController ctrlReview = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DetailRestaurantModel? detailRestaurant;
  List<Category> listFoods = [];
  List<Category> listDrinks = [];
  List<Category> listCategory = [];
  List<CustomerReview> listReview = [];

  Future<void> getDetailRestaurant(String idRestaurant) async {
    try {
      resultData = ResultData.loading;
      notifyListeners();
      final result = await service.getDetailRestaurant(idRestaurant);
      if (result != null) {
        resultData = ResultData.hasData;
        detailRestaurant = result;
        listFoods = result.menus.foods;
        listDrinks = result.menus.drinks;
        listReview = result.customerReviews;
        listCategory = result.categories;
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

  Future<bool> postReview(String idRestaurant) async {
    final id = idRestaurant;
    final payload = RequestReviewModel(
      id: id,
      name: ctrlName.value.text,
      review: ctrlReview.value.text,
    );
    final result = await service.postReview(payload);
    if (result != null) {
      return true;
    }
    return false;
  }
}
