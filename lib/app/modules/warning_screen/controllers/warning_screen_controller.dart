import 'package:get/get.dart';
import 'package:pst_online/app/core/enums/app_animation.dart';


class WarningScreenController extends GetxController {
  late String message;
  late AppAnimation animation;
  late String semantics;

  @override
  void onInit() {
    if(Get.arguments != null) {
      message = Get.arguments['message'];
      animation = Get.arguments['animation'];
      semantics = Get.arguments['semantics'];
    } else {
      message = 'Kesalahan';
      animation = AppAnimation.warning;
      semantics = 'Terjadi kesalahan!';
    }
    super.onInit();
  }
}
