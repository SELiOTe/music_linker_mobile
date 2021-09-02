import 'package:json_annotation/json_annotation.dart';

part 'is_signed_up.g.dart';

/// /auth/is_signed_up 用户是否注册接口 Model
///
/// @author seliote
/// @version 2021-08-23

/// 用户是否注册请求
@JsonSerializable()
class IsSignedUpReq {
  // 国家码
  @JsonKey(name: "phone_code")
  String phoneCode;

  // 手机号码
  @JsonKey(name: "tel_no")
  String telNo;

  IsSignedUpReq(this.phoneCode, this.telNo);

  /// JSON 反序列化
  factory IsSignedUpReq.fromJson(Map<String, dynamic> json) =>
      _$IsSignedUpReqFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$IsSignedUpReqToJson(this);
}
