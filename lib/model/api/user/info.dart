import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

/// /user/info 获取用户个人信息
///
/// @author seliote
/// @version 2021-09-12

/// 获取用户个人信息响应
@JsonSerializable()
class InfoResp {
  // 用户 ID
  @JsonKey(name: "user_id")
  int userId;

  // 国家码
  @JsonKey(name: "country_code")
  String countryCode;

  // 母语中的名称
  @JsonKey(name: "local_name")
  String localName;

  // 用户昵称
  @JsonKey(name: "nickname")
  String nickname;

  // 用户性别
  @JsonKey(name: "gender")
  int gender;

  // 用户头像
  @JsonKey(name: "avatar")
  String avatar;

  InfoResp(this.userId, this.countryCode, this.localName, this.nickname,
      this.gender, this.avatar);

  /// JSON 反序列化
  factory InfoResp.fromJson(Map<String, dynamic> json) =>
      _$InfoRespFromJson(json);

  /// JSON 序列化
  Map<String, dynamic> toJson() => _$InfoRespToJson(this);
}
