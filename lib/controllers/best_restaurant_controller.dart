import 'dart:io';

import 'package:get/get.dart';
import 'package:online_store/constants.dart';
import 'package:online_store/models/category.dart';
import 'package:online_store/models/product.dart';
import 'package:online_store/models/restaurant.dart';
import 'package:online_store/static_methods.dart';

class BestRestaurantsController extends GetConnect {
  RxList<Restaurant> bestList = <Restaurant>[].obs;
  RxList<Restaurant> newList = <Restaurant>[].obs;
  RxList<Category> categories = <Category>[].obs;
  RxList<Product> products = <Product>[].obs;
  String token = '-1';

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getToken();
    getFrontApis();
  }

  getToken() async {
    token = await StaticMethods.getToken();
  }

  getFrontApis() async {
    Response response = await get(
      '$kBaseUrl/api/front',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode! < 300) {
      for (var item in response.body['bestRestaurants']) {
        bestList.add(Restaurant.fromJson(item));
      }
      for (var item in response.body['categories']) {
        categories.add(Category.fromJson(item));
      }
      for (var item in response.body['restaurants']) {
        newList.add(Restaurant.fromJson(item));
      }
    }
  }

  getProductOfCategory(int id)async{
    products.clear();
    Response response = await get(
      '$kBaseUrl/api/front/category/$id',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode! < 300) {
      for (var item in response.body) {
        products.add(Product.fromJson(item));
      }
    }
  }
}
