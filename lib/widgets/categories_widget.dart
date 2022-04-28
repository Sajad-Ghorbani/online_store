import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/controllers/best_restaurant_controller.dart';
import 'package:online_store/models/category.dart';
import 'package:online_store/services/app_routes.dart';

import '../constants.dart';

class CategoriesWidget extends GetView<BestRestaurantsController> {
  const CategoriesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'دسته بندی ها',
                style: kHeaderText.copyWith(fontSize: 20),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'مشاهده همه',
                  style: kHeaderText.copyWith(
                    color: kAmberColor,
                    fontSize: 20,
                  ),
                ),
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: Obx(
            () => ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                Category category = controller.categories[index];
                return Container(
                  margin: EdgeInsets.only(
                    right: controller.bestList.first.id == category.id ? 0 : 5,
                    left: controller.bestList.last.id == category.id ? 0 : 5,
                  ),
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    onTap: () {
                      controller.getProductOfCategory(category.id!);
                      Get.toNamed(AppRoutes.categoryScreen,arguments: category);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: colors[index],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(15)),
                      ),
                      width: 200,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(foodImg[index]),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            category.name!,
                            style: kTextStyle.copyWith(
                                fontWeight: FontWeight.bold),
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
    );
  }
}
