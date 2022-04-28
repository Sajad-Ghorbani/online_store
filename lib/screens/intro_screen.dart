import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/services/app_routes.dart';
import 'package:online_store/widgets/custom_button.dart';

import '../constants.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            foregroundDecoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Colors.transparent,
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.center,
              ),
            ),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/start pic.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'خوش آمدید',
                    style: kHeaderText.copyWith(
                      color: Colors.white,
                      fontSize: 48,
                    ),
                  ),
                  Text(
                    'به فروشگاه ما',
                    style: kHeaderText.copyWith(
                      color: Colors.white,
                      fontSize: 48,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'ما اینجاییم تا شما رو در کمترین زمان به خواسته هاتون برسونیم.',
                    style: kTextStyle.copyWith(
                      color: Colors.grey.shade300,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                    text: 'شروع کنید',
                    onTapped: () {
                      Get.offAllNamed(AppRoutes.homeScreen);
                    },
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
