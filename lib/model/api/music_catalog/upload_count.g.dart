// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_count.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadCountReq _$UploadCountReqFromJson(Map<String, dynamic> json) {
  return UploadCountReq(
    json['user_id'] as int,
  );
}

Map<String, dynamic> _$UploadCountReqToJson(UploadCountReq instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
    };

UploadCountResp _$UploadCountRespFromJson(Map<String, dynamic> json) {
  return UploadCountResp(
    json['count'] as int,
  );
}

Map<String, dynamic> _$UploadCountRespToJson(UploadCountResp instance) =>
    <String, dynamic>{
      'count': instance.count,
    };
