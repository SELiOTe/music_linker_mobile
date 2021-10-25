import 'package:json_annotation/json_annotation.dart';

part 'upload_count.g.dart';

/// /music_catalog/upload_count 获取用户上传音乐总数请求与响应
///
/// @author seliote
/// @version 2021-09-22

/// 获取用户上传音乐总数请求
@JsonSerializable()
class UploadCountReq {
  // 用户 ID
  @JsonKey(name: "user_id")
  int userId;

  UploadCountReq(this.userId);

  /// JSON 反序列化
  factory UploadCountReq.fromJson(Map<String, dynamic> json) =>
      _$UploadCountReqFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$UploadCountReqToJson(this);
}

/// 获取用户上传音乐总数响应
@JsonSerializable()
class UploadCountResp {
  // 用户 ID
  @JsonKey(name: "count")
  int count;

  UploadCountResp(this.count);

  /// JSON 反序列化
  factory UploadCountResp.fromJson(Map<String, dynamic> json) =>
      _$UploadCountRespFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$UploadCountRespToJson(this);
}
