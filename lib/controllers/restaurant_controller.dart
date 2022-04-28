import 'dart:io';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_store/constants.dart';
import 'package:online_store/models/restaurant.dart';
import 'package:online_store/static_methods.dart';

class RestaurantController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descController = TextEditingController();
  RxInt isSlide = 0.obs;
  Rx<File> file = File('-1').obs;
  String token = '-1';
  RxList<Restaurant> restList = <Restaurant>[].obs;

  @override
  onInit() {
    super.onInit();
    getToken();
    getRestaurantList();
  }

  getToken()async {
    token = await StaticMethods.getToken();
  }

  getRestaurantList() async {
    dio.Dio myDio = dio.Dio();
    dio.Response response = await myDio.get(
      '$kBaseUrl/api/admin/restaurants',
      options: dio.Options(
        method: 'GEt',
        headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
        },
        responseType: dio.ResponseType.json,
      ),
    );
    if (response.statusCode! < 300) {
      for (var item in response.data['data']) {
        restList.add(
          Restaurant.fromJson(item),
        );
      }
    }//
    else{
      StaticMethods.errorSnackBar('خطا', 'شما دسترسی به این عملیات را ندارید.');
      return;
    }
  }

  Future<void> selectImage() async {
    ImagePicker _imagePicker = ImagePicker();
    XFile _pickedImage =
        await _imagePicker.pickImage(source: ImageSource.gallery) ??
            XFile('-1');
    if (_pickedImage.path != '-1') {
      file.value = File(_pickedImage.path);
    }
  }

  sendRestaurant() async {
    if (token == '-1') {
      StaticMethods.errorSnackBar('خطا', 'شما دسترسی به این عملیات را ندارید.');
      return;
    } //
    else {
      String name = nameController.text;
      String address = addressController.text;
      String desc = descController.text;
      int slide = isSlide.value;
      Map<String, dynamic> newMap = {};
      newMap['name'] = name;
      newMap['address'] = address;
      newMap['description'] = desc;
      newMap['is_slide'] = slide;
      if (StaticMethods.validateName(name, 'نام رستوران') &&
          StaticMethods.validateName(address, 'آدرس') &&
          StaticMethods.validateName(desc, 'توضیحات')) {
        if (file.value.path == '-1') {
          StaticMethods.errorSnackBar(
              'خطا', 'لطفا یک تصویر برای رستوران انتخاب کنید.');
          return;
        } //
        else {
          newMap['image'] = await dio.MultipartFile.fromFile(file.value.path,
              filename: file.value.path.split('/').last);
        }
        dio.Dio myDio = dio.Dio();
        dio.FormData formData = dio.FormData.fromMap(newMap);
        dio.Response response = await myDio.post(
          '$kBaseUrl/api/admin/restaurants',
          data: formData,
          options: dio.Options(
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
            },
            method: 'POST',
            responseType: dio.ResponseType.json,
          ),
        );
        if (response.data == '') {
          StaticMethods.successDialog('اطلاعات شما با موفقیت ذخیره شد.');
          reset();
        } //
        else {
          StaticMethods.errorSnackBar('خطا', 'نام رستوران تکراری می باشد.');
          print(response.data);
        }
      }
    }
  }

  reset() {
    nameController.clear();
    addressController.clear();
    descController.clear();
    isSlide.value = 0;
    file.value = File('-1');
  }

}
