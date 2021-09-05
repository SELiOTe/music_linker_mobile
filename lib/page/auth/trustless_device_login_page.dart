import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mlm/page/auth/auth_page.dart';

/// 非受信设备登录页
///
/// @author seliote
/// @version 2021-09-05

const TRUSTLESS_DEVICE_LOGIN_PAGE = "/auth/trustless_device_login";

/// 不受信设备登录页
class TrustlessDeviceLoginPage extends StatefulWidget {
  final AuthInfo authInfo;

  const TrustlessDeviceLoginPage(this.authInfo, {Key? key}) : super(key: key);

  @override
  _TrustlessDeviceLoginPageState createState() =>
      _TrustlessDeviceLoginPageState();
}

class _TrustlessDeviceLoginPageState extends State<TrustlessDeviceLoginPage> {
  String _password = "";
  String _verifyCode = "";
  int _countDown = 0;

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
                getVerifyCodeWidget(context, (value) => _verifyCode = value,
                    _countDown, () => null),
                getForgetPasswordWidget(context, widget.authInfo),
                getNextButton(() => null),
                SizedBox(height: 32)
              ],
            )
          ],
        ),
      ),
    );
  }
}
