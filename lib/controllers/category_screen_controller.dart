import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:online_store/constants.dart';
import 'package:dio/dio.dart' as dio;

import '../static_methods.dart';

class CategoryScreenController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();


  sendCategory() async {
    String token = await StaticMethods.getToken();
    if (token == '-1') {
      StaticMethods.errorSnackBar('خطا', 'شما دسترسی به این عملیات را ندارید.');
      return;
    } //
    else {
      String name = nameController.text;
      String desc = descController.text;
      Map<String, dynamic> newMap = {};
      newMap['name'] = name;
      newMap['description'] = desc;
      if (StaticMethods.validateName(name, 'نام رستوران') &&
          StaticMethods.validateName(desc, 'توضیحات')) {
        dio.Dio myDio = dio.Dio();
        dio.Response response = await myDio.post(
          '$kBaseUrl/api/admin/categories',
          data: newMap,
          options: dio.Options(
            method: 'POST',
            headers: {
              HttpHeaders.authorizationHeader: 'Bearer $token',
            },
            responseType: dio.ResponseType.json
          )
        );
        print(response.statusCode);
        print(response.data);
        if(response.statusCode!<300){
          StaticMethods.successDialog('اطلاعات شما با موفقیت ذخیره شد.');
          nameController.clear();
          descController.clear();
        }//
      }
    }
  }
}
