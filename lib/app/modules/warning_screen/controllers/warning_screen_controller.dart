import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';
import 'package:pst_online/app/core/enums/app_animation.dart';
import 'package:pst_online/app/core/values/strings.dart';

class WarningScreenController extends GetxController {
  late String message;
  late AppAnimation animation;
  late String semantics;

  @override
  void onInit() async {
    if (Get.arguments != null) {
      message = Get.arguments['message'];
      animation = Get.arguments['animation'];
      semantics = Get.arguments['semantics'];
    } else {
      message = 'Kesalahan';
      animation = AppAnimation.warning;
      semantics = 'Terjadi kesalahan!';
    }

    await Future.wait([
      FirebaseAnalytics.instance.setCurrentScreen(
        screenName: 'Warning',
      ),
      FirebaseAnalytics.instance.logEvent(
        name: 'WarningScreenOpen',
        parameters: {
          kDataKeyMessage: message,
        },
      )
    ]);
    super.onInit();
  }
}
