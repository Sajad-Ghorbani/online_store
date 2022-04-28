import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/controllers/home_screen_controller.dart';
import 'package:online_store/controllers/search_controller.dart';
import 'package:online_store/models/restaurant.dart';
import 'package:online_store/widgets/base_widget.dart';

import '../constants.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.searchController.clear();
        controller.restList.clear();
        return true;
      },
      child: BaseWidget(
        child: SafeArea(
          child: Obx(
            () => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 50,
                  child: TextField(
                    controller: controller.searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: kLightGreyColor,
                      prefixIcon: InkWell(
                        onTap: () {
                          controller.search();
                        },
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
                ),
                if (controller.restList.isEmpty) ...[
                  Expanded(
                    child: Center(
                      child: Text(
                        'برای پیدا کردن رستوران مورد نظر خودتون جست و جو کنید.',
                        style: kTextStyle.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ] //
                else ...[
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      children: List.generate(
                        controller.restList.length,
                        (index) {
                          Restaurant rest = controller.restList[index];
                          return InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              FocusManager.instance.primaryFocus?.unfocus();
                              Future.delayed(const Duration(milliseconds: 100),
                                  () {
                                Get.find<HomeScreenController>()
                                    .getRestaurant(rest.id!);
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: colors[controller.random.nextInt(7)],
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.redAccent,
                                ),
                              ),
                              padding: const EdgeInsets.only(
                                top: 10,
                                right: 10,
                                left: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    '$kBaseUrl/img/${rest.image}',
                                    height: 60,
                                    width: Get.width,
                                    fit: BoxFit.fitWidth,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    rest.title!,
                                    style: kHeaderText.copyWith(
                                      fontSize: 16,
                                      fontFamily: 'Yekan',
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    rest.description!,
                                    style: kTextStyle.copyWith(
                                      fontFamily: 'Vazir',
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
