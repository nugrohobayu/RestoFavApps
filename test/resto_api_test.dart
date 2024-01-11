import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:resto_fav_apps/data/models/response_restaurant_model.dart';
import 'package:resto_fav_apps/data/services/base_api.dart';

@GenerateMocks([http.Client])
void main() {
  group('Testing API Restaurant', () {
    test('if http call complete success return list of restaurant', () async {
      final client = MockClient((request) async {
        final response = {
          "error": false,
          "message": "success",
          "count": 20,
          "restaurants": []
        };
        return Response(json.encode(response), 200);
      });
      expect(
        await BaseApi(client).getList(),
        isA<ResponseRestaurantModel>(),
      );
    });
  });
}
