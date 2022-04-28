import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/controllers/home_screen_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomSlider extends GetView<HomeScreenController> {
  const CustomSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        width: Get.width,
        height: 180,
        child: Stack(
          children: [
            CarouselSlider(
              items: controller.imageSliders,
              carouselController: controller.carouselController.value,
              options: CarouselOptions(
                autoPlay: true,
                enlargeCenterPage: true,
                height: 180,
                onPageChanged: controller.onChangeSlide,
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              padding: const EdgeInsets.all(10),
              child: AnimatedSmoothIndicator(
                activeIndex: controller.currentSlide.value,
                count: controller.restaurantImageList.length,
                axisDirection: Axis.horizontal,
                effect: const ExpandingDotsEffect(
                  dotWidth: 10.0,
                  dotHeight: 10.0,
                  paintStyle: PaintingStyle.fill,
                  strokeWidth: 1.5,
                  dotColor: Colors.grey,
                  activeDotColor: Colors.white,
                ),
                onDotClicked: controller.onDotClick,
              ),
            )
          ],
        ),
      ),
    );
  }
}
