import 'dart:io';
import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/constants.dart';
import 'package:online_store/controllers/best_restaurant_controller.dart';
import 'package:online_store/models/basket.dart';
import 'package:online_store/models/category.dart';
import 'package:online_store/models/product.dart';
import 'package:online_store/models/restaurant.dart';
import 'package:online_store/screens/basket_screen.dart';
import 'package:online_store/screens/home_page.dart';
import 'package:online_store/screens/profile_screen.dart';
import 'package:online_store/services/app_routes.dart';
import 'package:online_store/static_methods.dart';
import 'package:online_store/widgets/slider_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'basket_screen_controller.dart';

class HomeScreenController extends GetConnect {
  final Rx<CarouselController> carouselController = CarouselController().obs;
  final Rx<PageController> smoothController = PageController().obs;

  RxInt currentIndex = 0.obs;
  RxInt currentSlide = 0.obs;
  RxInt basketCount = 0.obs;
  RxInt productCount = 0.obs;

  Rx<Restaurant> restaurant = Restaurant().obs;

  RxList<Restaurant> restaurantImageList = <Restaurant>[].obs;
  RxList<Widget> imageSliders = <Widget>[].obs;
  RxList<Category> categories = <Category>[].obs;
  RxList<Product> products = <Product>[].obs;
  RxList<Basket> baskets = <Basket>[].obs;
  late SharedPreferences pref;
  List<Widget> homeWidget = [
    const HomePage(),
    const BasketScreen(),
    const ProfileScreen(),
  ];

  Random random = Random();
  String token = '-1';

  @override
  onInit() {
    super.onInit();
    getToken();
    loadPref();
    getSliderRestaurant();
  }

  loadPref() async {
    pref = await SharedPreferences.getInstance();
  }

  changeIndex(index) {
    currentIndex.value = index;
    if (index == 1) {
      Get.find<BasketScreenController>().getUserBasket();
    }
  }

  getToken() async {
    token = await StaticMethods.getToken();
  }

  getSliderRestaurant() async {
    Response response = await get(
      '$kBaseUrl/api/front',
      headers: {HttpHeaders.authorizationHeader: 'Bearer $token'},
    );
    if (response.body['sliderRestaurants'] != null) {
      for (var item in response.body['sliderRestaurants']) {
        restaurantImageList.add(Restaurant.fromJson(item));
      }
      imageSliders.value = restaurantImageList
          .map(
            (item) => SliderWidget(restaurant: item),
          )
          .toList();
    }
  }

  onChangeSlide(int index, CarouselPageChangedReason reason) {
    currentSlide.value = index;
  }

  onDotClick(int index) {
    currentSlide.value = index;
    carouselController.value.animateToPage(index);
  }

  Future getRestaurant(int id) async {
    products.clear();
    baskets.clear();
    basketCount.value = 0;
    categories.value = [Category(id: 0, name: 'همه')];
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
      for (var item in response.body['categories']) {
        categories.add(Category.fromJson(item));
      }
      for (var item in response.body['baskets']) {
        baskets.add(Basket.fromJson(item));
      }
      for (var item in baskets) {
        basketCount.value += item.count!;
      }

      Get.toNamed(AppRoutes.restaurantScreen);
    }
  }

  currentCategory(int restaurantId, int categoryId) async {
    products.clear();
    Response response = await get(
      '$kBaseUrl/api/front/restaurant/$restaurantId?category=$categoryId',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    if (response.statusCode! < 300) {
      for (var item in response.body['products']) {
        products.add(Product.fromJson(item));
      }
    }
  }

  sendAddToCart(int productId, int restaurantId) async {
    pref.setInt('restaurantId', restaurantId);
    await get(
      '$kBaseUrl/api/basket/add/$productId/$restaurantId',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    Response response = await get(
      '$kBaseUrl/api/front/restaurant/$restaurantId',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    baskets.clear();
    basketCount.value = 0;
    for (var item in response.body['baskets']) {
      baskets.add(Basket.fromJson(item));
    }
    for (var item in baskets) {
      basketCount.value += item.count!;
    }
  }

  addToCart(int productId, int restaurantId) async {
    if (token == '-1') {
      StaticMethods.errorSnackBar('خطا', 'شما دسترسی به این عملیات را ندارید.');
      return;
    } //
    else {
      int restId = pref.getInt('restaurantId') ?? -1;
      if (restId == -1) {
        sendAddToCart(productId, restaurantId);
      } //
      else {
        if (restId == restaurantId) {
          sendAddToCart(productId, restaurantId);
        } //
        else {
          Restaurant rest = Get.find<BestRestaurantsController>()
              .bestList
              .where((p0) => p0.id == restId)
              .first;
          StaticMethods.errorDialogRestaurant(
            restaurant: rest,
            onChangeRestaurant: () {
              Get.back();
              deleteBasket(rest.id!);
              sendAddToCart(productId, restaurantId);
            },
          );
        }
      }
    }
  }

  deleteBasket(int restaurantId) async {
    await pref.remove('restaurantId');
    Response response = await get(
      '$kBaseUrl/api/front/restaurant/$restaurantId',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );
    List<Basket> list = [];
    for (var item in response.body['baskets']) {
      list.add(Basket.fromJson(item));
    }
    for (var item in list) {
      await get(
        '$kBaseUrl/api/basket/delete/${item.id}',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
    }
  }

  minusFromCart(int productId, int restaurantId) async {
    if (token == '-1') {
      StaticMethods.errorSnackBar('خطا', 'شما دسترسی به این عملیات را ندارید.');
      return;
    } //
    else {
      Response response = await get(
        '$kBaseUrl/api/front/restaurant/$restaurantId',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
      );
      List<Basket> list = [];
      for (var item in response.body['baskets']) {
        list.add(Basket.fromJson(item));
      }
      for (var item in list) {
        if (item.productId == productId) {
          if (item.count == 1) {
            await get(
              '$kBaseUrl/api/basket/delete/${item.id}',
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
            );
          } //
          else {
            await get(
              '$kBaseUrl/api/basket/min/$productId/$restaurantId',
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              },
            );
          }
          Response response = await get(
            '$kBaseUrl/api/front/restaurant/$restaurantId',
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
            },
          );
          baskets.clear();
          basketCount.value = 0;
          for (var item in response.body['baskets']) {
            baskets.add(Basket.fromJson(item));
          }
          for (var item in baskets) {
            basketCount.value += item.count!;
          }
          if(baskets.isEmpty){
            await pref.remove('restaurantId');
          }
        }
      }
    }
  }

  bool showMinusIcon(Product product) {
    for (var item in baskets) {
      if (item.productId == product.id) {
        if (item.count! > 0) {
          return true;
        }
      }
    }
    return false;
  }
}
