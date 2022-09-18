import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/data/models/statistic_table.dart';
import 'package:pst_online/app/data/providers/api_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/enums/tables/usage_history_columns.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/utils/helper.dart';
import '../../../core/utils/view_helper.dart';
import '../../../data/models/api_meta.dart';
import '../../../data/models/app_user.dart';
import '../../../global_widgets/alert_variant.dart';

class StatisticsController extends GetxController {
  late ApiProvider provider;

  Rxn<ApiMeta> apiMeta = Rxn(null);
  final client = Supabase.instance.client;
  late PagingController<int, StatisticTable> pagingController;
  final ScrollController scrollController = ScrollController();

  final pageSize = 10.obs;
  final currentPage = 1.obs;
  final isApiMetaLoaded = false.obs;
  final isStatisticLoading = false.obs;

  Rxn<AppUser> user = Rxn(null);

  @override
  void onInit() async {
    provider = GetInstance().find<ApiProvider>();
    pagingController = PagingController(firstPageKey: 1)
      ..addPageRequestListener(loadStatisticTables);
    user.value = Get.arguments[kArgumentKeyUser];
    super.onInit();
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Statistics');
  }

  Future<void> loadStatisticTables(int page) async {
    try {
      final result = await provider.loadStatisticTables(page);

      result.fold(
        (failure) {
          FirebaseCrashlytics.instance.log(failure.message);
          pagingController.error = failure.message;
        },
        (data) {
          currentPage.value++;

          if (!isApiMetaLoaded.value) {
            isApiMetaLoaded.value = true;
            apiMeta.value = data.meta;
          }

          final isLastPage = data.data.length < pageSize.value;

          if (isLastPage) {
            pagingController.appendLastPage(data.data);
          } else {
            pagingController.appendPage(data.data, currentPage.value);
          }
        },
      );
    } catch (exception, stack) {
      FirebaseCrashlytics.instance.recordError(exception, stack);
      pagingController.error = 'Kesalahan saat memuat data!';
    }
  }

  Future<void> handleRead(StatisticTable statisticTable) async {
    try {
      final date = DateTime.now();
      FirebaseAnalytics.instance.logSelectContent(
        contentType: 'Statistik',
        itemId: statisticTable.title,
      );
      print(user.value);
      if (user.value != null) {
        final result = await client.from(kTableUsageHistories).insert({
          UsageHistoryColumns.userId.key: user.value?.id,
          UsageHistoryColumns.serviceId.key: 4,
          UsageHistoryColumns.actionId.key: 2,
          UsageHistoryColumns.itemName.key: statisticTable.title ,
          UsageHistoryColumns.itemType.key: 'Statistik',
          UsageHistoryColumns.accessDate.key: formatDate(
            'yyyy-MM-dd HH:mm:ss+${date.timeZoneOffset.inHours.toString().padLeft(2, '0')}',
            date,
            showTimezone: false,
          )
        }).execute();

        if (result.error != null) {
          throw AppException('${result.error!.message}\n${result.error!.hint}');
        }
      }
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack);
      showGetSnackBar(
        title: 'Gagal!',
        message: e.toString(),
        variant: AlertVariant.error,
      );
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    pagingController.removePageRequestListener(loadStatisticTables);
    pagingController.dispose();
    super.onClose();
  }
}
