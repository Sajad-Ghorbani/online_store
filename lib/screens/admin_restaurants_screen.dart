import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/controllers/restaurant_controller.dart';
import 'package:online_store/models/restaurant.dart';
import 'package:online_store/services/app_routes.dart';
import 'package:online_store/widgets/base_widget.dart';

import '../constants.dart';

class AdminRestaurantsScreen extends GetView<RestaurantController> {
  const AdminRestaurantsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'لیست رستوران ها',
          style: kHeaderText,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      child: Obx(
        () {
          return ListView.separated(
            itemCount: controller.restList.length,
            itemBuilder: (context, index) {
              Restaurant rest = controller.restList[index];
              return ListTile(
                leading: Image.network(
                  '$kBaseUrl/img/${rest.image}',
                  width: 60,
                  height: 60,
                  fit: BoxFit.cover,
                ),
                title: Text(
                  rest.title ?? '',
                  style: kHeaderText.copyWith(
                    fontSize: 20,
                    fontFamily: 'Yekan',
                  ),
                ),
                subtitle: Text(
                  rest.description ?? '',
                  style: kTextStyle.copyWith(
                    fontFamily: 'Vazir',
                    fontSize: 14,
                  ),
                ),
                onTap: () {
                  Get.toNamed(AppRoutes.adminRestaurantScreen, arguments: rest);
                },
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          );
        },
      ),
    );
  }
}
