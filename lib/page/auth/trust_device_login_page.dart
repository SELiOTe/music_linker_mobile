import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mlm/page/auth/auth_page.dart';
import 'package:mlm/util/const_utils.dart';
import 'package:mlm/util/ui_utils.dart';

/// 登录页
///
/// @author seliote
/// @version 2021-08-24

const TRUST_DEVICE_LOGIN_PAGE = "/auth/trust_device_login";

/// 受信设备登录页
class TrustDeviceLoginPage extends StatefulWidget {
  final AuthInfo authInfo;

  const TrustDeviceLoginPage(this.authInfo, {Key? key}) : super(key: key);

  @override
  _TrustDeviceLoginPageState createState() => _TrustDeviceLoginPageState();
}

class _TrustDeviceLoginPageState extends State<TrustDeviceLoginPage> {
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
                getForgetPasswordWidget(context, widget.authInfo),
                getNextButton(_nextStepOnPress),
                SizedBox(height: 32)
              ],
            )
          ],
        ),
      ),
    );
  }

  /// 下一步按钮点击
  void _nextStepOnPress() async {
    if (!RegExp(PASSWORD_REGEX).hasMatch(_password)) {
      showToast(AppLocalizations.of(context)!.loginPagePasswordIncorrect);
      return;
    }
    // 登录接口
  }
}
