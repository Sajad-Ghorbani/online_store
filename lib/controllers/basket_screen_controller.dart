import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:online_store/controllers/home_screen_controller.dart';
import 'package:online_store/models/basket.dart';
import 'package:online_store/models/product.dart';
import 'package:online_store/models/restaurant.dart';
import 'package:online_store/models/wallet.dart';
import 'package:online_store/static_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants.dart';

class BasketScreenController extends GetConnect {
  Rx<Restaurant> restaurant = Restaurant().obs;
  RxList<Product> products = <Product>[].obs;
  RxList<Basket> baskets = <Basket>[].obs;
  late SharedPreferences pref;
  TextEditingController checkoutController = TextEditingController();
  RxInt basketSum = 0.obs;

  loadPref() async {
    pref = await SharedPreferences.getInstance();
  }

  getUserBasket() async {
    await loadPref();
    baskets.clear();
    products.clear();
    String token = pref.getString('token') ?? '-1';
    int id = pref.getInt('restaurantId') ?? -1;
    Response response = await get(
      '$kBaseUrl/api/front/restaurant/$id',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode! < 300) {
      restaurant.value = Restaurant.fromJson(response.body['restaurant']);
      for (var item in response.body['products']) {
        products.add(Product.fromJson(item));
      }
      for (var item in response.body['baskets']) {
        baskets.add(Basket.fromJson(item));
      }
      getSum(baskets, products);
    }
  }

  getSum(List<Basket> baskets, List<Product> products) async {
    int productSum = 0;
    int sum = 0;
    for (var item in baskets) {
      for (var product in products) {
        if (item.productId == product.id) {
          productSum = item.count! * product.price!;
          sum += productSum;
        }
      }
    }
    basketSum.value = sum;
  }

  checkout() async {
    String price = checkoutController.text;
    int userId = pref.getInt('user_id') ?? -1;
    String token = pref.getString('token') ?? '-1';
    Response response = await get(
      '$kBaseUrl/api/front/wallet/$price',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    checkoutController.clear();
    if (response.statusCode! < 300) {
      Wallet wallet = Wallet.fromJson(response.body);
      if (int.parse(wallet.price!) >= basketSum.value) {
        await get(
          '$kBaseUrl/api/basket/checkout/$userId',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
        ).then(
          (value) {
            if (value.body == 'done') {
              Get.back();
              Get.find<HomeScreenController>().currentIndex.value = 0;
              pref.remove('restaurantId');
              StaticMethods.successDialog('خرید شما با موفقیت انجام شد.');
            }
          },
        );
      } //
      else {
        StaticMethods.unSuccessfulDialog(
            'مبلغ کیف پول شما از مبلغ خریدتان کمتر می باشد.');
      }
    }
  }
}
