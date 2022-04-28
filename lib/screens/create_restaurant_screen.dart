import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/constants.dart';
import 'package:online_store/controllers/restaurant_controller.dart';
import 'package:online_store/widgets/base_widget.dart';
import 'package:online_store/widgets/custom_button.dart';
import 'package:online_store/widgets/my_text_field.dart';

class CreateRestaurantScreen extends GetView<RestaurantController> {
  const CreateRestaurantScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'ایجاد رستوران جدید',
          style: kHeaderText,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
              'آدرس',
              style: kTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            MyTextField(controller: controller.addressController),
            const SizedBox(
              height: 30,
            ),
            Text(
              'توضیحات',
              style: kTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            MyTextField(
              controller: controller.descController,
              maxLines: 3,
              height: null,
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'نمایش برای اسلاید در صفحه اصلی',
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
                    value: controller.isSlide.value,
                    style: kTextStyle.copyWith(fontFamily: 'Vazir'),
                    borderRadius: BorderRadius.circular(10),
                    elevation: 4,
                    underline: Container(
                      height: 2,
                      color: kAmberColor,
                    ),
                    items: const [
                      DropdownMenuItem(
                        child: Text('بله'),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text('خیر'),
                        value: 0,
                      ),
                    ],
                    onChanged: (int? value) {
                      controller.isSlide.value = value!;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              'تصویر',
              style: kTextStyle.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                controller.selectImage();
              },
              child: Obx(
                () => Center(
                  child: controller.file.value.path == '-1'
                      ? const CircleAvatar(
                          radius: 40,
                          backgroundColor: kLightYellowColor,
                          child: Icon(
                            Icons.add,
                            size: 36,
                            color: kBlackColor,
                          ),
                        )
                      : Image.file(
                          controller.file.value,
                          width: Get.width,
                          height: 200,
                          fit: BoxFit.cover,
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
                controller.sendRestaurant();
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
