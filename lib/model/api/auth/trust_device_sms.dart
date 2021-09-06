import 'package:json_annotation/json_annotation.dart';

part 'trust_device_sms.g.dart';

/// /auth/trust_device_sms 发送信任设备短信验证码
///
/// @author seliote
/// @version 2021-09-05

@JsonSerializable()
class TrustDeviceSmsReq {
  // 图形验证码 UUID
  @JsonKey(name: "uuid")
  String uuid;

  // 图形验证码
  @JsonKey(name: "captcha")
  String captcha;

  // 国际电话区号
  @JsonKey(name: "phone_code")
  String phoneCode;

  // 手机号码
  @JsonKey(name: "tel_no")
  String telNo;

  @JsonKey(name: "device_no")
  String deviceNo;

  TrustDeviceSmsReq(
      this.uuid, this.captcha, this.phoneCode, this.telNo, this.deviceNo);

  /// JSON 反序列化
  factory TrustDeviceSmsReq.fromJson(Map<String, dynamic> json) =>
      _$TrustDeviceSmsReqFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$TrustDeviceSmsReqToJson(this);
}
