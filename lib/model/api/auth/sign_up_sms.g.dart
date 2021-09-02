// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_sms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpSmsReq _$SignUpSmsReqFromJson(Map<String, dynamic> json) {
  return SignUpSmsReq(
    json['uuid'] as String,
    json['captcha'] as String,
    json['phone_code'] as String,
    json['tel_no'] as String,
  );
}

Map<String, dynamic> _$SignUpSmsReqToJson(SignUpSmsReq instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'captcha': instance.captcha,
      'phone_code': instance.phoneCode,
      'tel_no': instance.telNo,
    };
