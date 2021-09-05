// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_trust_device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IsTrustDevice _$IsTrustDeviceFromJson(Map<String, dynamic> json) {
  return IsTrustDevice(
    json['phone_code'] as String,
    json['tel_no'] as String,
    json['device_no'] as String,
  );
}

Map<String, dynamic> _$IsTrustDeviceToJson(IsTrustDevice instance) =>
    <String, dynamic>{
      'phone_code': instance.phoneCode,
      'tel_no': instance.telNo,
      'device_no': instance.deviceNo,
    };
