import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/constants.dart';
import 'package:online_store/controllers/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  SplashScreenController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAmberColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/logo.png'),
            const SizedBox(
              height: 50,
            ),
            Image.asset('assets/images/tosegar.png'),
            const SizedBox(
              height: 10,
            ),
            Image.asset('assets/images/app_name.png'),
          ],
        ),
      ),
    );
  }
}
