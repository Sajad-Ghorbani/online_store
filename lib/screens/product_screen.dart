import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/models/product.dart';
import 'package:online_store/widgets/base_widget.dart';

import '../constants.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen({Key? key}) : super(key: key);

  Product product = Get.arguments;
  String category = Get.parameters['categoryName']!;

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          product.name!,
          style: kHeaderText,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: kBlackColor,
          ),
        ),
      ),
      padding: 0,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/product.png',
              height: 200,
              fit: BoxFit.fill,
              width: Get.width,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'نام',
                    style: kHeaderText.copyWith(
                      fontFamily: 'Vazir',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    product.name ?? '',
                    style: kTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'قیمت',
                    style: kHeaderText.copyWith(
                      fontFamily: 'Vazir',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    product.price.toString(),
                    style: kTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'دسته بندی',
                    style: kHeaderText.copyWith(
                      fontFamily: 'Vazir',
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    category,
                    style: kTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
