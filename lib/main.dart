import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:pst_online/app/core/extensions/custom_color.dart';
import 'package:pst_online/app/core/services/theme_service.dart';
import 'package:pst_online/app/core/values/strings.dart';
import 'package:pst_online/app/core/values/theme.dart';
import 'package:pst_online/i18n/strings.g.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'firebase_options.dart';

import 'app/core/services/connectivity_service.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  initializeDateFormatting('id_ID');
  Intl.defaultLocale = 'id_ID';
  LocaleSettings.useDeviceLocale();
  await FlutterDownloader.initialize(
    debug: true,
    ignoreSsl: true,
  );
  await GetStorage.init();
  await FlutterConfig.loadEnvVariables();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Supabase.initialize(
    url: FlutterConfig.get(kEnvKeySupabaseApiUrl),
    anonKey: FlutterConfig.get(kEnvKeySupabaseApiKey),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await oneSignalInitialization();

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  Get.putAsync(() => ConnectivityService().init());
  setPluralization();
  runApp(TranslationProvider(child: const MyApp()));
}

Future oneSignalInitialization() async {
  if (kDebugMode) {
    await OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  }

  await OneSignal.shared.setAppId(FlutterConfig.get(kEnvKeyOneSignalAppId));
  OneSignal.shared.setRequiresUserPrivacyConsent(false);

  OneSignal.shared.setNotificationOpenedHandler(
    (openedResult) {},
  );

  OneSignal.shared.setNotificationWillShowInForegroundHandler(
    (event) {
      event.complete(event.notification);
    },
  );
}

void setPluralization() {
  LocaleSettings.setPluralResolver(
    language: 'id',
    cardinalResolver: (
      num n, {
      String? zero,
      String? one,
      String? two,
      String? few,
      String? many,
      String? other,
    }) {
      return one ?? other ?? '';
    },
    ordinalResolver: (
      num n, {
      String? zero,
      String? one,
      String? two,
      String? few,
      String? many,
      String? other,
    }) {
      return one ?? other ?? '';
    },
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'PST Mobile',
      debugShowCheckedModeBanner: false,
      locale: TranslationProvider.of(context).flutterLocale,
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      theme: getTheme(Brightness.light, true).copyWith(
        extensions: [lightCustomColors],
        textTheme: GoogleFonts.openSansTextTheme(ThemeData.light().textTheme),
      ),
      darkTheme: getTheme(Brightness.dark, true).copyWith(
        extensions: [darkCustomColors],
        textTheme: GoogleFonts.openSansTextTheme(ThemeData.dark().textTheme),
      ),
      themeMode: ThemeService().themeMode,
    );
  }
}
