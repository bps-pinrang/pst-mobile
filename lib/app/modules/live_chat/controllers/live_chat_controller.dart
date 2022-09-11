import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'package:pst_online/app/core/values/strings.dart';

class LiveChatController extends GetxController {
  final name = ''.obs;
  final email = ''.obs;
  final liveChatUrl = ''.obs;

  @override
  void onInit() {
    name.value = Get.arguments[kFormKeyName];
    email.value = Get.arguments[kFormKeyEmail];
    liveChatUrl.value = FlutterConfig.get(kEnvKeyTawkToChatUrl);
    super.onInit();
  }
}
