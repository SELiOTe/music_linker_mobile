// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'is_signed_up.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IsSignedUpReq _$IsSignedUpReqFromJson(Map<String, dynamic> json) {
  return IsSignedUpReq(
    json['phone_code'] as String,
    json['tel_no'] as String,
  );
}

Map<String, dynamic> _$IsSignedUpReqToJson(IsSignedUpReq instance) =>
    <String, dynamic>{
      'phone_code': instance.phoneCode,
      'tel_no': instance.telNo,
    };
