import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:online_store/constants.dart';
import 'package:online_store/services/app_routes.dart';
import 'package:online_store/static_methods.dart';

class SplashScreenController extends GetxController {
  final RxString _connectionStatus = '-1'.obs;
  final Rx<Connectivity> _connectivity = Connectivity().obs;
  Rx<ConnectivityResult> result = ConnectivityResult.none.obs;

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        _connectionStatus.value = 'wifi net';
        break;
      case ConnectivityResult.mobile:
        _connectionStatus.value = 'mobile net';
        break;
      case ConnectivityResult.none:
        _connectionStatus.value = '-1';
        Get.snackbar(
          '',
          '',
          titleText: Text(
            'اینترنت متصل نمی باشد.',
            style: kHeaderText.copyWith(fontSize: 20),
          ),
          messageText: Text(
            'لطفا داده ها یا wifi را روشن کنید.',
            style: kTextStyle.copyWith(color: kBlackColor),
          ),
          snackStyle: SnackStyle.FLOATING,
          snackPosition: SnackPosition.TOP,
        );
        break;
      default:
        _connectionStatus.value = 'Failed to get connectivity.';
        break;
    }
    if (_connectionStatus.value != '-1') {
      Future.delayed(const Duration(seconds: 3), () async {
        String token = await StaticMethods.getToken();
        if (token == '-1') {
          Get.offNamed(AppRoutes.loginScreen);
        }//
        else{
          Get.offNamed(AppRoutes.homeScreen);
        }
      });
    }
  }

  Future<void> initConnectivity() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result.value = await _connectivity.value.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    return _updateConnectionStatus(result.value);
  }

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    ever(result, (_) {
      _connectivity.value.onConnectivityChanged.listen(_updateConnectionStatus);
    });
  }

  @override
  void onClose() {
    super.onClose();
    result.close();
    _connectivity.close();
  }
}
