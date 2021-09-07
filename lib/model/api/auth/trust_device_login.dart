import 'package:json_annotation/json_annotation.dart';

part 'trust_device_login.g.dart';

/// /auth/trust_device_login 不受信设备登录
///
/// @author seliote
/// @version 2021-09-06

/// 受信设备登录 Req
@JsonSerializable()
class TrustDeviceLoginReq {
  // 国际电话区号
  @JsonKey(name: "phone_code")
  String phoneCode;

  // 手机号码
  @JsonKey(name: "tel_no")
  String telNo;

  // 明文密码
  @JsonKey(name: "password")
  String password;

  // 设备码
  @JsonKey(name: "device_no")
  String deviceNo;

  TrustDeviceLoginReq(this.phoneCode, this.telNo, this.password, this.deviceNo);

  /// JSON 反序列化
  factory TrustDeviceLoginReq.fromJson(Map<String, dynamic> json) =>
      _$TrustDeviceLoginReqFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$TrustDeviceLoginReqToJson(this);
}

/// 受信设备登录 Resp
@JsonSerializable()
class TrustDeviceLoginResp {
  // 用户鉴权 Token
  @JsonKey(name: "token")
  String token;

  TrustDeviceLoginResp(this.token);

  /// JSON 反序列化
  factory TrustDeviceLoginResp.fromJson(Map<String, dynamic> json) =>
      _$TrustDeviceLoginRespFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$TrustDeviceLoginRespToJson(this);
}
