import 'package:package_info_plus/package_info_plus.dart';

class PackageInfoUtils {
  static Future<String> appVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }
}
