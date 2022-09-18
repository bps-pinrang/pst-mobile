import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/data/models/failure.dart';
import 'package:pst_online/app/data/models/publication.dart';
import 'package:pst_online/app/data/providers/api_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/enums/tables/usage_history_columns.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/utils/helper.dart';
import '../../../core/utils/view_helper.dart';
import '../../../data/models/app_user.dart';
import '../../../global_widgets/alert_variant.dart';

class PublicationDetailController extends GetxController {
  late ApiProvider provider;
  final publicationId = ''.obs;
  final client = Supabase.instance.client;

  Rxn<AppUser> user = Rxn(null);
  Rxn<Publication> publication = Rxn(null);

  final isLoading = false.obs;
  Rxn<Failure> failure = Rxn(null);
  final isDownloadProcessing = false.obs;

  @override
  void onInit() async {
    provider = GetInstance().find<ApiProvider>();
    user.value = Get.arguments[kArgumentKeyUser];
    publicationId.value = Get.arguments[kArgumentKeyPublicationId];
    FirebaseAnalytics.instance.setCurrentScreen(
      screenName: 'Publication Detail',
    );
    await loadPublicationDetail();
    super.onInit();
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
          UsageHistoryColumns.itemType.key: 'Publikasi',
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

  Future<void> handleRead() async {
    try {
      final date = DateTime.now();
      final result = await client.from(kTableUsageHistories).insert({
        UsageHistoryColumns.userId.key: user.value?.id,
        UsageHistoryColumns.serviceId.key: 4,
        UsageHistoryColumns.actionId.key: 2,
        UsageHistoryColumns.itemName.key: publication.value?.title ?? '',
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

  Future<void> loadPublicationDetail() async {
    try {
      failure.value = null;
      isLoading.value = true;
      final result = await provider.loadPublication(publicationId.value);
      result.fold(
        (failData) {
          failure.value = failData;
          FirebaseCrashlytics.instance.log(failData.message);
        },
        (resp) {
          publication.value = resp.data;
        },
      );
    } catch (e, stack) {
      FirebaseCrashlytics.instance.recordError(e, stack);
      failure.value = Failure(
        title: 'Kesalahan!',
        message: e.toString(),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
