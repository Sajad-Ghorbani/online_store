import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/controllers/home_screen_controller.dart';
import 'package:online_store/models/product.dart';
import 'package:online_store/widgets/base_widget.dart';
import 'package:online_store/widgets/loading_widget.dart';

import '../constants.dart';

class RestaurantScreen extends GetView<HomeScreenController> {
  const RestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
            '$kBaseUrl/img/${controller.restaurant.value.image}',
          ),
          alignment: Alignment.topCenter,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.8),
              Colors.transparent,
            ],
            begin: Alignment.topCenter,
            end: Alignment.center,
          ),
        ),
        child: SafeArea(
          child: BaseWidget(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              leading: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Material(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    color: Colors.grey.withOpacity(0.5),
                    child: InkWell(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      onTap: () {
                        Get.back();
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: kBlackColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                SizedBox(
                  height: 60,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Material(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(30)),
                        color: Colors.grey,
                        child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30)),
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.all(12),
                            child: Icon(
                              Icons.shopping_basket_rounded,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 5,
                        right: 0,
                        child: Container(
                          height: 20,
                          width: 20,
                          decoration: const BoxDecoration(
                            color: kAmberColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Obx(
                              () => Text(
                                controller.basketCount.value.toString(),
                                style: kTextStyle.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: kBlackColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
            padding: 0,
            child: Container(
              margin: const EdgeInsets.only(top: 30),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'رستوران ${controller.restaurant.value.title}',
                    style: kHeaderText,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: controller.categories.map((category) {
                        return InkWell(
                          onTap: () {
                            controller.currentCategory(
                              controller.restaurant.value.id!,
                              category.id!,
                            );
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 5),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            decoration: const BoxDecoration(
                                color: kLightYellowColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: Text(category.name!),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const Divider(),
                  Obx(
                    () => Expanded(
                      child: controller.products.isEmpty
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10)),
                                    child: Image.asset(
                                      foodImg[controller.random.nextInt(6)],
                                    ),
                                  ),
                                  title: Text(
                                    product.name!,
                                    style: kTextStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  subtitle: Text(
                                    product.price.toString(),
                                    style: kTextStyle,
                                  ),
                                  contentPadding: EdgeInsets.zero,
                                  trailing: SizedBox(
                                    width: 110,
                                    child: Obx(
                                      () => Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              controller.addToCart(
                                                product.id!,
                                                controller.restaurant.value.id!,
                                              );
                                            },
                                            icon: const Icon(Icons
                                                .add_circle_outline_rounded),
                                            color: kGreenColor,
                                          ),
                                          Visibility(
                                            visible: controller
                                                .showMinusIcon(product),
                                            child: IconButton(
                                              onPressed: () {
                                                controller.minusFromCart(
                                                  product.id!,
                                                  controller
                                                      .restaurant.value.id!,
                                                );
                                              },
                                              color: Colors.redAccent,
                                              icon: const Icon(Icons
                                                  .remove_circle_outline_rounded),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
