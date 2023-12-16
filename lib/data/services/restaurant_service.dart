import 'dart:convert';

import 'package:resto_fav_apps/data/models/detail_restaurant_model.dart';
import 'package:resto_fav_apps/data/models/restaurant_model.dart';
import 'package:http/http.dart';

class RestaurantService {
  final String url = 'https://restaurant-api.dicoding.dev';

  Future<List<RestaurantModel>?> getList() async {
    Uri uriUrl = Uri.parse("$url/list");
    Response result = await get(uriUrl);
    if (result.statusCode == 200 || result.statusCode == 201) {
      Map<String, dynamic> jsonData = json.decode(result.body);
      List<dynamic> responseListRestaurant = jsonData['restaurants'];
      List<RestaurantModel> res = responseListRestaurant
          .map((e) => RestaurantModel.fromJson(e))
          .toList();
      return res;
    }
    return null;
  }

  Future<DetailRestaurantModel?> getDetailRestaurant(String id) async {
    Uri uriUrl = Uri.parse("$url/detail/$id");
    Response result = await get(uriUrl);
    if (result.statusCode == 200 || result.statusCode == 201) {
      Map<String, dynamic> jsonData = json.decode(result.body);
      var detailRestaurant = jsonData['restaurants'];
      DetailRestaurantModel res =
          DetailRestaurantModel.fromJson(detailRestaurant);
      return res;
    }
    return null;
  }
}
