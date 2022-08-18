import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pst_online/app/core/utils/helper.dart';

import '../../../core/values/strings.dart';
import '../../../data/models/failure.dart';
import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final box = GetStorage();
  final appVersion = ''.obs;
  final isFirstSeen = false.obs;
  final isTimerInitialized = false.obs;
  late Timer timer;

  Future<Either<Failure, bool>> askPermissions() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.camera,
      Permission.storage,
      Permission.notification,
      Permission.calendar,
    ].request();

    if (permissions.values.where((element) => element.isGranted).isEmpty) {
      return const Right(false);
    }

    return const Left(
      Failure(
          title: 'Kesalahan!', message: 'Masih ada izin yang belum disetujui!'),
    );
  }

  void loadPage() {
    timer = Timer(3.seconds, pageNavigation);
    isTimerInitialized.value = true;
  }

  void checkIfFirstSeen() {
    if(!box.hasData(kStorageKeyIsFirstSeen)) {
      isFirstSeen.value = true;
      box.write(kStorageKeyIsFirstSeen, false);
      return;
    }

    isFirstSeen.value = box.read(kStorageKeyIsFirstSeen);
  }

  void pageNavigation() {
    var page = Routes.home;

    if (isFirstSeen.value) {
      Get.offNamed(Routes.onBoarding, arguments: page);
    } else {
      Get.offNamed(page);
    }
  }

  @override
  void onInit() async {
    appVersion.value = await getAppVersion();
    checkIfFirstSeen();
    await askPermissions();
    loadPage();
    super.onInit();
  }

  @override
  void onClose() {
    if (isTimerInitialized.value) {
      timer.cancel();
    }

    super.onClose();
  }
}
