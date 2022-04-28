import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/controllers/Bindings/app_binding.dart';
import 'package:online_store/services/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Online Market',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white
      ),
      locale: const Locale('fa','IR'),
      initialBinding: AppBinding(),
      getPages: AppRoutes.getPages,
      initialRoute: AppRoutes.splashScreen,
      defaultTransition: Transition.rightToLeftWithFade,
      transitionDuration: const Duration(milliseconds: 200),
    );
  }
}
