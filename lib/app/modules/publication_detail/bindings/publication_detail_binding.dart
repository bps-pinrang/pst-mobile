import 'package:get/get.dart';
import 'package:pst_online/app/data/providers/api_provider.dart';

import '../controllers/publication_detail_controller.dart';

class PublicationDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ApiProvider>(() => ApiProvider());
    Get.lazyPut<PublicationDetailController>(
      () => PublicationDetailController(),
    );
  }
}
