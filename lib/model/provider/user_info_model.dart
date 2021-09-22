import 'package:flutter/material.dart';

/// 应用全局 Provider 模型
///
/// @author seliote
/// @version 2021-08-07

/// 用户信息 Provider 模型
class UserInfoModel with ChangeNotifier {
  // 用户 ID
  int? _userId;

  int? get userId => _userId;

  set userId(int? userId) {
    _userId = userId;
    notifyListeners();
  }

  // 国家码
  String? _countryCode;

  String? get countryCode => _countryCode;

  set countryCode(String? countryCode) {
    _countryCode = countryCode;
    notifyListeners();
  }

  // 母语中的名称
  String? _localName;

  String? get localName => _localName;

  set localName(String? localName) {
    _localName = localName;
    notifyListeners();
  }

  // 用户昵称
  String? _nickname;

  String? get nickname => _nickname;

  set nickname(String? nickname) {
    _nickname = nickname;
    notifyListeners();
  }

  // 用户性别
  int? _gender;

  int? get gender => _gender;

  set gender(int? gender) {
    _gender = gender;
    notifyListeners();
  }

  // 用户昵称
  String? _avatar;

  String? get avatar => _avatar;

  set avatar(String? avatar) {
    _avatar = avatar;
    notifyListeners();
  }
}
