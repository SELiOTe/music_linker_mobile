// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadListReq _$UploadListReqFromJson(Map<String, dynamic> json) {
  return UploadListReq(
    json['user_id'] as int,
  );
}

Map<String, dynamic> _$UploadListReqToJson(UploadListReq instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
    };

UploadListResp _$UploadListRespFromJson(Map<String, dynamic> json) {
  return UploadListResp(
    json['singer_id'] as int,
    json['singer_name'] as String,
    json['music_id'] as int,
    json['music_name'] as String,
  );
}

Map<String, dynamic> _$UploadListRespToJson(UploadListResp instance) =>
    <String, dynamic>{
      'singer_id': instance.singerId,
      'singer_name': instance.singerName,
      'music_id': instance.musicId,
      'music_name': instance.musicName,
    };
