import 'package:get/get.dart';
import 'package:online_store/screens/admin_products_screen.dart';
import 'package:online_store/screens/admin_restaurants_screen.dart';
import 'package:online_store/screens/category_screen.dart';
import 'package:online_store/screens/create_category_screen.dart';
import 'package:online_store/screens/create_product_screen.dart';
import 'package:online_store/screens/create_restaurant_screen.dart';
import 'package:online_store/screens/home_screen.dart';
import 'package:online_store/screens/intro_screen.dart';
import 'package:online_store/screens/login_screen.dart';
import 'package:online_store/screens/product_screen.dart';
import 'package:online_store/screens/receive_code.dart';
import 'package:online_store/screens/admin_restaurant_screen.dart';
import 'package:online_store/screens/restaurant_screen.dart';
import 'package:online_store/screens/search_screen.dart';
import 'package:online_store/screens/signup_screen.dart';
import 'package:online_store/screens/splash_screen.dart';

class AppRoutes {
  static const String splashScreen = '/splash';
  static const String introScreen = '/intro';
  static const String loginScreen = '/login';
  static const String signupScreen = '/signup';
  static const String receiveScreen = '/receive';
  static const String homeScreen = '/home';
  static const String createRestaurantScreen = '/createRestaurant';
  static const String createCategoryScreen = '/createCategory';
  static const String createProductScreen = '/createProduct';
  static const String adminRestaurantsScreen = '/adminRestaurants';
  static const String adminProductScreen = '/adminProduct';
  static const String productScreen = '/product';
  static const String adminRestaurantScreen = '/adminRestaurant';
  static const String restaurantScreen = '/restaurant';
  static const String searchScreen = '/search';
  static const String categoryScreen = '/category';

  static final List<GetPage> getPages = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: introScreen, page: () => const IntroScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: signupScreen, page: () => SignupScreen()),
    GetPage(name: receiveScreen, page: () => const ReceiveCode()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: createRestaurantScreen, page: () => const CreateRestaurantScreen()),
    GetPage(name: createCategoryScreen, page: () => const CreateCategoryScreen()),
    GetPage(name: createProductScreen, page: () => const CreateProductScreen()),
    GetPage(name: adminRestaurantsScreen, page: () => const AdminRestaurantsScreen()),
    GetPage(name: adminProductScreen, page: () => const AdminProductScreen()),
    GetPage(name: searchScreen, page: () => const SearchScreen()),
    GetPage(name: adminRestaurantScreen, page: () => AdminRestaurantScreen()),
    GetPage(name: restaurantScreen, page: () => const RestaurantScreen()),
    GetPage(name: categoryScreen, page: () => CategoryScreen()),
    GetPage(name: productScreen, page: () => ProductScreen()),
  ];
}
