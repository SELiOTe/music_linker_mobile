// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trust_device_sms.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrustDeviceSmsReq _$TrustDeviceSmsReqFromJson(Map<String, dynamic> json) {
  return TrustDeviceSmsReq(
    json['uuid'] as String,
    json['captcha'] as String,
    json['phone_code'] as String,
    json['tel_no'] as String,
    json['device_no'] as String,
  );
}

Map<String, dynamic> _$TrustDeviceSmsReqToJson(TrustDeviceSmsReq instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'captcha': instance.captcha,
      'phone_code': instance.phoneCode,
      'tel_no': instance.telNo,
      'device_no': instance.deviceNo,
    };
