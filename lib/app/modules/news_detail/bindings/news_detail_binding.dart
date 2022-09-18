import 'package:get/get.dart';
import 'package:pst_online/app/data/providers/api_provider.dart';

import '../controllers/news_detail_controller.dart';

class NewsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());
    Get.lazyPut<NewsDetailController>(
      () => NewsDetailController(),
    );
  }
}
