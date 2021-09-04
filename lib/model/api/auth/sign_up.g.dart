// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpReq _$SignUpReqFromJson(Map<String, dynamic> json) {
  return SignUpReq(
    json['phone_code'] as String,
    json['tel_no'] as String,
    json['password'] as String,
    json['verify_code'] as String,
    json['device_no'] as String,
  );
}

Map<String, dynamic> _$SignUpReqToJson(SignUpReq instance) => <String, dynamic>{
      'phone_code': instance.phoneCode,
      'tel_no': instance.telNo,
      'password': instance.password,
      'verify_code': instance.verifyCode,
      'device_no': instance.deviceNo,
    };

SignUpResp _$SignUpRespFromJson(Map<String, dynamic> json) {
  return SignUpResp(
    json['token'] as String,
  );
}

Map<String, dynamic> _$SignUpRespToJson(SignUpResp instance) =>
    <String, dynamic>{
      'token': instance.token,
    };
