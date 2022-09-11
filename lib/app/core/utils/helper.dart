import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<String> getAppVersion({String prefix = 'v', bool showBuildNumber = false}) async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  StringBuffer buffer = StringBuffer();
  buffer.writeAll([prefix, version]);
  if(showBuildNumber) {
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
