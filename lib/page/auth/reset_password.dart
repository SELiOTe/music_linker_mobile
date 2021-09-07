import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mlm/model/api/auth/reset_password_sms.dart';
import 'package:mlm/page/auth/auth_page.dart';
import 'package:mlm/util/const_utils.dart';
import 'package:mlm/util/http_utils.dart';
import 'package:mlm/util/ui_utils.dart';

/// 重置密码页
///
/// @author seliote
/// @version 2021-09-05

const RESET_PASSWORD_PAGE = "/auth/reset_password";

/// 重置密码
class ResetPasswordPage extends StatefulWidget {
  final AuthInfo authInfo;

  const ResetPasswordPage(this.authInfo, {Key? key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  // 密码与验证码
  String _password = "";
  String _verifyCode = "";

  // 验证码倒计时相关
  Timer? _timer;
  int _countDown = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: getGradientBackgroundDecoration(),
          child: ListView(children: <Widget>[
            Column(children: <Widget>[
              getReturnTelNoPage(),
              getTitle(AppLocalizations.of(context)!.resetPasswordPageTitle),
              getPasswordWidget(false, (value) => _password = value),
              getVerifyCodeWidget(context, (value) => _verifyCode = value,
                  _countDown, _getVerifyCode),
              SizedBox(height: 32),
              getNextButton(() => null)
            ])
          ])),
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

  /// 获取验证码按钮点击事件
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
    var req = ResetPasswordSmsReq(result.uuid!, result.captcha!,
        widget.authInfo.phoneCode, widget.authInfo.telNo);
    var resp =
        await HttpUtils.post4Object("/auth/reset_password_sms", reqBody: req);
    if (resp == null) {
      return;
    }
    if (resp.code == 0) {
      // 成功，验证码按钮倒数
      _startTimer();
      showToast(
          AppLocalizations.of(context)!.resetPasswordPageVerifyCodeSendSuccess);
      return;
    } else if (resp.code == 1) {
      // 验证码不正确
      showToast(
          AppLocalizations.of(context)!.resetPasswordPageCpatchaIncorrect);
      _getVerifyCode();
      return;
    } else if (resp.code == 2) {
      // 用户尚未注册
      showToast(AppLocalizations.of(context)!.resetPasswordPageUserNotSignedUp);
      return;
    } else {
      showToast(
          AppLocalizations.of(context)!.resetPasswordPageSendVerifyCodeFailed);
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
}
