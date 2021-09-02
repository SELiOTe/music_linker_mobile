import 'package:json_annotation/json_annotation.dart';

part 'country_list.g.dart';

/// /auth/country_list 列出所有国家列表接口 Model
///
/// @author seliote
/// @version 2021-08-12

/// 列出所有国家信息接口响应
@JsonSerializable()
class CountryListResp {
  // 国家码
  @JsonKey(name: "country_code")
  String countryCode;

  // 英文名称
  @JsonKey(name: "en_name")
  String enName;

  // 母语中的名称
  @JsonKey(name: "local_name")
  String localName;

  // 国际电话区号
  @JsonKey(name: "phone_code")
  String phoneCode;

  // 手机号码格式正则
  @JsonKey(name: "phone_pattern")
  String phonePattern;

  CountryListResp(this.countryCode, this.enName, this.localName, this.phoneCode,
      this.phonePattern);

  /// JSON 反序列化
  factory CountryListResp.fromJson(Map<String, dynamic> json) =>
      _$CountryListRespFromJson(json);

  /// 序列化
  Map<String, dynamic> toJson() => _$CountryListRespToJson(this);

  /// 由 JSONArray 转为 List
  ///
  /// param data JSON 数据
  /// return 转换后的 List
  static List<CountryListResp> fromJsonArray(List<dynamic>? data) {
    if (data == null) {
      return <CountryListResp>[];
    }
    var list = <CountryListResp>[];
    for (var item in data) {
      list.add(CountryListResp.fromJson(item));
    }
    return list;
  }
}
