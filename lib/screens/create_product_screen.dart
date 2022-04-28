import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/controllers/product_controller.dart';
import 'package:online_store/widgets/base_widget.dart';
import 'package:online_store/widgets/custom_button.dart';
import 'package:online_store/widgets/my_text_field.dart';

import '../constants.dart';

class CreateProductScreen extends GetView<ProductController> {
  const CreateProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'ایجاد محصول جدید',
          style: kHeaderText,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              'نام',
              style: kTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            MyTextField(controller: controller.nameController),
            const SizedBox(
              height: 30,
            ),
            Text(
              'قیمت',
              style: kTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            MyTextField(controller: controller.priceController),
            const SizedBox(
              height: 30,
            ),
            Text(
              'دسته بندی محصول',
              style: kTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: Obx(
                () => SizedBox(
                  width: 100,
                  child: DropdownButton(
                    isExpanded: true,
                    value: controller.dropdownCategoryValue.value,
                    style: kTextStyle.copyWith(fontFamily: 'Vazir'),
                    borderRadius: BorderRadius.circular(10),
                    elevation: 4,
                    underline: Container(
                      height: 2,
                      color: kAmberColor,
                    ),
                    items: controller.dropdownCategoryList,
                    onChanged: (int? value) {
                      controller.dropdownCategoryValue.value = value!;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'انتخاب رستوران',
              style: kTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: Obx(
                () => SizedBox(
                  width: 200,
                  child: DropdownButton(
                    isExpanded: true,
                    value: controller.dropdownRestaurantValue.value,
                    style: kTextStyle.copyWith(fontFamily: 'Vazir'),
                    borderRadius: BorderRadius.circular(10),
                    elevation: 4,
                    underline: Container(
                      height: 2,
                      color: kAmberColor,
                    ),
                    items: controller.dropdownRestaurantList,
                    onChanged: (int? value) {
                      controller.dropdownRestaurantValue.value = value!;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            CustomButton(
              text: 'ارسال',
              onTapped: () {
                controller.createProduct();
              },
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
