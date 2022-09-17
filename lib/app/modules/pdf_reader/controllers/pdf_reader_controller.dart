import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:get/get.dart';

import 'package:pst_online/app/core/values/strings.dart';


class PdfReaderController extends GetxController {
  final url = ''.obs;
  final title = ''.obs;


  @override
  void onInit() {
    url.value = Get.arguments[kArgumentKeyUrl];
    title.value = Get.arguments[kArgumentKeyTitle];
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'PdfReader');
    super.onInit();
  }
}
