import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:get/get.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/data/providers/api_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../data/models/app_user.dart';
import '../../../data/models/failure.dart';
import '../../../data/models/news.dart';

class NewsDetailController extends GetxController {
  late ApiProvider provider;
  final newsId = ''.obs;
  final client = Supabase.instance.client;

  Rxn<News> news = Rxn(null);
  Rxn<AppUser> user = Rxn(null);

  final isLoading = false.obs;
  Rxn<Failure> failure = Rxn(null);

  @override
  void onInit() async {
    provider = GetInstance().find<ApiProvider>();
    newsId.value = Get.arguments[kArgumentKeyId];
    user.value = Get.arguments[kArgumentKeyUser];
    FirebaseAnalytics.instance.setCurrentScreen(screenName: 'News Detail');
    await loadNewsDetail();
    super.onInit();
  }

  Future<void> loadNewsDetail() async {
    try {
      failure.value = null;
      isLoading.value = true;
      final result = await provider.loadNewsDetail(newsId.value);
      result.fold(
        (failData) {
          failure.value = failData;
          FirebaseCrashlytics.instance.log(failData.message);
        },
        (resp)=>   news.value = resp.data,
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
