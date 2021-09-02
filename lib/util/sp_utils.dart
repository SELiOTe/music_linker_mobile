import 'package:shared_preferences/shared_preferences.dart';

/// shared_preferences 工具
///
/// @author seliote
/// @version 2021-08-07

// token key
const SP_TOKEN = "token";

/// SharedPreferences 工具类
class SpUtils {
  // 单例引用
  static SharedPreferences? _sharedPreferences;

  /// 获取 SharedPreferences 实例
  ///
  /// return SharedPreferences 实例
  static Future<SharedPreferences> getInstance() async {
    if (_sharedPreferences != null) {
      return _sharedPreferences!;
    }
    _sharedPreferences = await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }
}
