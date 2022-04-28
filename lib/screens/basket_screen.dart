import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/controllers/basket_screen_controller.dart';
import 'package:online_store/models/basket.dart';
import 'package:online_store/models/product.dart';
import 'package:online_store/static_methods.dart';
import 'package:online_store/widgets/base_widget.dart';
import 'package:online_store/widgets/custom_button.dart';
import 'package:online_store/widgets/loading_widget.dart';

import '../constants.dart';

class BasketScreen extends GetView<BasketScreenController> {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'سبد خرید',
          style: kHeaderText,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      child: Obx(
        () => controller.baskets.isEmpty
            ? const Center(
                child: LoadingWidget(),
              )
            : Stack(
                fit: StackFit.expand,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'رستوران ${controller.restaurant.value.title!}',
                        style: kHeaderText.copyWith(
                          fontSize: 22,
                          color: kAmberColor,
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          physics: const BouncingScrollPhysics(),
                          itemCount: controller.baskets.length,
                          itemBuilder: (context, index) {
                            Product product = controller.products[index];
                            Basket basket = controller.baskets[index];
                            int sum = basket.count! * product.price!;
                            return ListTile(
                              leading: ClipRRect(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                child: Image.asset(
                                  foodImg[StaticMethods.random.nextInt(6)],
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
                                '${basket.count} عدد',
                                style: kTextStyle,
                              ),
                              contentPadding: EdgeInsets.zero,
                              trailing: Column(
                                children: [
                                  Text(
                                    sum.toString(),
                                    style: kHeaderText.copyWith(
                                      fontSize: 25,
                                      color: kBlackColor,
                                    ),
                                  ),
                                  Text(
                                    'ریال',
                                    style: kHeaderText.copyWith(
                                      fontSize: 20,
                                      color: kBlackColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider(
                              endIndent: 40,
                              indent: 40,
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    bottom: 20,
                    width: Get.width - 40,
                    child: CustomButton(
                      text: 'پرداخت',
                      onTapped: () {
                        StaticMethods.bottomSheetCheckout(
                          controller.basketSum.value.toString(),
                          controller.checkoutController,
                          () {
                            controller.checkout();
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
