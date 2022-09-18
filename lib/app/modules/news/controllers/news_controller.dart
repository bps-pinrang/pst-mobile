import 'dart:convert';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/data/models/app_user.dart';
import 'package:pst_online/app/data/models/news.dart';
import 'package:pst_online/app/global_widgets/alert_variant.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/enums/tables/usage_history_columns.dart';
import '../../../core/exceptions/app_exception.dart';
import '../../../core/utils/helper.dart';
import '../../../core/values/strings.dart';
import '../../../data/models/api_meta.dart';
import '../../../data/models/news_category.dart';
import '../../../data/providers/api_provider.dart';

class NewsController extends GetxController {
  final box = GetStorage();
  late ApiProvider provider;

  Rxn<ApiMeta> apiMeta = Rxn(null);
  final client = Supabase.instance.client;
  late PagingController<int, News> pagingController;
  final ScrollController scrollController = ScrollController();

  final isNewsLoading = false.obs;
  final isApiMetaLoaded = false.obs;
  final isNewsCategoryError = false.obs;
  final isNewsCategoryLoading = false.obs;

  final pageSize = 10.obs;
  final currentPage = 1.obs;

  final monthName = ''.obs;
  Rxn<AppUser> user = Rxn(null);
  Rxn<String> selectedYear = Rxn(null);
  Rxn<String> selectedMonth = Rxn(null);
  Rxn<NewsCategory> selectedCategory = Rxn(null);
  final newsCategories = List<NewsCategory>.empty(growable: true).obs;

  @override
  void onInit() async {
    provider = GetInstance().find<ApiProvider>();
    pagingController = PagingController(firstPageKey: 1)
      ..addPageRequestListener(loadNews);
    final userData = box.read(kStorageKeyUser);
    if (userData != null) {
      user.value = AppUser.fromJson(jsonDecode(userData));
    }
    super.onInit();
    await loadNewsCategories();
    await FirebaseAnalytics.instance.setCurrentScreen(screenName: 'News');
  }

  void applyYearFilter(String? year) {
    selectedYear.value = year;
    reset();
  }

  void applyMonthFilter(String? month) {
    selectedMonth.value = month;
    reset();
  }

  void applyCategoryFilter(NewsCategory? category) {
    selectedCategory.value = category;
    reset();
  }

  void reset() {
    currentPage.value = 0;
    apiMeta.value = null;
    isApiMetaLoaded.value = false;
    pagingController.refresh();
  }

  Future<void> loadNews(int page) async {
    try {
      isNewsLoading.value = true;

      final result = await provider.loadNews(
        page,
        year: selectedYear.value,
        month: selectedMonth.value,
        newsCategory: selectedCategory.value?.id,
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
    } catch (exception, stack) {
      pagingController.error = exception.toString();
      FirebaseCrashlytics.instance.recordError(exception, stack);
    } finally {
      isNewsLoading.value = false;
    }
  }

  Future<void> loadNewsCategories() async {
    try {
      isNewsCategoryError.value = false;
      isNewsCategoryLoading.value = true;

      final result = await provider.loadNewsCategories();

      result.fold(
        (failure) {
          isNewsCategoryError.value = true;
          showGetSnackBar(
            title: 'Kesalahan',
            message: failure.message,
            variant: AlertVariant.error,
          );
        },
        (data) => newsCategories.value = data.data,
      );
    } catch (exception, stack) {
      FirebaseCrashlytics.instance.recordError(exception, stack);
      isNewsCategoryError.value = true;
      showGetSnackBar(
        title: 'Kesalahan',
        message: exception.toString(),
        variant: AlertVariant.error,
      );
    } finally {
      isNewsCategoryLoading.value = false;
    }
  }

  Future<void> handleRead(News news) async {
    try {
      final date = DateTime.now();
      FirebaseAnalytics.instance.logSelectContent(
        contentType: 'Berita',
        itemId: news.title,
      );
      if (user.value != null) {
        final result = await client.from(kTableUsageHistories).insert({
          UsageHistoryColumns.userId.key: user.value?.id,
          UsageHistoryColumns.serviceId.key: 4,
          UsageHistoryColumns.actionId.key: 2,
          UsageHistoryColumns.itemName.key: news.title,
          UsageHistoryColumns.itemType.key: 'Berita',
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
    pagingController.dispose();
    super.onClose();
  }
}
