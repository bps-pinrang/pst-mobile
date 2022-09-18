import 'package:get/get.dart';
import 'package:pst_online/app/data/providers/api_provider.dart';

import '../controllers/statistic_detail_controller.dart';

class StatisticDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());
    Get.lazyPut<StatisticDetailController>(
      () => StatisticDetailController(),
    );
  }
}
