import 'dart:convert';

import 'package:resto_fav_apps/models/ListRestaurant.dart';

class ListRestaurantService {
  List<ListRestaurant> getLisRestaurant(String? json) {
    if (json == null) {
      return [];
    }
    final List parsed = jsonDecode(json);
    return parsed.map((e) => ListRestaurant.fromJson(e)).toList();
  }
}
