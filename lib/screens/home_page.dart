import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/controllers/user_controller.dart';
import 'package:online_store/screens/search_screen.dart';
import 'package:online_store/widgets/base_widget.dart';
import 'package:online_store/widgets/best_restaurant_widget.dart';
import 'package:online_store/widgets/categories_widget.dart';
import 'package:online_store/widgets/custom_slider.dart';
import 'package:online_store/widgets/new_restaurant_widget.dart';

import '../constants.dart';

class HomePage extends GetView<UserController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'TOSEGAR',
          style: kHeaderText.copyWith(
            fontFamily: 'Sand',
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            controller.logout();
          },
          icon: const Icon(Icons.logout_rounded),
          color: Colors.black,
          splashRadius: 25,
        ),
      ),
      padding: 0,
      child: SingleChildScrollView(
        child: Column(
          children: [
            OpenContainer(
              closedBuilder: (context, action) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  child: TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: kLightGreyColor,
                      prefixIcon: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        child: const Icon(
                          Icons.search_rounded,
                          size: 28,
                        ),
                      ),
                      hintText: 'جست و جو ...',
                      hintStyle: kTextStyle,
                    ),
                  ),
                );
              },
              openBuilder: (context, action) {
                return const SearchScreen();
              },
              closedElevation: 0,
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomSlider(),
            const SizedBox(
              height: 10,
            ),
            const BestRestaurantWidget(),
            const SizedBox(
              height: 10,
            ),
            const CategoriesWidget(),
            const SizedBox(
              height: 10,
            ),
            const NewRestaurantWidget(),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
