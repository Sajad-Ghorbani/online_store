import 'package:animations/animations.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/constants.dart';
import 'package:online_store/controllers/user_controller.dart';
import 'package:online_store/services/app_routes.dart';
import 'package:online_store/widgets/background_ui.dart';
import 'package:online_store/widgets/custom_button.dart';
import 'package:online_store/widgets/my_text_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final controller = Get.find<UserController>(tag: 'login');

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
          'ورود',
          style: kHeaderText,
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          'لطفا برای ورود، ایمیل و رمز عبور خود را وارد کنید.',
          style: kTextStyle,
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          'ایمیل',
          style: kTextStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        MyTextField(controller: controller.emailController),
        const SizedBox(
          height: 40,
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
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
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
        TextButton(
          onPressed: () {},
          child: Text(
            'رمز عبور خود را فراموش کرده اید؟',
            style: kTextStyle.copyWith(
              fontSize: 16,
              color: kBlackColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomButton(
          text: 'ورود',
          onTapped: () {
            controller.login();
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
                  text: 'حساب کاربری ندارید؟ ',
                ),
                TextSpan(
                  text: 'ثبت نام',
                  style: const TextStyle(
                    color: kGreenColor,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      Get.offNamed(AppRoutes.signupScreen);
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
