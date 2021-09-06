import 'package:json_annotation/json_annotation.dart';

part 'trustless_device_login.g.dart';

/// /auth/trustless_device_login 不受信设备登录
///
/// @author seliote
/// @version 2021-09-06

/// 不受信设备登录 Req
@JsonSerializable()
class TrustlessDeviceLoginReq {
  // 国际电话区号
  @JsonKey(name: "phone_code")
  String phoneCode;

  // 手机号码
  @JsonKey(name: "tel_no")
  String telNo;

  // 明文密码
  @JsonKey(name: "password")
  String password;

  // 短信验证码
  @JsonKey(name: "verify_code")
  String verifyCode;

  // 设备码
  @JsonKey(name: "device_no")
  String deviceNo;

  TrustlessDeviceLoginReq(this.phoneCode, this.telNo, this.password,
      this.verifyCode, this.deviceNo);

  /// JSON 反序列化
  factory TrustlessDeviceLoginReq.fromJson(Map<String, dynamic> json) =>
      _$TrustlessDeviceLoginReqFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$TrustlessDeviceLoginReqToJson(this);
}

/// 不受信设备登录 Resp
@JsonSerializable()
class TrustlessDeviceLoginResp {
  // 用户鉴权 Token
  @JsonKey(name: "token")
  String token;

  TrustlessDeviceLoginResp(this.token);

  /// JSON 反序列化
  factory TrustlessDeviceLoginResp.fromJson(Map<String, dynamic> json) =>
      _$TrustlessDeviceLoginRespFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$TrustlessDeviceLoginRespToJson(this);
}
