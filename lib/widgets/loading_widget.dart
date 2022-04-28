import 'package:flutter/material.dart';
import 'package:online_store/constants.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: kLightYellowColor,
        shape: BoxShape.circle,
      ),
      child: Image.asset(
        'assets/images/loading.gif',
        height: 80,
        width: 80,
        fit: BoxFit.cover,
      ),
    );
  }
}
