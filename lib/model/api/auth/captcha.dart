import 'package:json_annotation/json_annotation.dart';

part 'captcha.g.dart';

/// /auth/captcha 获取图形验证码接口 Model
///
/// @author seliote
/// @version 2021-08-30

/// 获取图形验证码响应
@JsonSerializable()
class CaptchaResp {
  // 验证码 UUID
  @JsonKey(name: "uuid")
  String uuid;

  // 图形验证码 Base64
  @JsonKey(name: "captcha_img")
  String captchaImg;

  CaptchaResp(this.uuid, this.captchaImg);

  /// JSON 反序列化
  factory CaptchaResp.fromJson(Map<String, dynamic> json) =>
      _$CaptchaRespFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$CaptchaRespToJson(this);
}
