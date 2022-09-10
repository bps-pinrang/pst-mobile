import 'package:get/get.dart';

import '../controllers/warning_screen_controller.dart';

class WarningScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WarningScreenController>(
      () => WarningScreenController(),
    );
  }
}
