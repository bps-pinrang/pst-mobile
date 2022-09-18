import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';

import 'package:age_calculator/age_calculator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pst_online/app/core/enums/tables/appointment_columns.dart';
import 'package:pst_online/app/core/enums/tables/user_profile_columns.dart';
import 'package:pst_online/app/core/utils/helper.dart';
import 'package:pst_online/app/core/utils/view_helper.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/data/models/app_user.dart';
import 'package:pst_online/app/data/models/appointment.dart';
import 'package:pst_online/app/data/models/banner_model.dart';
import 'package:pst_online/app/data/models/dynamic_table/data_response.dart';
import 'package:pst_online/app/data/providers/youtube_provider.dart';
import 'package:pst_online/app/global_widgets/alert_variant.dart';
import 'package:pst_online/app/modules/home/screens/booking_history_view.dart';
import 'package:pst_online/app/modules/home/screens/main_view.dart';
import 'package:pst_online/app/modules/home/screens/notification_view.dart';
import 'package:pst_online/app/modules/home/screens/profile_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '/app/data/providers/api_provider.dart';

class HomeController extends GetxController {
  late ApiProvider provider;
  late YoutubeProvider youtubeProvider;
  final GetStorage box = GetStorage();

  final ScrollController scrollController = ScrollController();
  final CarouselController carouselController = CarouselController();
  late PersistentTabController persistentTabController;

  Rx<AppUser?> user = Rx(null);
  final client = Supabase.instance.client;
  Rxn<DataResponse> totalPopulation = Rxn(null);
  late YoutubePlayerController youtubePlayerController;

  final activeCarousel = 0.obs;
  final appName = ''.obs;
  final appVersion = ''.obs;

  final banners = List<BannerModel>.empty(growable: true).obs;
  final appointments = List<Appointment>.empty(growable: true).obs;
  final isAppointmentError = false.obs;
  final isAppointmentLoading = false.obs;
  final totalPopulationsData = List<FlSpot>.empty(growable: true).obs;
  late RealtimeSubscription realtimeAppointment;
  final pages = <Widget>[
    const MainView(),
    const NotificationView(),
    const BookingHistoryView(),
    const ProfileView(),
  ];

  final isLoggedIn = false.obs;
  final isBannerError = false.obs;
  final isBannerLoading = false.obs;

  final ReceivePort _receivePort = ReceivePort();

