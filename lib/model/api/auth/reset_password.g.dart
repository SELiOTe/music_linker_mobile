// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reset_password.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResetPasswordReq _$ResetPasswordReqFromJson(Map<String, dynamic> json) {
  return ResetPasswordReq(
    json['phone_code'] as String,
    json['tel_no'] as String,
    json['password'] as String,
    json['verify_code'] as String,
    json['device_no'] as String,
  );
}

Map<String, dynamic> _$ResetPasswordReqToJson(ResetPasswordReq instance) =>
    <String, dynamic>{
      'phone_code': instance.phoneCode,
      'tel_no': instance.telNo,
      'password': instance.password,
      'verify_code': instance.verifyCode,
      'device_no': instance.deviceNo,
    };

ResetPasswordResp _$ResetPasswordRespFromJson(Map<String, dynamic> json) {
  return ResetPasswordResp(
    json['token'] as String,
  );
}

Map<String, dynamic> _$ResetPasswordRespToJson(ResetPasswordResp instance) =>
    <String, dynamic>{
      'token': instance.token,
    };
