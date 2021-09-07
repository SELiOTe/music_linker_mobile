import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mlm/model/api/auth/trust_device_sms.dart';
import 'package:mlm/model/api/auth/trustless_device_login.dart';
import 'package:mlm/page/auth/auth_page.dart';
import 'package:mlm/page/home_page.dart';
import 'package:mlm/util/const_utils.dart';
import 'package:mlm/util/http_utils.dart';
import 'package:mlm/util/sp_utils.dart';
import 'package:mlm/util/ui_utils.dart';

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

  // 倒计时相关
  Timer? _timer;
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
                    _countDown, _getVerifyCode),
                getForgetPasswordWidget(context, widget.authInfo),
                getNextButton(_nextStepOnPressed)
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  void _getVerifyCode() async {
    // 图形验证码弹窗并校验后请求发送验证码
    var result = await getCaptchaAndSendVerifyCode(context);
    if (result == null) {
      return;
    }
    if (result.uuid == null ||
        result.captcha == null ||
        !RegExp(CAPTCHA_REGEX).hasMatch(result.captcha!)) {
      showToast(AppLocalizations.of(context)!.captchaDialogCaptchaIncorrect);
      return;
    }
    // 发送验证码接口
    var req = TrustDeviceSmsReq(
        result.uuid!,
        result.captcha!,
        widget.authInfo.phoneCode,
        widget.authInfo.telNo,
        widget.authInfo.deviceNo);
    var resp =
        await HttpUtils.post4Object("/auth/trust_device_sms", reqBody: req);
    if (resp == null) {
      return;
    }
    if (resp.code == 0) {
      // 成功，验证码按钮倒数
      _startTimer();
      showToast(AppLocalizations.of(context)!
          .trustlessDeviceLoginPageSendVerifyCodeSuccess);
      return;
    } else if (resp.code == 1) {
      // 验证码不正确
      showToast(AppLocalizations.of(context)!.captchaDialogCaptchaIncorrect);
      _getVerifyCode();
      return;
    } else if (resp.code == 2) {
      // 用户未注册
      showToast(AppLocalizations.of(context)!.loginPageUserNotSignedUp);
      Navigator.pushNamedAndRemoveUntil(context, AUTH_PAGE, (route) => false);
      return;
    } else if (resp.code == 3) {
      // 已是受信任设备
      showToast(
          AppLocalizations.of(context)!.trustlessDeviceLoginPageDeviceTrusted);
      Navigator.pushNamedAndRemoveUntil(context, AUTH_PAGE, (route) => false);
      return;
    } else {
      showToast(AppLocalizations.of(context)!.loginPageUserNotSignedUp);
      return;
    }
  }

  /// 开启验证码倒计时
  void _startTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    _countDown = 60;
    const period = const Duration(seconds: 1);
    _timer = Timer.periodic(period, (timer) {
      setState(() {
        if (_countDown > 0) {
          _countDown -= 1;
        } else {
          timer.cancel();
        }
      });
    });
  }

  /// 下一步按钮点击事件
  void _nextStepOnPressed() async {
    if (!RegExp(PASSWORD_REGEX).hasMatch(_password)) {
      showToast(AppLocalizations.of(context)!.loginPagePasswordIncorrect);
      return;
    }
    if (!RegExp(VERIFY_CODE_REGEX).hasMatch(_verifyCode)) {
      showToast(AppLocalizations.of(context)!
          .trustlessDeviceLoginPageVerifyCodeIncorrect);
      return;
    }
    var req = TrustlessDeviceLoginReq(
        widget.authInfo.phoneCode,
        widget.authInfo.telNo,
        _password,
        _verifyCode,
        widget.authInfo.deviceNo);
    var resp = await HttpUtils.post4Object("/auth/trustless_device_login",
        reqBody: req);
    if (resp == null) {
      return;
    }
    if (resp.code == 0) {
      var respModel = TrustlessDeviceLoginResp.fromJson(resp.data!);
      HttpUtils.token = respModel.token;
      var sp = await SpUtils.getInstance();
      sp.setString(SP_TOKEN, respModel.token);
      Navigator.pushNamedAndRemoveUntil(context, HOME_PAGE, (route) => false);
      return;
    } else if (resp.code == 1) {
      // 短信验证码不正确
      showToast(AppLocalizations.of(context)!
          .trustlessDeviceLoginPageVerifyCodeIncorrect);
      return;
    } else if (resp.code == 2) {
      // 帐号或密码不正确
      showToast(AppLocalizations.of(context)!.loginPagePasswordIncorrect);
      return;
    } else {
      // 服务器存在问题
      showToast(AppLocalizations.of(context)!.serverError);
      return;
    }
  }
}
