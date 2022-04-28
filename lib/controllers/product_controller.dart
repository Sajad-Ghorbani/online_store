import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/models/category.dart';
import 'package:online_store/models/product.dart';
import 'package:online_store/models/restaurant.dart';
import 'package:dio/dio.dart';

import '../constants.dart';
import '../static_methods.dart';

class ProductController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  String token = '-1';
  RxList<Product> productList = <Product>[].obs;
  RxList<Category> categoryList = <Category>[].obs;
  RxList<Restaurant> restaurantList = <Restaurant>[].obs;
  RxInt dropdownCategoryValue = 1.obs;
  RxInt dropdownRestaurantValue = 2.obs;
  RxList<DropdownMenuItem<int>> dropdownCategoryList =
      <DropdownMenuItem<int>>[].obs;
  RxList<DropdownMenuItem<int>> dropdownRestaurantList =
      <DropdownMenuItem<int>>[].obs;

  Future<void> getToken() async {
    token = await StaticMethods.getToken();
  }

  @override
  onInit() {
    super.onInit();
    getToken();
    getProductList();
    getCategoryList();
    getRestaurantList();
  }

  getProductList() async {
    if (token == '-1') {
      StaticMethods.errorSnackBar('خطا', 'شما دسترسی به این عملیات را ندارید.');
      return;
    } //
    else {
      Dio myDio = Dio();
      myDio
          .get(
        '$kBaseUrl/api/admin/products',
        options: Options(
          method: 'GEt',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
          responseType: ResponseType.json,
        ),
      )
          .then(
        (response) {
          if (response.statusCode! < 300) {
            for (var item in response.data['data']) {
              productList.add(
                Product.fromJson(item),
              );
            }
          } //
          else {
            StaticMethods.errorSnackBar(
                'خطا', 'شما دسترسی به این عملیات را ندارید.');
            return;
          }
        },
      );
    }
  }

  getCategoryList() async {
    if (token == '-1') {
      StaticMethods.errorSnackBar('خطا', 'شما دسترسی به این عملیات را ندارید.');
      return;
    } //
    else {
      Dio myDio = Dio();
      myDio
          .get(
        '$kBaseUrl/api/admin/categories',
        options: Options(
          method: 'GEt',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
          responseType: ResponseType.json,
        ),
      )
          .then(
        (response) {
          if (response.statusCode! < 300) {
            for (var item in response.data['data']) {
              categoryList.add(
                Category.fromJson(item),
              );
            }
            for (int i = 0; i < categoryList.length; i++) {
              var dropdownItem = DropdownMenuItem(
                child: Text(categoryList[i].name!),
                value: i + 1,
              );
              dropdownCategoryList.add(dropdownItem);
            }
          } //
          else {
            StaticMethods.errorSnackBar(
                'خطا', 'شما دسترسی به این عملیات را ندارید.');
            return;
          }
        },
      );
    }
  }

  getRestaurantList() async {
    if (token == '-1') {
      StaticMethods.errorSnackBar('خطا', 'شما دسترسی به این عملیات را ندارید.');
      return;
    } //
    else {
      Dio myDio = Dio();
      myDio
          .get(
        '$kBaseUrl/api/admin/restaurants',
        options: Options(
          method: 'GEt',
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
          },
          responseType: ResponseType.json,
        ),
      )
          .then(
        (response) {
          if (response.statusCode! < 300) {
            for (var item in response.data['data']) {
              restaurantList.add(
                Restaurant.fromJson(item),
              );
            }
            for (var item in restaurantList) {
              var dropdownItem = DropdownMenuItem(
                child: Text(item.title!),
                value: item.id,
              );
              dropdownRestaurantList.add(dropdownItem);
            }
          } //
          else {
            StaticMethods.errorSnackBar(
                'خطا', 'شما دسترسی به این عملیات را ندارید.');
            return;
          }
        },
      );
    }
  }

  createProduct() async {
    if (token == '-1') {
      StaticMethods.errorSnackBar('خطا', 'شما دسترسی به این عملیات را ندارید.');
      return;
    } //
    else {
      String name = nameController.text;
      String price = priceController.text;
      int categoryId = dropdownCategoryValue.value;
      int restaurantId = dropdownRestaurantValue.value;
      Map<String, dynamic> newMap = {};
      newMap['name'] = name;
      newMap['price'] = price;
      newMap['category_id'] = categoryId;
      newMap['restaurant_id'] = restaurantId;
      if (StaticMethods.validateName(name, 'نام محصول') &&
          StaticMethods.validateName(price, 'قیمت')) {
        Dio myDio = Dio();
        myDio
            .post('$kBaseUrl/api/admin/products',
                data: newMap,
                options: Options(
                    method: 'POST',
                    headers: {
                      HttpHeaders.authorizationHeader: 'Bearer $token',
                    },
                    responseType: ResponseType.json))
            .then((response) {
          print(response.statusCode);
          print(response.data);
          if (response.statusCode! < 300) {
            StaticMethods.successDialog('اطلاعات شما با موفقیت ذخیره شد.');
            nameController.clear();
            priceController.clear();
            dropdownCategoryValue.value = 1;
            dropdownRestaurantValue.value = 2;
          } //
        });
      }
    }
  }
}
