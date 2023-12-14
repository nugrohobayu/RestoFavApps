import 'dart:convert';

import 'package:resto_fav_apps/models/list_restaurant_model.dart';

class ListRestaurantService {
  List<ListRestaurantModel> getLisRestaurant(String? json) {
    if (json == null) {
      return [];
    }
    final List parsed = jsonDecode(json);
    return parsed.map((e) => ListRestaurantModel.fromJson(e)).toList();
  }
}
