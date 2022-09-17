import 'dart:async';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/global_widgets/alert_variant.dart';

class DownloadHistoryController extends GetxController {

  final downloads = List<DownloadTask>.empty(growable: true).obs;

  @override
  onInit()  {
    loadDownloadTasks();
    super.onInit();
  }

  Future<void> loadDownloadTasks() async {
    final data = await FlutterDownloader.loadTasks();
    if(data != null) {
      downloads.value = data;
    }
  }

  Future<void> handleDeleteTask(String taskId) async {
    try {
      Get.back();
      await FlutterDownloader.remove(
        taskId: taskId,
        shouldDeleteContent: true,
      );
      showGetSnackBar(
        title: 'Berhasil!',
        message: 'Berhasil menghapus unduhan!',
        variant: AlertVariant.success,
      );
      loadDownloadTasks();
      notifyChildrens();
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack);
      showGetSnackBar(
        title: 'Kesalahan!',
        message: 'Terjadi kesalahan saat menghapus file!',
        variant: AlertVariant.error,
      );
    }
  }
}
