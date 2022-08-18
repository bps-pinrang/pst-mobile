import 'package:package_info_plus/package_info_plus.dart';

Future<String> getAppVersion() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;
  StringBuffer buffer = StringBuffer();
  buffer.writeAll(['v', version]);
  return buffer.toString();
}
