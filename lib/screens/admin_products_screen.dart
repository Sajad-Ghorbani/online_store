import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/controllers/product_controller.dart';
import 'package:online_store/models/product.dart';
import 'package:online_store/services/app_routes.dart';
import 'package:online_store/widgets/base_widget.dart';

import '../constants.dart';

class AdminProductScreen extends GetView<ProductController> {
  const AdminProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'لیست محصولات',
          style: kHeaderText,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      child: Obx(
        () {
          return ListView.separated(
            itemCount: controller.productList.length,
            itemBuilder: (context, index) {
              Product product = controller.productList[index];
              String? productCategory = controller.categoryList
                  .where((category) => category.id == product.categoryId)
                  .first
                  .name;
              return ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: kAmberColor,
                  child: Text(
                    (index + 1).toString(),
                    style: kHeaderText.copyWith(fontSize: 25),
                  ),
                ),
                title: Text(
                  product.name ?? '',
                  style: kHeaderText.copyWith(
                    fontSize: 20,
                    fontFamily: 'Yekan',
                  ),
                ),
                subtitle: Text(
                  productCategory!,
                  style: kTextStyle.copyWith(
                    fontFamily: 'Vazir',
                    fontSize: 14,
                  ),
                ),
                trailing: Text(
                  'قیمت: ${product.price} تومان',
                  style: kTextStyle.copyWith(
                    fontFamily: 'Vazir',
                    fontSize: 14,
                  ),
                ),
                onTap: () {
                  Get.toNamed(
                    AppRoutes.productScreen,
                    arguments: product,
                    parameters: {'categoryName': productCategory},
                  );
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
