import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/controllers/home_screen_controller.dart';
import 'package:online_store/models/restaurant.dart';

import '../constants.dart';

class SliderWidget extends GetView<HomeScreenController> {
  const SliderWidget({Key? key, required this.restaurant}) : super(key: key);
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        onTap: () {
          controller.getRestaurant(restaurant.id!);
        },
        child: Stack(
          children: <Widget>[
            Image.network('$kBaseUrl/img/${restaurant.image}',
                fit: BoxFit.cover, width: Get.width),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.black,
                      Colors.transparent,
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                child: Text(
                  restaurant.title!,
                  style: kHeaderText.copyWith(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
