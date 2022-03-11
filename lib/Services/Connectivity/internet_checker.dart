import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';
import 'package:mangalo_app/Constant/Widgets/common_widget.dart';

class InternetChecker extends GetxService {
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();
  late ConnectivityResult connectivityResult;

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    connectivityResult = result;
    if (connectivityResult == ConnectivityResult.none) {
      print('No Internet');
      Get.dialog(NoInternetDialogue(), barrierDismissible: false);
    } else if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      Navigator.of(Get.overlayContext!).pop();
      print('Mobile Internet');
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      Navigator.of(Get.overlayContext!).pop();
      print('Wifi Internet');
    }
  }

  @override
  void onInit() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.onInit();
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}

class NoInternetDialogue extends StatelessWidget {
  const NoInternetDialogue({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/Images/no_Internet_Icon.png'),
          SizedBox(
            height: 10.0,
          ),
          CommonWidget()
              .customText('No Internet', blackColor, 25.0, FontWeight.bold, 1),
          SizedBox(
            height: 30.0,
          ),
          CommonWidget().customText(
              'You must be connected to the internet to complete this action',
              blackColor.withOpacity(0.5),
              20.0,
              FontWeight.w400,
              2,
              alignment: TextAlign.center),
        ],
      ),
    );
  }
}
