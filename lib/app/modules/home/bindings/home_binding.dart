import 'package:get/get.dart';
import 'package:pst_online/app/data/providers/api_provider.dart';
import 'package:pst_online/app/data/providers/youtube_provider.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());
    Get.lazyPut<YoutubeProvider>(() => YoutubeProvider());
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
