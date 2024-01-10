import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:resto_fav_apps/data/models/response_restaurant_model.dart';

class BaseApi {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<ResponseRestaurantModel> getList() async {
    final response = await http.get(
      Uri.parse("${_baseUrl}list"),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      debugPrint('$jsonData resss');
      ResponseRestaurantModel responseRestaurantModel =
          ResponseRestaurantModel.fromJson(jsonData);
      return responseRestaurantModel;
    } else {
      throw ResponseRestaurantModel.fromJson(json.decode(response.body))
          .message;
    }
  }

  Future<ResponseRestaurantModel> getDetailsList(String id) async {
    final response = await http.get(
      Uri.parse("${_baseUrl}detail/$id"),
    );

    debugPrint('$response');
    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint(response.body);
      return ResponseRestaurantModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed Get Detail Restaurant');
    }
  }

  Future<ResponseRestaurantModel> fetchSearch(String searchQuery) async {
    final response = await http.get(
      Uri.parse("${_baseUrl}search?q=$searchQuery"),
    );

    debugPrint('$response');
    if (response.statusCode == 200 || response.statusCode == 201) {
      debugPrint(response.body);
      return ResponseRestaurantModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed Get Detail Restaurant');
    }
  }
}
