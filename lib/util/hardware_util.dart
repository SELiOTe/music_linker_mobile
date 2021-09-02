import 'dart:io';

import 'package:device_info/device_info.dart';

/// 硬件工具
///
/// @author seliote
/// @version 2021-08-24

/// 获取设备 ID
///
/// return 设备 ID，当未获取到时返回空字符串
///        设备为非 Android, iOS 时抛出
Future<String> deviceId() async {
  var deviceInfoPlugin = DeviceInfoPlugin();
  var deviceId = "";
  if (Platform.isAndroid) {
    var androidInfo = await deviceInfoPlugin.androidInfo;
    deviceId = androidInfo.androidId;
  } else if (Platform.isIOS) {
    var iosInfo = await deviceInfoPlugin.iosInfo;
    deviceId = iosInfo.identifierForVendor;
  } else {
    throw Exception("Nonsupport platform ${Platform.operatingSystem}");
  }
  return deviceId;
}
