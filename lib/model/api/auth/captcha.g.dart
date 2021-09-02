// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'captcha.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CaptchaResp _$CaptchaRespFromJson(Map<String, dynamic> json) {
  return CaptchaResp(
    json['uuid'] as String,
    json['captcha_img'] as String,
  );
}

Map<String, dynamic> _$CaptchaRespToJson(CaptchaResp instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'captcha_img': instance.captchaImg,
    };
