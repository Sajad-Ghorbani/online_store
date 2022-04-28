import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/constants.dart';
import 'package:online_store/services/app_routes.dart';
import 'package:online_store/widgets/background_ui.dart';

class ReceiveCode extends StatelessWidget {
  const ReceiveCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BackgroundUI(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.offAllNamed(AppRoutes.introScreen);
        },
        child: const Icon(
          Icons.arrow_back_ios_rounded,
          color: kBlackColor,
        ),
        elevation: 0,
        backgroundColor: kAmberColor,
        highlightElevation: 0,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 40,
        ),
        const Text(
          'کد دریافتی را وارد کنید.',
          style: kHeaderText,
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          'کد',
          style: kTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 40,
          child: TextField(
            decoration: InputDecoration(
              hintText: '- - - -',
              hintStyle: kTextStyle.copyWith(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            textAlign: TextAlign.center,
            style: kHeaderText,
            keyboardType: TextInputType.number,
          ),
        ),
        TextButton(
          onPressed: () {},
          child: Text(
            'ارسال مجدد کد',
            style: kTextStyle.copyWith(
              fontWeight: FontWeight.bold,
              color: kGreenColor,
            ),
          ),
        ),
      ],
    );
  }
}
