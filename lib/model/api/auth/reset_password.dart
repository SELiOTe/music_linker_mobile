import 'package:json_annotation/json_annotation.dart';

part 'reset_password.g.dart';

/// /auth/reset_password 重置密码实体
///
/// @author seliote
/// @version 2021-09-05

/// 重置密码请求
@JsonSerializable()
class ResetPasswordReq {
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

  ResetPasswordReq(this.phoneCode, this.telNo, this.password, this.verifyCode,
      this.deviceNo);

  /// JSON 反序列化
  factory ResetPasswordReq.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordReqFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$ResetPasswordReqToJson(this);
}

/// 重置密码响应
@JsonSerializable()
class ResetPasswordResp {
  // 用户鉴权 Token
  @JsonKey(name: "token")
  String token;

  ResetPasswordResp(this.token);

  /// JSON 反序列化
  factory ResetPasswordResp.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRespFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$ResetPasswordRespToJson(this);
}
