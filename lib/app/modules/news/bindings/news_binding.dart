import 'package:get/get.dart';
import 'package:pst_online/app/data/providers/api_provider.dart';

import '../controllers/news_controller.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());
    Get.lazyPut<NewsController>(
      () => NewsController(),
    );
  }
}
