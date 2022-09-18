import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pst_online/app/core/enums/tables/usage_history_columns.dart';
import 'package:pst_online/app/core/exceptions/app_exception.dart';
import 'package:pst_online/app/core/utils/helper.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/data/models/api_meta.dart';
import 'package:pst_online/app/data/models/publication.dart';
import 'package:pst_online/app/data/providers/api_provider.dart';
import 'package:pst_online/app/global_widgets/alert_variant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/values/strings.dart';
import '../../../data/models/app_user.dart';

class PublicationsController extends GetxController {
  late ApiProvider provider;

  Rxn<AppUser> user = Rxn(null);
  Rxn<ApiMeta> apiMeta = Rxn(null);
  final client = Supabase.instance.client;
  late PagingController<int, Publication> pagingController;
  final ScrollController scrollController = ScrollController();

  final isApiMetaLoaded = false.obs;
  final isPublicationLoading = false.obs;

  final pageSize = 10.obs;
  final currentPage = 1.obs;
  Rxn<DateTime> selectedDate = Rxn(null);

  @override
  void onInit() async {
    provider = GetInstance().find<ApiProvider>();
    pagingController = PagingController(
      firstPageKey: 1,
    )..addPageRequestListener(loadPublications);

    user.value = Get.arguments[kArgumentKeyUser];
    super.onInit();

    await FirebaseAnalytics.instance
        .setCurrentScreen(screenName: 'Publications');
  }

  void applyYearFilter(DateTime? date) {
    selectedDate.value = date;
    currentPage.value = 0;
    apiMeta.value = null;
    isApiMetaLoaded.value = false;
    pagingController.refresh();
  }

  Future<void> loadPublications(int page) async {
    try {
      isPublicationLoading.value = true;
      final result = await provider.loadPublications(
        page,
        year: selectedDate.value?.year,
      );
      result.fold(
        (failure) => pagingController.error = failure.message,
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
            pagingController.appendPage(
              data.data,
              currentPage.value,
            );
          }
        },
      );
    } catch (e, trace) {
      pagingController.error = e.toString();

      FirebaseCrashlytics.instance.recordError(
        e.toString(),
        trace,
      );
    } finally {
      isPublicationLoading.value = false;
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

        final result = await client.from(kTableUsageHistories).insert({
          UsageHistoryColumns.userId.key: user.value?.id,
          UsageHistoryColumns.serviceId.key: 4,
          UsageHistoryColumns.actionId.key: 1,
          UsageHistoryColumns.itemName.key: fileName,
          UsageHistoryColumns.itemType.key: 'Publikasi',
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
    pagingController.removePageRequestListener(loadPublications);
    pagingController.dispose();
    scrollController.dispose();
    super.onClose();
  }
}
