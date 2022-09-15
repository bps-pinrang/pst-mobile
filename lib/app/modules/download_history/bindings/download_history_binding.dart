import 'package:get/get.dart';

import '../controllers/download_history_controller.dart';

class DownloadHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DownloadHistoryController>(
      () => DownloadHistoryController(),
    );
  }
}
