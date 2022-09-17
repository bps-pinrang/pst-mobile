import 'package:get/get.dart';
import 'package:pst_online/app/data/providers/api_provider.dart';

import '../controllers/publications_controller.dart';

class PublicationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());
    Get.lazyPut<PublicationsController>(
      () => PublicationsController(),
    );
  }
}