  @override
  void onInit() async {
    provider = GetInstance().find<ApiProvider>();
    persistentTabController = PersistentTabController(
      initialIndex: 0,
    );
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: 'z-7yCWZ6B-U',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        controlsVisibleAtStart: false,
        hideControls: false,
        hideThumbnail: false,
        loop: false,
        showLiveFullscreenButton: false,
        useHybridComposition: false,
        mute: false,
      ),
    );
    appVersion.value = await getAppVersion(
      prefix: 'Versi ',
      showBuildNumber: true,
    );
    appName.value = await getAppName();
    super.onInit();
    IsolateNameServer.registerPortWithName(
      _receivePort.sendPort,
      'downloader_send_port',
    );
    _receivePort.listen((message) {
      if ((message as List)[1] == DownloadTaskStatus.complete) {
        showGetSnackBar(
          title: 'Berhasil',
          message: 'Berhasil mengunduh publikasi!',
          variant: AlertVariant.success,
        );
      }
    });

    await Future.wait([
      _authentication(),
      loadBanners(),
      loadAppointments(),
      loadTotalPopulations(),
    ]);

    realtimeAppointment =
        client.from(kTableAppointments).on(SupabaseEventTypes.all, (payload) {
      loadAppointments();
    }).subscription;
  }

  Future<void> loadAppointments() async {
    try {
      isAppointmentError.value = false;
      isAppointmentLoading.value = true;

      final result = await client
          .from(kTableAppointments)
          .select(
              '*,services:appointment_services(service:service_id(*)),facility:facility_id(*),status:appointment_statuses(*),usage:usage_id(*)')
          .eq(AppointmentColumns.userId.key, user.value?.id)
          .execute();

      final data = result.data as List;
      appointments.value = data.map((e) => Appointment.fromJson(e)).toList();
    } catch (exception, stack) {
      FirebaseCrashlytics.instance.recordError(exception, stack);
      isAppointmentError.value = true;
    } finally {
      isAppointmentLoading.value = false;
    }
  }

  Future<void> _authentication() async {
    final session = box.read(kStorageKeySession);

    if (session != null) {
      final response = await client.auth.recoverSession(session);
      if (response.error != null) {
        box.write(kStorageKeySession, response.data?.persistSessionString);
      }
    }

    final userData = box.read(kStorageKeyUser);

    if (userData == null) {
      return;
    }

    user.value = AppUser.fromJson(jsonDecode(userData));
    await Future.wait([
      FirebaseAnalytics.instance.setUserId(id: user.value?.id),
      FirebaseAnalytics.instance.setUserProperty(
        name: kJsonKeyGender,
        value: user.value?.gender.name,
      ),
      FirebaseAnalytics.instance.setUserProperty(
        name: kJsonKeyEmail,
        value: user.value?.email,
      ),
      FirebaseAnalytics.instance.setUserProperty(
        name: kJsonKeyPhone,
        value: user.value?.phone,
      ),
      FirebaseAnalytics.instance.setUserProperty(
        name: kJsonKeyEducation,
        value: user.value?.education.name,
      ),
      FirebaseAnalytics.instance.setUserProperty(
        name: kJsonKeyJob,
        value: user.value?.userJob.name ?? user.value?.userJob.job.name,
      ),
      FirebaseAnalytics.instance.setUserProperty(
        name: kJsonKeyInstitution,
        value: user.value?.userJob.institution.name,
      ),
      FirebaseAnalytics.instance.setUserProperty(
        name: kJsonKeyCategory,
        value: user.value?.userJob.institution.institutionCategory?.name,
      ),
      FirebaseAnalytics.instance.setUserProperty(
        name: 'age',
        value: AgeCalculator.age(user.value!.birthday).years.toString(),
      ),
      FirebaseAnalytics.instance.setCurrentScreen(screenName: 'Main')
    ]);
  }

  Future<void> handleLogout() async {
    try {
      showLoadingDialog();
      await client.auth.signOut();

      if (Get.isDialogOpen!) {
        Get.back();
      }

      box.remove(kStorageKeyUser);
      box.remove(kStorageKeyToken);
      box.remove(kStorageKeySession);
      user.value = null;
      _authentication();
      persistentTabController.jumpToTab(0);
      await Future.wait([
        FirebaseAnalytics.instance.resetAnalyticsData(),
        FirebaseAnalytics.instance.logEvent(
          name: 'User Logout',
          parameters: {
            UserProfileColumns.userId.key: user.value?.id,
          },
        ),
        OneSignal.shared.removeExternalUserId(),
        OneSignal.shared.deleteTags([
          UserProfileColumns.name.key,
          UserProfileColumns.dateOfBirth.key,
          kJsonKeyInstitutionName,
          kJsonKeyInstitutionCategory,
          kJsonKeyEmail,
          kJsonKeyPhone,
          kJsonKeyGender,
          kJsonKeyInstitution,
          kJsonKeyJob,
        ])
      ]);
    } catch (e) {
      showGetSnackBar(
        title: 'Kesalahan!',
        message: 'Terjadi kesalahan saat mencoba keluar dari aplikasi!',
        variant: AlertVariant.error,
      );
    }
  }

  dynamic onPageChanged(int page, reason) {
    activeCarousel.value = page;
  }

  void onPageScrolled(double? page) {
    if (page == null) return;
    if (page > banners.length) return;
    activeCarousel.value = page.round();
  }

  Future<void> loadBanners() async {
    try {
      isBannerError.value = false;
      isBannerLoading.value = true;
      final result = await client
          .from(kTableBanners)
          .select()
          .match({
            'is_showing': true,
          })
          .limit(10)
          .order('created_at')
          .execute();

      banners.value =
          (result.data as List).map((e) => BannerModel.fromJson(e)).toList();
    } catch (e) {
      showGetSnackBar(
        title: 'Kesalahan',
        message: 'Terjadi kesalahan saat memuat banner: ${e.toString()}',
        variant: AlertVariant.error,
      );
      isBannerError.value = true;
    } finally {
      isBannerLoading.value = false;
    }
  }

  Future<void> loadTotalPopulations() async {
    try {
      final result = await provider.loadData(
        variable: '34',
        verticalVariable: '7315',
      );

      result.fold(
        (failure) {
          //
        },
        (response) {
          totalPopulation.value = response;
          final data = response.data.values.toList();
          final periods = response.dataPeriods;
          var dataPopulations = List<FlSpot>.empty(growable: true);
          final currentYear = DateTime.now().year;
          for (var i = 0; i < data.length; i++) {
            final value = int.parse(periods[i].label);
            if (value >= currentYear - 10 && value <= currentYear) {
              dataPopulations.add(
                FlSpot(
                  value.toDouble(),
                  double.parse(data[i].toString()),
                ),
              );
            }
          }

          totalPopulationsData.value = dataPopulations;
        },
      );
    } catch (e) {
      //
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    youtubePlayerController.dispose();
    persistentTabController.dispose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.onClose();
  }
}
