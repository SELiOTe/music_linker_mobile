import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mlm/model/api/auth/sign_up.dart';
import 'package:mlm/model/api/auth/sign_up_sms.dart';
import 'package:mlm/page/auth/auth_page.dart';
import 'package:mlm/page/home_page.dart';
import 'package:mlm/util/const_utils.dart';
import 'package:mlm/util/http_utils.dart';
import 'package:mlm/util/sp_utils.dart';
import 'package:mlm/util/ui_utils.dart';

/// 注册页
///
/// @author seliote
/// @version 2021-08-24

const SIGN_UP_PAGE = "/auth/sign_up";

class SignUpPage extends StatefulWidget {
  final AuthInfo authInfo;

  const SignUpPage(this.authInfo, {Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // 密码及验证码
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
                // 标题
                getTitle(AppLocalizations.of(context)!.signUpPageTitle),
                // 密码
                getPasswordWidget(false, (value) => _password = value),
                // 验证码框
                getVerifyCodeWidget(context, (value) => _verifyCode = value,
                    _countDown, _getVerifyCode),
                SizedBox(height: 32),
                // 下一步
                getNextButton(_nextStepOnPressed),
                SizedBox(height: 32)
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
    var req = SignUpSmsReq(result.uuid!, result.captcha!,
        widget.authInfo.phoneCode, widget.authInfo.telNo);
    var resp = await HttpUtils.post4Object("/auth/sign_up_sms", reqBody: req);
    if (resp == null) {
      return;
    }
    if (resp.code == 0) {
      // 成功，验证码按钮倒数
      _startTimer();
      showToast(AppLocalizations.of(context)!.signUpPageSendVerifyCodeSuccess);
      return;
    } else if (resp.code == 1) {
      // 验证码不正确
      showToast(AppLocalizations.of(context)!.captchaDialogCaptchaIncorrect);
      _getVerifyCode();
      return;
    } else if (resp.code == 2) {
      // 验证码不正确
      showToast(AppLocalizations.of(context)!.signUpPageUserHadSignedUp);
      return;
    } else {
      showToast(AppLocalizations.of(context)!.signUpPageSendVerifyCodeFailed);
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

  /// 获取下一步
  void _nextStepOnPressed() async {
    if (!RegExp(PASSWORD_REGEX).hasMatch(_password)) {
      showToast(AppLocalizations.of(context)!.signUpPagePasswordTooSimple);
      return;
    }
    if (!RegExp(VERIFY_CODE_REGEX).hasMatch(_verifyCode)) {
      showToast(AppLocalizations.of(context)!.signUpPageVerifyCodeIncorrect);
      return;
    }
    var req = SignUpReq(widget.authInfo.phoneCode, widget.authInfo.telNo,
        _password, _verifyCode, widget.authInfo.deviceNo);
    var resp = await HttpUtils.post4Object("/auth/sign_up", reqBody: req);
    if (resp == null) {
      return;
    }
    if (resp.code == 0) {
      var respModel = SignUpResp.fromJson(resp.data!);
      HttpUtils.token = respModel.token;
      var sp = await SpUtils.getInstance();
      sp.setString(SP_TOKEN, respModel.token);
      Navigator.pushNamedAndRemoveUntil(context, HOME_PAGE, (route) => false);
      return;
    }
    if (resp.code == 1) {
      // 短信验证码不正确
      showToast(AppLocalizations.of(context)!.signUpPageVerifyCodeIncorrect);
      return;
    }
    if (resp.code == 3 || resp.code == 4) {
      // 添加受信任设备失败或获取登录 Token 失败
      showToast(AppLocalizations.of(context)!.signUpPageGetTokenFailed);
      Navigator.pushNamedAndRemoveUntil(context, AUTH_PAGE, (route) => false);
      return;
    }
    if (resp.code == 2) {
      // 注册失败
      showToast(AppLocalizations.of(context)!.signUpPageSignUpFailed);
      return;
    }
    // 其他的都视为注册失败
    showToast(AppLocalizations.of(context)!.serverError);
    return;
  }
}
