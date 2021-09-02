import 'package:json_annotation/json_annotation.dart';

part 'resp.g.dart';

/// 响应 Model
///
/// @author seliote
/// @version 2021-08-11

/// 响应基类
@JsonSerializable()
class Resp {
  // 响应码
  @JsonKey(name: "code")
  int code;

  // 响应码描述
  @JsonKey(name: "msg")
  String msg;

  Resp(this.code, this.msg);

  /// JSON 反序列化
  factory Resp.fromJson(Map<String, dynamic> json) => _$RespFromJson(json);

  /// 序列化
  Map<String, dynamic> toJson() => _$RespToJson(this);
}

/// 单对象响应
@JsonSerializable()
class RespObject extends Resp {
  // 响应实际数据，可为 null
  @JsonKey(name: "data")
  Map<String, dynamic>? data;

  RespObject(int code, String msg, this.data) : super(code, msg);

  /// JSON 反序列化
  factory RespObject.fromJson(Map<String, dynamic> json) =>
      _$RespObjectFromJson(json);

  /// 序列化
  Map<String, dynamic> toJson() => _$RespObjectToJson(this);
}

/// 列表对象响应
@JsonSerializable()
class RespArray extends Resp {
  // 响应实际数据，可为 null
  @JsonKey(name: "data")
  List<dynamic>? data;

  RespArray(int code, String msg, this.data) : super(code, msg);

  /// JSON 反序列化
  factory RespArray.fromJson(Map<String, dynamic> json) =>
      _$RespArrayFromJson(json);

  /// 序列化
  Map<String, dynamic> toJson() => _$RespArrayToJson(this);
}
