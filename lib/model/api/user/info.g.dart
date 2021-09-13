// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoResp _$InfoRespFromJson(Map<String, dynamic> json) {
  return InfoResp(
    json['user_id'] as int,
    json['country_code'] as String,
    json['local_name'] as String,
    json['nickname'] as String,
    json['gender'] as String,
    json['avatar'] as String,
  );
}

Map<String, dynamic> _$InfoRespToJson(InfoResp instance) => <String, dynamic>{
      'user_id': instance.userId,
      'country_code': instance.countryCode,
      'local_name': instance.localName,
      'nickname': instance.nickname,
      'gender': instance.gender,
      'avatar': instance.avatar,
    };
