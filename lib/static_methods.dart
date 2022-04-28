import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/models/restaurant.dart';
import 'package:online_store/widgets/custom_button.dart';
import 'package:online_store/widgets/my_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class StaticMethods {
  /// Use random in app
  static Random random = Random();

  /// show the custom snackBar for errors in app
  static void errorSnackBar(String title, String message) {
    Get.snackbar(
      '',
      '',
      titleText: Text(
        title,
        style: kHeaderText.copyWith(fontFamily: 'Vazir'),
      ),
      messageText: Text(
        message,
        style: kTextStyle,
      ),
      backgroundColor: Colors.redAccent.withOpacity(0.2),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
    );
  }

  /// Show dialog for success operation
  static successDialog(String text) {
    Get.defaultDialog(
      title: '',
      content: Column(
        children: [
          Image.asset(
            'assets/images/success.png',
            height: 230,
            width: 230,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            text,
            style: kHeaderText.copyWith(fontSize: 25),
          ),
        ],
      ),
    );
  }

  /// Show dialog for unsuccessful operation
  static unSuccessfulDialog(String text) {
    Get.defaultDialog(
      title: '',
      titlePadding: EdgeInsets.zero,
      content: Column(
        children: [
          Image.asset(
            'assets/images/basket.png',
            height: 200,
            width: 200,
          ),
          Text(
            text,
            style: kHeaderText.copyWith(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      confirm: InkWell(
        onTap: () {
          Get.back();
          FocusManager.instance.primaryFocus?.unfocus();
          Get.back();
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Center(
          heightFactor: 1.5,
          child: Text(
            'برگشت',
            style: kHeaderText.copyWith(
              fontSize: 22,
            ),
          ),
        ),
      ),
      cancel: CustomButton(
        text: 'دوباره امتحان کنید',
        height: 50,
        fontSize: 22,
        onTapped: (){
          Get.back();
        },
      ),
    );
  }

  ///
  static bottomSheetCheckout(
      String sum, TextEditingController controller, VoidCallback onTap) {
    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'پرداخت',
                    style: kHeaderText,
                  ),
                  IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close_rounded))
                ],
              ),
              const Divider(),
              Text(
                'جمع مبلغ سبد خرید شما برابر است با',
                style: kTextStyle.copyWith(fontSize: 22),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                '$sum ریال',
                style: kHeaderText,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 200,
                    child: Text(
                      'مبلغ دلخواه جهت شارژ کیف پول خود را وارد کنید.',
                      style: kTextStyle,
                    ),
                  ),
                  Expanded(
                    child: MyTextField(controller: controller),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                text: 'پرداخت',
                onTapped: onTap,
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static errorDialogRestaurant(
      {required Restaurant restaurant,
      required VoidCallback onChangeRestaurant}) {
    Get.defaultDialog(
      title: 'اخطار',
      titleStyle: kHeaderText,
      content: Text(
        'شما از رستوران ${restaurant.title} یک خرید دارید. آیا قصد تغییر رستوران خود را دارید؟',
        style: kTextStyle,
        textAlign: TextAlign.center,
      ),
      confirm: InkWell(
        onTap: () {
          Get.back();
        },
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Center(
          heightFactor: 1.5,
          child: Text(
            'ادامه خرید',
            style: kHeaderText.copyWith(
              fontSize: 22,
            ),
          ),
        ),
      ),
      cancel: CustomButton(
        text: 'تغییر رستوران',
        height: 50,
        fontSize: 22,
        onTapped: onChangeRestaurant,
      ),
    );
  }

  static Future<String> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString('token') ?? '-1';
    return token;
  }

  static bool validateName(String name, String textError) {
    if (name.isEmpty) {
      errorSnackBar('خطا', 'لطفا $textError خود را وارد کنید.');
      return false;
    }
    return true;
  }

  static bool validateEmail(String email) {
    if (email.isEmpty) {
      errorSnackBar('خطا', 'لطفا ایمیل خود را وارد کنید.');
      return false;
    } //
    else {
      bool status = GetUtils.isEmail(email);
      if (!status) {
        errorSnackBar('خطا', 'لطفا ایمیل خود را به صورت صحیح وارد کنید.');
        return false;
      }
      return true;
    }
  }

  static bool validatePassword(String password) {
    if (password.isEmpty || password.length < 8) {
      errorSnackBar('خطا', 'تعداد کاراکترهای رمز عبور کمتر از 8 عدد می باشد.');
      return false;
    }
    return true;
  }

  static bool validateAcceptRule(bool acceptRule) {
    if (!acceptRule) {
      errorSnackBar('خطا', 'لطفا شرایط و قوانین برنامه را تایید کنید.');
      return false;
    }
    return true;
  }
}
