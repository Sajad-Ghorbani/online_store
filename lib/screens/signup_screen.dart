import 'package:animations/animations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/controllers/user_controller.dart';
import 'package:online_store/services/app_routes.dart';
import 'package:online_store/widgets/background_ui.dart';
import 'package:online_store/widgets/custom_button.dart';
import 'package:online_store/widgets/my_text_field.dart';

import '../constants.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final controller = Get.find<UserController>(tag: 'signup');

  @override
  Widget build(BuildContext context) {
    return BackgroundUI(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Image.asset(
            'assets/images/logo.png',
            width: 80,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Text(
          'ثبت نام',
          style: kHeaderText,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'برای ایجاد حساب کاربری اطلاعات زیر را وارد کنید.',
          style: kTextStyle,
        ),
        const SizedBox(
          height: 40,
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
          'ایمیل',
          style: kTextStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        MyTextField(controller: controller.emailController),
        const SizedBox(
          height: 30,
        ),
        Text(
          'رمز عبور',
          style: kTextStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 40,
          child: Obx(
            () => TextField(
              controller: controller.passController,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.changeShowPassword();
                  },
                  icon: Obx(
                    () => PageTransitionSwitcher(
                      transitionBuilder:
                          (child, primaryAnimation, secondaryAnimation) {
                        return SharedAxisTransition(
                          animation: primaryAnimation,
                          secondaryAnimation: secondaryAnimation,
                          transitionType: SharedAxisTransitionType.scaled,
                          child: child,
                        );
                      },
                      child: controller.showPassword.value
                          ? const SizedBox(
                              child: Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.black,
                              ),
                            )
                          : const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.grey,
                            ),
                      duration: const Duration(milliseconds: 500),
                    ),
                  ),
                ),
              ),
              obscureText: !controller.showPassword.value,
              obscuringCharacter: '\u25CF',
            ),
          ),
        ),
        const SizedBox(
            // height: 20,
            ),
        Theme(
          data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent),
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(vertical: 5),
            title: RichText(
              text: TextSpan(
                style: kTextStyle.copyWith(
                  fontSize: 16,
                  color: kGreyColor,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  const TextSpan(
                    text: 'با ',
                  ),
                  TextSpan(
                    text: 'شرایط و قوانین',
                    style: const TextStyle(
                      color: kGreenColor,
                    ),
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  const TextSpan(
                    text: ' برنامه موافقم.',
                  ),
                ],
              ),
            ),
            leading: Obx(
              () => PageTransitionSwitcher(
                transitionBuilder:
                    (child, primaryAnimation, secondaryAnimation) {
                  return SharedAxisTransition(
                    animation: primaryAnimation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.vertical,
                    child: child,
                  );
                },
                child: controller.acceptRule.value
                    ? const SizedBox(
                        child: Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                        ),
                      )
                    : const Icon(Icons.circle_outlined),
                duration: const Duration(milliseconds: 300),
              ),
            ),
            onTap: () {
              controller.changeAcceptRule();
            },
          ),
        ),
        const SizedBox(
            // height: 20,
            ),
        CustomButton(
          text: 'ثبت نام',
          onTapped: () {
            controller.signUp();
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Center(
          child: RichText(
            text: TextSpan(
              style: kTextStyle.copyWith(
                fontSize: 16,
                color: kBlackColor,
                fontWeight: FontWeight.bold,
              ),
              children: [
                const TextSpan(
                  text: 'حساب کاربری دارید؟ ',
                ),
                TextSpan(
                  text: 'ورود',
                  style: const TextStyle(
                    color: kGreenColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.offNamed(AppRoutes.loginScreen);
                    },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
