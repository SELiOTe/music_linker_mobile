import 'package:flutter/material.dart';
import 'package:mlm/util/http_utils.dart';
import 'package:mlm/util/sp_utils.dart';

import 'auth/auth_page.dart';
import 'home_page.dart';

/// Splash 页
///
/// @author seliote
/// @version 2021-08-07

/// Splash 页 Widget
class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 获取本地缓存的 Token 决定跳转页面
    SpUtils.getInstance().then((sp) {
      var token = sp.getString(SP_TOKEN);
      // addPostFrameCallback 在当前 Frame 绘制完成后回调进行跳转
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        if (token == null || token.isEmpty) {
          debugPrint("Empty token, navigate to auth page");
          Navigator.pushReplacementNamed(context, AUTH_PAGE);
        } else {
          // 设置 Token
          HttpUtils.token = token;
          debugPrint("Find token, navigate to home page");
          Navigator.pushReplacementNamed(context, HOME_PAGE);
        }
      });
    });
    return Container(color: Colors.white);
  }
}
