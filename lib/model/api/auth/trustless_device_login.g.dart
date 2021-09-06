// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trustless_device_login.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrustlessDeviceLoginReq _$TrustlessDeviceLoginReqFromJson(
    Map<String, dynamic> json) {
  return TrustlessDeviceLoginReq(
    json['phone_code'] as String,
    json['tel_no'] as String,
    json['password'] as String,
    json['verify_code'] as String,
    json['device_no'] as String,
  );
}

Map<String, dynamic> _$TrustlessDeviceLoginReqToJson(
        TrustlessDeviceLoginReq instance) =>
    <String, dynamic>{
      'phone_code': instance.phoneCode,
      'tel_no': instance.telNo,
      'password': instance.password,
      'verify_code': instance.verifyCode,
      'device_no': instance.deviceNo,
    };

TrustlessDeviceLoginResp _$TrustlessDeviceLoginRespFromJson(
    Map<String, dynamic> json) {
  return TrustlessDeviceLoginResp(
    json['token'] as String,
  );
}

Map<String, dynamic> _$TrustlessDeviceLoginRespToJson(
        TrustlessDeviceLoginResp instance) =>
    <String, dynamic>{
      'token': instance.token,
    };
