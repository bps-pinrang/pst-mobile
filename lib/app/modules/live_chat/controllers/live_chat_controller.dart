import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:get/get.dart';
import 'package:pst_online/app/core/values/strings.dart';

class LiveChatController extends GetxController {
  final name = ''.obs;
  final email = ''.obs;
  final liveChatUrl = ''.obs;

  @override
  void onInit() async {
    name.value = Get.arguments[kFormKeyName];
    email.value = Get.arguments[kFormKeyEmail];
    liveChatUrl.value = FlutterConfig.get(kEnvKeyTawkToChatUrl);
    await Future.wait([
      FirebaseAnalytics.instance.setCurrentScreen(
        screenName: 'LiveChat',
      ),
      FirebaseAnalytics.instance.logEvent(
        name: 'Konsultasi Langsung',
        parameters: {
          kJsonKeyName: name.value,
          kJsonKeyEmail: email.value,
        }
      )
    ]);
    super.onInit();
  }
}
