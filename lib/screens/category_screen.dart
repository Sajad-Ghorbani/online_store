import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/controllers/best_restaurant_controller.dart';
import 'package:online_store/controllers/home_screen_controller.dart';
import 'package:online_store/models/category.dart';
import 'package:online_store/models/product.dart';
import 'package:online_store/widgets/base_widget.dart';
import 'package:online_store/widgets/loading_widget.dart';

import '../constants.dart';

class CategoryScreen extends GetView<BestRestaurantsController> {
  CategoryScreen({Key? key}) : super(key: key);

  Category category = Get.arguments;
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          category.name!,
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
      child: Obx(
        () => controller.products.isEmpty
            ? const Center(
                child: LoadingWidget(),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  Product product = controller.products[index];
                  return ListTile(
                    leading: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(foodImg[random.nextInt(6)]),
                    ),
                    title: Text(
                      product.name!,
                      style: kTextStyle.copyWith(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    subtitle: Text(
                      product.price.toString(),
                      style: kTextStyle,
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        Get.find<HomeScreenController>()
                            .addToCart(product.id!, product.restaurantId!);
                      },
                      icon: const Icon(Icons.add),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
