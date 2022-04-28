import 'package:get/get.dart';
import 'package:online_store/controllers/basket_screen_controller.dart';
import 'package:online_store/controllers/best_restaurant_controller.dart';
import 'package:online_store/controllers/category_screen_controller.dart';
import 'package:online_store/controllers/home_screen_controller.dart';
import 'package:online_store/controllers/product_controller.dart';
import 'package:online_store/controllers/restaurant_controller.dart';
import 'package:online_store/controllers/search_controller.dart';
import 'package:online_store/controllers/splash_screen_controller.dart';
import 'package:online_store/controllers/user_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
    Get.lazyPut<RestaurantController>(() => RestaurantController(),
        fenix: true);
    Get.lazyPut<ProductController>(() => ProductController(), fenix: true);
    Get.lazyPut<CategoryScreenController>(() => CategoryScreenController(),
        fenix: true);
    Get.lazyPut<HomeScreenController>(() => HomeScreenController(),
        fenix: true);
    Get.lazyPut<BasketScreenController>(() => BasketScreenController(),
        fenix: true);
    Get.lazyPut<SearchController>(() => SearchController(), fenix: true);
    Get.lazyPut<BestRestaurantsController>(() => BestRestaurantsController(),
        fenix: true);
    Get.lazyPut<UserController>(() => UserController(), fenix: true);
    Get.lazyPut<UserController>(() => UserController(),
        tag: 'login', fenix: true);
    Get.lazyPut<UserController>(() => UserController(),
        tag: 'signup', fenix: true);
  }
}
