import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:intl/intl.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path_provider_android/path_provider_android.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pst_online/app/core/exceptions/app_exception.dart';

import '../../data/models/app_user.dart';
import '../enums/tables/user_profile_columns.dart';
import '../values/strings.dart';

Future<String> getAppVersion(
    {String prefix = 'v', bool showBuildNumber = false}) async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  StringBuffer buffer = StringBuffer();
  buffer.writeAll([prefix, version]);
  if (showBuildNumber) {
    buffer.writeAll([' - ', packageInfo.buildNumber]);
  }
  return buffer.toString();
}

Future<String> getAppName() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.appName;
}

String formatDate(String format, DateTime? date,
    {String placeholder = '', bool showTimezone = true}) {
  if (date == null) {
    return placeholder;
  }

  if (format.contains('hh') || format.contains('mm') || format.contains('HH')) {
    return showTimezone
        ? '${DateFormat(format, 'id_ID').format(date)} ${date.timeZoneName}'
        : DateFormat(format, 'id_ID').format(date);
  }
  return DateFormat(format, 'id_ID').format(date);
}

void registerOneSignalUser(AppUser user) {
  OneSignal.shared.setExternalUserId(user.id);
  OneSignal.shared.sendTags({
    UserProfileColumns.name.key: user.name,
    UserProfileColumns.dateOfBirth.key: user.birthday.toString(),
    kJsonKeyPhone: user.phone,
    kJsonKeyEmail: user.email,
    kJsonKeyGender: user.gender.name,
    kJsonKeyInstitutionName: user.userJob.institution.name,
    kJsonKeyInstitutionCategory:
        user.userJob.institution.institutionCategory?.name,
    kJsonKeyJob: user.userJob.name ?? user.userJob.job.name,
  });
}

Future<String?> downloadFile(
    String url, String fileName, String extension) async {
  final result = await Permission.storage.status;

  if (result != PermissionStatus.granted) {
    await Permission.storage.request();
  }

  Directory? directory;

  if (Platform.isIOS) {
    directory = await getApplicationDocumentsDirectory();
  } else if (Platform.isAndroid) {
    try {
      directory = Directory((await PathProviderAndroid().getDownloadsPath())!);
    } catch (e) {
      directory = await getExternalStorageDirectory();
    }
  }

  if (directory == null) {
    throw AppException('Gagal mengambil lokasi unduhan!');
  }

  final path = Platform.isIOS ? directory.absolute.path : directory.path;

  final taskId = await FlutterDownloader.enqueue(
    url: url,
    savedDir: path,
    showNotification: true,
    openFileFromNotification: true,
    requiresStorageNotLow: true,
    saveInPublicStorage: true,
    fileName: '$fileName.$extension',
  );
  return taskId;
}

@pragma('vm:entry-point')
void downloadCallback(String id, DownloadTaskStatus status, int progress) {
  final SendPort? send =
      IsolateNameServer.lookupPortByName('downloader_send_port');
  send?.send([id, status, progress]);
}
