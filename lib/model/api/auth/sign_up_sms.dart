import 'package:json_annotation/json_annotation.dart';

part 'sign_up_sms.g.dart';

/// /auth/sign_up_sms 发送注册验证码
///
/// @author seliote
/// @version 2021-09-02

/// 发送注册短信验证码请求
@JsonSerializable()
class SignUpSmsReq {
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

  SignUpSmsReq(this.uuid, this.captcha, this.phoneCode, this.telNo);

  /// JSON 反序列化
  factory SignUpSmsReq.fromJson(Map<String, dynamic> json) =>
      _$SignUpSmsReqFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$SignUpSmsReqToJson(this);
}
