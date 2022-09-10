import 'dart:async';

import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../routes/app_pages.dart';
import '../enums/app_animation.dart';
import '../values/strings.dart';
import '../../../../i18n/strings.g.dart';

class ConnectivityService extends GetxService {
  final Connectivity _connectivity = Connectivity();

  final int connectionType = 0;
  final GetStorage box = GetStorage();

  Future<ConnectivityService> init() async {
    return this;
  }

  @override
  onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen(
      (data) {
        try {
          print('connection: $data');

          final isFirstSeen = !box.hasData(kStorageKeyIsFirstSeen);

          if ([
            Routes.splashScreen,
            Routes.onBoarding,
          ].contains(Get.currentRoute)) {
            return;
          }

          if (data != ConnectivityResult.none) {
            if (Get.previousRoute != Routes.warningScreen) {
              Get.offAllNamed(Get.previousRoute);
            }

            Get.offAllNamed(Routes.home);
            return;
          }

          if (isFirstSeen) {
            Get.offAllNamed(Routes.onBoarding, arguments: Routes.home);
            return;
          }

          Get.offAllNamed(
            Routes.warningScreen,
            arguments: {
              'animation': AppAnimation.noInternet,
              'message': t.noInternet,
              'semantics': t.semantics.noInternet,
            },
          );
        } on PlatformException catch (e) {
          debugPrint(e.toString());
        }
      },
    ).onError(
      (error) {
        debugPrint(error.toString());
      },
    );
  }
}
