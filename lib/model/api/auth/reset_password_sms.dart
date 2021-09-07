import 'package:json_annotation/json_annotation.dart';

part 'reset_password_sms.g.dart';

/// /auth/reset_password_sms 发送重置密码短信验证码
///
/// @author seliote
/// @version 2021-09-02

/// 重置密码短信验证码请求
@JsonSerializable()
class ResetPasswordSmsReq {
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

  ResetPasswordSmsReq(this.uuid, this.captcha, this.phoneCode, this.telNo);

  /// JSON 反序列化
  factory ResetPasswordSmsReq.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordSmsReqFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$ResetPasswordSmsReqToJson(this);
}
