import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/constants.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.text,
      required this.onTapped,
      this.height = 67,
      this.fontSize,
      this.color,
      this.splashColor,
      this.fontColor})
      : super(key: key);
  final String text;
  final VoidCallback onTapped;
  final double? height;
  final double? fontSize;
  final Color? color;
  final Color? splashColor;
  final Color? fontColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(17),
      color: color ?? kAmberColor,
      child: InkWell(
        borderRadius: BorderRadius.circular(17),
        splashColor: splashColor ?? Colors.amber,
        highlightColor: Colors.amber.withOpacity(0.1),
        onTap: onTapped,
        child: SizedBox(
          width: Get.width,
          height: height,
          child: Center(
            child: Text(
              text,
              style: kTextStyle.copyWith(
                  fontSize: fontSize ?? 30,
                  color: fontColor ?? kBlackColor,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
