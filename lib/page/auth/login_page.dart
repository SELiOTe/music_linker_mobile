import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mlm/page/auth/auth_page.dart';
import 'package:mlm/page/auth/reset_password.dart';
import 'package:mlm/util/const_utils.dart';
import 'package:mlm/util/ui_utils.dart';

/// 登录页
///
/// @author seliote
/// @version 2021-08-24

const LOGIN_PAGE = "/auth/login";

/// 登录页
class LoginPage extends StatefulWidget {
  final AuthInfo authInfo;

  const LoginPage(this.authInfo, {Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: getGradientBackgroundDecoration(),
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                getReturnTelNoPage(),
                getTitle(AppLocalizations.of(context)!.loginPageTitle),
                getPasswordWidget(true, (value) => _password = value),
                _getForgetPasswordWidget(),
                getNextButton(_nextStepOnPress)
              ],
            )
          ],
        ),
      ),
    );
  }

  /// 忘记密码组件
  Widget _getForgetPasswordWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        children: <Widget>[
          SizedBox(width: 8),
          TextButton(
              child: Text(AppLocalizations.of(context)!.loginPageForgetPassword,
                  style: TextStyle(color: Colors.white)),
              onPressed: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, RESET_PASSWORD_PAGE, (route) => false,
                    arguments: widget.authInfo);
              }),
          Expanded(child: Container())
        ],
      ),
    );
  }

  /// 下一步按钮点击
  void _nextStepOnPress() async {
    if (!RegExp(PASSWORD_REGEX).hasMatch(_password)) {
      showToast(AppLocalizations.of(context)!.signUpPagePasswordTooSimple);
      return;
    }
    // 直接调用登录接口判断是否是受信任设备
    // 根据返回码来判断是否需要调用新设备登录
  }
}
