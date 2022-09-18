import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/data/providers/api_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/enums/tables/usage_history_columns.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/utils/helper.dart';
import '../../../core/utils/view_helper.dart';
import '../../../data/models/app_user.dart';
import '../../../data/models/failure.dart';
import '../../../data/models/statistic_table.dart';
import '../../../global_widgets/alert_variant.dart';

class StatisticDetailController extends GetxController {
  late ApiProvider provider;
  final tableId = ''.obs;
  final client = Supabase.instance.client;
  final ScrollController scrollController = ScrollController();

  Rxn<AppUser> user = Rxn(null);
  Rxn<StatisticTable> statisticTable = Rxn(null);

  final isLoading = false.obs;
  Rxn<Failure> failure = Rxn(null);
  final isDownloadProcessing = false.obs;

  @override
  void onInit() async {
    provider = GetInstance().find<ApiProvider>();
    user.value = Get.arguments[kArgumentKeyUser];
    tableId.value = Get.arguments[kArgumentKeyId];
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Statistic Detail');
    await loadStatisticTableDetail();
    super.onInit();
  }

  Future<void> loadStatisticTableDetail() async {
    try {
      isLoading.value = true;
      final result = await provider.loadStatisticTableDetail(tableId.value);
      result.fold(
        (failData) {
          FirebaseCrashlytics.instance.log(failData.message);
          failure.value = failData;
        },
        (data) => statisticTable.value = data.data,
      );
    } catch (exception, stack) {
      FirebaseCrashlytics.instance.recordError(exception, stack);
      failure.value = Failure(
        title: 'Kesalahan!',
        message: exception.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> handleDownload({
    required String url,
    required String fileName,
    required String extension,
  }) async {
    try {
      final result = await downloadFile(url, fileName, extension);

      if (result != null) {
        showGetSnackBar(
          title: 'Berhasil!',
          variant: AlertVariant.success,
          message: 'Unduhan sedang diproses!',
        );

        final date = DateTime.now();

        final resp = await client.from(kTableUsageHistories).insert({
          UsageHistoryColumns.userId.key: user.value?.id,
          UsageHistoryColumns.serviceId.key: 4,
          UsageHistoryColumns.actionId.key: 1,
          UsageHistoryColumns.itemName.key: fileName,
          UsageHistoryColumns.itemType.key: 'Tabel Statis',
          UsageHistoryColumns.accessDate.key: formatDate(
            'yyyy-MM-dd HH:mm:ss+${date.timeZoneOffset.inHours.toString().padLeft(2, '0')}',
            date,
            showTimezone: false,
          )
        }).execute();

        if (resp.error != null) {
          throw AppException('${resp.error!.message}\n${resp.error!.hint}');
        }
      }
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack);
      showGetSnackBar(
        title: 'Gagal!',
        message: e.toString(),
        variant: AlertVariant.error,
      );
    } finally {
      isDownloadProcessing.value = false;
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}
