import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/constants.dart';
import 'package:online_store/controllers/best_restaurant_controller.dart';
import 'package:online_store/controllers/home_screen_controller.dart';
import 'package:online_store/models/restaurant.dart';

class NewRestaurantWidget extends GetView<BestRestaurantsController> {
  const NewRestaurantWidget({Key? key}) : super(key: key);

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
                'جدیدترین رستوران ها',
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
          height: 230,
          child: Obx(
            () => ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: controller.newList.length,
              itemBuilder: (context, index) {
                Restaurant restaurant = controller.newList[index];
                return Container(
                  margin: EdgeInsets.only(
                    right:
                        controller.newList.first.id == restaurant.id ? 0 : 5,
                    left: controller.newList.last.id == restaurant.id ? 0 : 5,
                  ),
                  child: InkWell(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    onTap: () {
                      Get.find<HomeScreenController>()
                          .getRestaurant(restaurant.id!);
                    },
                    child: Container(
                      width: 160,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.5,
                        ),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            child: Image.network(
                              '$kBaseUrl/img/${restaurant.image}',
                              height: 120,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            restaurant.title!,
                            style: kTextStyle.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            restaurant.description!,
                            style: kTextStyle,
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 150,
                            child: Row(
                              children: [
                                const Text(
                                  'امتیاز',
                                  style: kTextStyle,
                                ),
                                const Spacer(),
                                Container(
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: kAmberColor),
                                  padding: const EdgeInsets.all(4),
                                  child: Text(
                                    '${(10 - index) / 2 - 0.2}',
                                    style: kTextStyle.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
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
