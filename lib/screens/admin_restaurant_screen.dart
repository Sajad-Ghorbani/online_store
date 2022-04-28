import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/models/restaurant.dart';
import 'package:online_store/widgets/base_widget.dart';

import '../constants.dart';

class AdminRestaurantScreen extends StatelessWidget {
  AdminRestaurantScreen({Key? key}) : super(key: key);

  Restaurant restaurant = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'رستوران ${restaurant.title}',
          style: kHeaderText,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: kBlackColor,
          ),
        ),
      ),
      padding: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            '$kBaseUrl/img/${restaurant.image}',
            height: 200,
            fit: BoxFit.cover,
            width: Get.width,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'نام',
                  style: kHeaderText.copyWith(
                    fontFamily: 'Vazir',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  restaurant.title ?? '',
                  style: kTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'آدرس',
                  style: kHeaderText.copyWith(
                    fontFamily: 'Vazir',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  restaurant.address ?? '',
                  style: kTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'توضیحات',
                  style: kHeaderText.copyWith(
                    fontFamily: 'Vazir',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  restaurant.description ?? '',
                  style: kTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
