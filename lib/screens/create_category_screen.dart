import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/controllers/category_screen_controller.dart';
import 'package:online_store/widgets/base_widget.dart';
import 'package:online_store/widgets/custom_button.dart';
import 'package:online_store/widgets/my_text_field.dart';

import '../constants.dart';

class CreateCategoryScreen extends GetView<CategoryScreenController> {
  const CreateCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'ایجاد دسته بندی جدید',
          style: kHeaderText,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 60,),
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
            'توضیحات',
            style: kTextStyle.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          MyTextField(controller: controller.descController),
          const SizedBox(
            height: 60,
          ),
          CustomButton(
            text: 'ارسال',
            onTapped: () {
              controller.sendCategory();
            },
          ),
          const SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}
