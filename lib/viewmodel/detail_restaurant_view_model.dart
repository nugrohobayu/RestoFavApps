import 'package:flutter/material.dart';
import 'package:resto_fav_apps/data/models/detail_restaurant_model.dart';
import 'package:resto_fav_apps/data/models/request_review_model.dart';
import 'package:resto_fav_apps/data/services/restaurant_service.dart';

class DetailRestaurantViewModel extends ChangeNotifier {
  DetailRestaurantViewModel(String idRestaurant) {
    getDetailRestaurant(idRestaurant);
  }

  final service = RestaurantService();
  final TextEditingController ctrlName = TextEditingController();
  final TextEditingController ctrlReview = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DetailRestaurantModel? detailRestaurant;
  List<Category> listFoods = [];
  List<Category> listDrinks = [];
  List<CustomerReview> listReview = [];
  bool isLoading = true;

  Future<void> getDetailRestaurant(String idRestaurant) async {
    final result = await service.getDetailRestaurant(idRestaurant);
    if (result != null) {
      detailRestaurant = result;
      listFoods = result.menus.foods;
      listDrinks = result.menus.drinks;
      listReview = result.customerReviews;
      isLoading = false;
    }

    notifyListeners();
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
