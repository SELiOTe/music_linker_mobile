import 'package:json_annotation/json_annotation.dart';

part 'is_trust_device.g.dart';

/// /auth/is_trust_device 查询设备是否为对应帐号的受信任设备
///
/// @author seliote
/// @version 2021-09-05

/// 查询设备是否为对应帐号的受信任设备请求
@JsonSerializable()
class IsTrustDevice {
  // 国家码
  @JsonKey(name: "phone_code")
  String phoneCode;

  // 手机号码
  @JsonKey(name: "tel_no")
  String telNo;

  // 设备码
  @JsonKey(name: "device_no")
  String deviceNo;

  IsTrustDevice(this.phoneCode, this.telNo, this.deviceNo);

  /// JSON 反序列化
  factory IsTrustDevice.fromJson(Map<String, dynamic> json) =>
      _$IsTrustDeviceFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$IsTrustDeviceToJson(this);
}
