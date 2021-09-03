import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mlm/model/api/auth/captcha.dart';
import 'package:mlm/util/http_utils.dart';
import 'package:mlm/util/ui_utils.dart';

/// 验证码弹窗
///
/// @author seliote
/// @version 2021-08-31

// 验证码弹窗下一步回调，为 true 则为执行成功，为 false 则验证码校验失败，刷新验证码
typedef CaptchaDialogAction = Future<bool> Function();

/// 验证码弹窗
class CaptchaDialog extends StatefulWidget {
  const CaptchaDialog({Key? key}) : super(key: key);

  @override
  _CaptchaDialogState createState() => _CaptchaDialogState();
}

class _CaptchaDialogState extends State<CaptchaDialog> {
  CaptchaResp? _captchaResp;
  String? _captcha;

  @override
  void initState() {
    super.initState();
    _refreshCaptcha();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    // 这玩意有个最大宽度，要用 UnconstrainedBox 移除限制
    return AlertDialog(
      // 否则外框会 Overflow
      contentPadding: const EdgeInsets.all(0),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      content: UnconstrainedBox(
          child: Container(
              color: Colors.white,
              width: 2 * screenWidth / 3,
              child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: <Widget>[
                          _getTitle(),
                          SizedBox(height: 16),
                          _getCaptchaImage(screenWidth),
                          GestureDetector(
                            child: Column(
                              children: <Widget>[
                                _getRefreshButton(),
                                _getCaptchaInputWidget(screenWidth),
                              ],
                            ),
                            onTap: _refreshCaptcha,
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: <Widget>[
                              Expanded(child: Container()),
                              _getCancelButton(),
                              _getNextStepButton()
                            ],
                          )
                        ],
                      ))))),
    );
  }

  /// 获取标题
  Widget _getTitle() {
    return Text(
      AppLocalizations.of(context)!.captchaDialogTitle,
      style: TextStyle(
          color: Colors.black87, fontSize: 23, fontWeight: FontWeight.w600),
    );
  }

  /// 获取验证码图片组件
  ///
  /// param screenWidth 屏幕宽度
  Widget _getCaptchaImage(double screenWidth) {
    return _captchaResp == null
        ? Container()
        : Image.memory(Base64Decoder().convert(_captchaResp!.captchaImg),
            width: screenWidth / 2, fit: BoxFit.cover);
  }

  /// 获取刷新验证码组件
  Widget _getRefreshButton() {
    return TextButton(
        onPressed: () => null,
        child: Text(AppLocalizations.of(context)!.captchaDialogClickRefresh));
  }

  /// 获取验证码输入组件
  Widget _getCaptchaInputWidget(double screenWidth) {
    return Container(
      width: screenWidth / 3,
      child: TextField(
        keyboardType: TextInputType.text,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.black),
        maxLines: 1,
        decoration: InputDecoration(
          hintText: AppLocalizations.of(context)!.captchaDialogCaptchaHint,
          hintStyle: TextStyle(color: Colors.black38),
        ),
        onChanged: (value) => _captcha = value,
      ),
    );
  }

  /// 获取取消按钮
  Widget _getCancelButton() {
    return TextButton(
        child: Text(
          AppLocalizations.of(context)!.cancel,
          style: TextStyle(color: Colors.blue),
        ),
        onPressed: () => Navigator.pop(context, null));
  }

  /// 获取下一步按钮
  Widget _getNextStepButton() {
    return TextButton(
        child: Text(
          AppLocalizations.of(context)!.nextStep,
          style: TextStyle(color: Colors.blue),
        ),
        onPressed: () {
          if (_captchaResp?.uuid == null ||
              _captcha == null ||
              _captcha!.length != 4) {
            showToast(
                AppLocalizations.of(context)!.captchaDialogCaptchaIncorrect);
            return;
          }
          Navigator.pop(
              context, CaptchaDialogResult(_captchaResp?.uuid, _captcha));
        });
  }

  /// 请求图形验证码
  ///
  /// param context BuildContext 上下文
  void _refreshCaptcha() async {
    var resp = await HttpUtils.post4Object("/auth/captcha");
    if (resp == null || resp.code != 0 || resp.data == null) {
      showToast(AppLocalizations.of(context)!.signUpPageFailedGetCaptcha);
      return;
    }
    var data = CaptchaResp.fromJson(resp.data!);
    setState(() => _captchaResp = data);
  }
}

/// 图形验证码弹窗
class CaptchaDialogResult {
  // 图形验证码 UUID
  String? uuid;

  // 图形验证码文本
  String? captcha;

  CaptchaDialogResult(this.uuid, this.captcha);
}
