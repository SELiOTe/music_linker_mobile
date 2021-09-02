// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryListResp _$CountryListRespFromJson(Map<String, dynamic> json) {
  return CountryListResp(
    json['country_code'] as String,
    json['en_name'] as String,
    json['local_name'] as String,
    json['phone_code'] as String,
    json['phone_pattern'] as String,
  );
}

Map<String, dynamic> _$CountryListRespToJson(CountryListResp instance) =>
    <String, dynamic>{
      'country_code': instance.countryCode,
      'en_name': instance.enName,
      'local_name': instance.localName,
      'phone_code': instance.phoneCode,
      'phone_pattern': instance.phonePattern,
    };
