import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:online_store/constants.dart';
import 'package:online_store/models/user.dart';
import 'package:online_store/services/app_routes.dart';
import 'package:online_store/static_methods.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert' as convert;

class UserController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  RxBool showPassword = false.obs;
  RxBool acceptRule = false.obs;
  late SharedPreferences pref;
  RxString name = ''.obs;
  RxString email = ''.obs;
  RxString role = ''.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    loadPref();
  }

  loadPref() async {
    pref = await SharedPreferences.getInstance();
    name.value = pref.getString('name') ?? '';
    email.value = pref.getString('email') ?? '';
    role.value = pref.getString('role') ?? '';
  }

  @override
  void onClose() {
    super.onClose();
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
  }

  void changeShowPassword() {
    showPassword.value = !showPassword.value;
  }

  void changeAcceptRule() {
    acceptRule.value = !acceptRule.value;
  }

  signUp() async {
    String name = nameController.text;
    String email = emailController.text;
    String password = passController.text;
    if (StaticMethods.validateName(name, 'نام') &&
        StaticMethods.validateEmail(email) &&
        StaticMethods.validatePassword(password) &&
        StaticMethods.validateAcceptRule(acceptRule.value)) {
      try {
        http.Response response = await http.post(
          Uri.parse('$kBaseUrl/api/register'),
          body: convert.jsonEncode({
            'name': name,
            'email': email,
            'password': password,
            'password_confirmation': password
          }),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
        );
        Map responseMap = convert.jsonDecode(response.body);
        if (response.statusCode < 300) {
          User user = User.fromJson(responseMap['user']);
          await pref.setInt('user_id', user.id!);
          await pref.setString('token', responseMap['token']);
          await pref.setString('email', user.email!);
          await pref.setString('name', user.name!);
          await pref.setString('role', user.role ?? '');
          Get.offNamed(AppRoutes.introScreen);
        } //
        else {
          StaticMethods.errorSnackBar('خطا', 'ایمیل وارد شده تکراری می باشد.');
        }
      } catch (_) {
        // pass
      }
    }
  }

  login() async {
    String email = emailController.text;
    String password = passController.text;
    if (StaticMethods.validateEmail(email) &&
        StaticMethods.validatePassword(password)) {
      try {
        http.Response response = await http.post(
          Uri.parse('$kBaseUrl/api/login'),
          body: convert.jsonEncode(
            {
              'email': email,
              'password': password,
            },
          ),
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json'
          },
        );
        if (response.statusCode < 300) {
        Map<String, dynamic> responseMap = convert.jsonDecode(response.body);
        User user = User.fromJson(responseMap['user']);
          await pref.setInt('user_id', user.id!);
          await pref.setString('token', responseMap['token']);
          await pref.setString('email', user.email!);
          await pref.setString('name', user.name!);
          await pref.setString('role', user.role ?? '');
          Get.offNamed(AppRoutes.homeScreen);
        } //
        else {
          StaticMethods.errorSnackBar(
              'خطا', 'هیچ کاربری با اطلاعات وارد شده وجود ندارد.');
        }
      } catch (_) {
        // pass
      }
    }
  }

  logout() async {
    await http.get(
      Uri.parse('$kBaseUrl/api/logout'),
    );
    pref.clear();
    Get.offAllNamed(AppRoutes.loginScreen);
  }
}
