import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/models/restaurant.dart';

import '../constants.dart';
import '../static_methods.dart';

class SearchController extends GetConnect {
  TextEditingController searchController = TextEditingController();
  RxList<Restaurant> restList = <Restaurant>[].obs;

  Random random = Random();

  search() async {
    String token = await StaticMethods.getToken();
    FocusManager.instance.primaryFocus?.unfocus();
    restList.clear();
    String text = searchController.text;
    if (text.trim().isEmpty) {
      //pass
    } //
    else {
      Response response = await get(
        '$kBaseUrl/api/restaurants/search/$text',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
      if (response.body['data'].isNotEmpty) {
        for (var item in response.body['data']) {
          restList.add(Restaurant.fromJson(item));
        }
      } //
      else {
        StaticMethods.errorSnackBar(
            'خطا', 'هیچ پاسخی برای شما از سمت سرور دریافت نشد.');
      }
    }
  }
}
