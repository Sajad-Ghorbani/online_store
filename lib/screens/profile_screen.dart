import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/controllers/user_controller.dart';
import 'package:online_store/widgets/base_widget.dart';
import 'package:online_store/widgets/custom_button.dart';

import '../constants.dart';

class ProfileScreen extends GetView<UserController> {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: Obx(
          () => Row(
            children: [
              const CircleAvatar(
                backgroundImage: AssetImage('assets/images/profile.jpg'),
                radius: 25,
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.name.value,
                    style: kHeaderText.copyWith(color: kBlackColor),
                  ),
                  Text(
                    controller.email.value,
                    style: kTextStyle,
                  ),
                ],
              ),
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      padding: 0,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: kLightGreyColor),
                bottom: BorderSide(color: kLightGreyColor),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.bookmark_border),
              title: Text(
                'رستوران های ذخیره شده',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.navigate_next_rounded),
              onTap: () {},
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: kLightGreyColor),
                bottom: BorderSide(color: kLightGreyColor),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.payment),
              title: Text(
                'روش های پرداخت',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.navigate_next_rounded),
              onTap: () {},
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: kLightGreyColor),
                bottom: BorderSide(color: kLightGreyColor),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.favorite_border_rounded),
              title: Text(
                'لیست مورد علاقه ها',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.navigate_next_rounded),
              onTap: () {},
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: kLightGreyColor),
                bottom: BorderSide(color: kLightGreyColor),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.location_on_outlined),
              title: Text(
                'آدرس های من',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.navigate_next_rounded),
              onTap: () {},
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: kLightGreyColor),
                bottom: BorderSide(color: kLightGreyColor),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.history),
              title: Text(
                'سوابق خرید',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.navigate_next_rounded),
              onTap: () {},
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: kLightGreyColor),
                bottom: BorderSide(color: kLightGreyColor),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.help_outline_rounded),
              title: Text(
                'ارتباط با پشتیبانی',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.navigate_next_rounded),
              onTap: () {},
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: kLightGreyColor),
                bottom: BorderSide(color: kLightGreyColor),
              ),
            ),
            child: ListTile(
              leading: const Icon(Icons.info_outline_rounded),
              title: Text(
                'درباره ما',
                style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              trailing: const Icon(Icons.navigate_next_rounded),
              onTap: () {},
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomButton(
              text: 'خروج از حساب',
              onTapped: () {
                controller.logout();
              },
              color: kLightGreyColor,
              splashColor: Colors.grey,
              fontColor: kAmberColor,
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 20,),
        ],
      ),
    );
  }
}
