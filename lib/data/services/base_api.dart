import 'dart:convert';

import 'package:http/http.dart' show Client;
import 'package:resto_fav_apps/data/models/response_restaurant_model.dart';

class BaseApi {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  final Client client;
  BaseApi(this.client);

  Future<ResponseRestaurantModel> getList() async {
    final response = await client.get(
      Uri.parse("${_baseUrl}list"),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      ResponseRestaurantModel responseRestaurantModel =
          ResponseRestaurantModel.fromJson(jsonData);
      return responseRestaurantModel;
    } else {
      throw ResponseRestaurantModel.fromJson(json.decode(response.body))
          .message;
    }
  }

  Future<ResponseRestaurantModel> getDetailsList(String id) async {
    final response = await client.get(
      Uri.parse("${_baseUrl}detail/$id"),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return ResponseRestaurantModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed Get Detail Restaurant');
    }
  }

  Future<ResponseRestaurantModel> fetchSearch(String searchQuery) async {
    final response = await client.get(
      Uri.parse("${_baseUrl}search?q=$searchQuery"),
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      ResponseRestaurantModel responseRestaurantModel =
          ResponseRestaurantModel.fromJson(jsonData);
      return responseRestaurantModel;
    } else {
      throw Exception('Failed Get Detail Restaurant');
    }
  }
}
