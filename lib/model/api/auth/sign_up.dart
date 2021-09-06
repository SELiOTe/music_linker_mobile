import 'package:json_annotation/json_annotation.dart';

part 'sign_up.g.dart';

/// /auth/sign_up 注册接口实体
///
/// @author seliote
/// @version 2021-09-05

/// 注册请求
@JsonSerializable()
class SignUpReq {
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

  // 用户昵称
  @JsonKey(name: "nickname")
  String nickname;

  SignUpReq(this.phoneCode, this.telNo, this.password, this.verifyCode,
      this.deviceNo, this.nickname);

  /// JSON 反序列化
  factory SignUpReq.fromJson(Map<String, dynamic> json) =>
      _$SignUpReqFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$SignUpReqToJson(this);
}

/// 注册响应
@JsonSerializable()
class SignUpResp {
  // 用户鉴权 Token
  @JsonKey(name: "token")
  String token;

  SignUpResp(this.token);

  /// JSON 反序列化
  factory SignUpResp.fromJson(Map<String, dynamic> json) =>
      _$SignUpRespFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$SignUpRespToJson(this);
}
