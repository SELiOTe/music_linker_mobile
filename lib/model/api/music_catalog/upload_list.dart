import 'package:json_annotation/json_annotation.dart';

part 'upload_list.g.dart';

/// /music_catalog/upload_list 获取用户上传音乐列表
///
/// @author seliote
/// @version 2021-09-27

/// 获取用户上传音乐列表请求
@JsonSerializable()
class UploadListReq {
  // 歌手 ID
  @JsonKey(name: "user_id")
  int userId;

  UploadListReq(this.userId);

  /// JSON 反序列化
  factory UploadListReq.fromJson(Map<String, dynamic> json) =>
      _$UploadListReqFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$UploadListReqToJson(this);
}

/// 获取用户上传音乐列表响应
@JsonSerializable()
class UploadListResp {
  // 歌手 ID
  @JsonKey(name: "singer_id")
  int singerId;

  // 歌手名称
  @JsonKey(name: "singer_name")
  String singerName;

  // 歌曲 ID
  @JsonKey(name: "music_id")
  int musicId;

  // 歌曲名称
  @JsonKey(name: "music_name")
  String musicName;

  UploadListResp(this.singerId, this.singerName, this.musicId, this.musicName);

  /// JSON 反序列化
  factory UploadListResp.fromJson(Map<String, dynamic> json) =>
      _$UploadListRespFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$UploadListRespToJson(this);

  /// 由 JSONArray 转为 List
  ///
  /// param data JSON 数据
  /// return 转换后的 List
  static List<UploadListResp> fromJsonArray(List<dynamic>? data) {
    if (data == null) {
      return <UploadListResp>[];
    }
    var list = <UploadListResp>[];
    for (var item in data) {
      list.add(UploadListResp.fromJson(item));
    }
    return list;
  }
}
