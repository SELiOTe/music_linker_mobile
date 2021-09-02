// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Resp _$RespFromJson(Map<String, dynamic> json) {
  return Resp(
    json['code'] as int,
    json['msg'] as String,
  );
}

Map<String, dynamic> _$RespToJson(Resp instance) => <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
    };

RespObject _$RespObjectFromJson(Map<String, dynamic> json) {
  return RespObject(
    json['code'] as int,
    json['msg'] as String,
    json['data'] as Map<String, dynamic>?,
  );
}

Map<String, dynamic> _$RespObjectToJson(RespObject instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };

RespArray _$RespArrayFromJson(Map<String, dynamic> json) {
  return RespArray(
    json['code'] as int,
    json['msg'] as String,
    json['data'] as List<dynamic>?,
  );
}

Map<String, dynamic> _$RespArrayToJson(RespArray instance) => <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'data': instance.data,
    };
