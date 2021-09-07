// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password_sms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordSmsReq _$ResetPasswordSmsReqFromJson(Map<String, dynamic> json) {
  return ResetPasswordSmsReq(
    json['uuid'] as String,
    json['captcha'] as String,
    json['phone_code'] as String,
    json['tel_no'] as String,
  );
}

Map<String, dynamic> _$ResetPasswordSmsReqToJson(
        ResetPasswordSmsReq instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'captcha': instance.captcha,
      'phone_code': instance.phoneCode,
      'tel_no': instance.telNo,
    };
