// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trust_device_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrustDeviceLoginReq _$TrustDeviceLoginReqFromJson(Map<String, dynamic> json) {
  return TrustDeviceLoginReq(
    json['phone_code'] as String,
    json['tel_no'] as String,
    json['password'] as String,
    json['device_no'] as String,
  );
}

Map<String, dynamic> _$TrustDeviceLoginReqToJson(
        TrustDeviceLoginReq instance) =>
    <String, dynamic>{
      'phone_code': instance.phoneCode,
      'tel_no': instance.telNo,
      'password': instance.password,
      'device_no': instance.deviceNo,
    };

TrustDeviceLoginResp _$TrustDeviceLoginRespFromJson(Map<String, dynamic> json) {
  return TrustDeviceLoginResp(
    json['token'] as String,
  );
}

Map<String, dynamic> _$TrustDeviceLoginRespToJson(
        TrustDeviceLoginResp instance) =>
    <String, dynamic>{
      'token': instance.token,
    };
