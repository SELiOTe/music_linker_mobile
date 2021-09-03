import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mlm/main.dart';
import 'package:mlm/model/api/auth/country_list.dart';
import 'package:mlm/model/api/auth/is_signed_up.dart';
import 'package:mlm/page/auth/country_list_page.dart';
import 'package:mlm/page/auth/login_page.dart';
import 'package:mlm/page/auth/sign_up_page.dart';
import 'package:mlm/util/hardware_util.dart';
import 'package:mlm/util/http_utils.dart';
import 'package:mlm/util/ui_utils.dart';
import 'package:mlm/widget/captcha_dialog.dart';
import 'package:mlm/widget/vertical_text_widget.dart';

/// 授权页面
///
/// @author seliote
/// @version 2021-08-07

const AUTH_PAGE = "/auth";

/// 认证与授权页
class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // 设备 ID，用于判断当前是否为信任设备
  String _deviceId = "";

  // 所有可用国家及当前选择
  List<CountryListResp> _countryList = <CountryListResp>[];
  CountryListResp? _selectCountry;
  String? _telNo;

  @override
  void initState() {
    super.initState();
    // 获取设备 ID
    deviceId().then((value) => _deviceId = value);
    _reqCountryAndAutoMatch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // 背景渐变
        decoration: getGradientBackgroundDecoration(),
        // ListView 防止 OverFlow
        child: ListView(children: [
          Column(
            children: <Widget>[
              // 头部
              Row(
                children: <Widget>[
                  _getHeaderVerticalTextWidget(
                      AppLocalizations.of(context)!.authPageTitle),
                  _getHeaderHorizontalTextWidget(
                      AppLocalizations.of(context)!.authPageDesc),
                ],
              ),
              // 手机号码
              _getMobileNumberWidget(),
              // 下一步
              getNextButton(_nextButtonOnPressed),
              SizedBox(height: 36)
            ],
          ),
        ]),
      ),
    );
  }

  /// 获取头部垂直文本
  ///
  /// return 垂直文本 Widget
  VerticalTextWidget _getHeaderVerticalTextWidget(String text) {
    return VerticalTextWidget(
      text,
      padding: EdgeInsets.only(top: 64, left: 32),
      textStyle: TextStyle(
          fontSize: 38, color: Colors.white, fontWeight: FontWeight.w900),
    );
  }

  /// 获取头部文本
  ///
  /// return 头部文本 Widget
  Widget _getHeaderHorizontalTextWidget(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(height: 64),
            Row(
              children: [
                SizedBox(width: 32),
                Text(
                  text,
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 获取国家码 Widget
  ///
  /// return 国家码 Widget
  Widget _getCountryCodeWidget() {
    return GestureDetector(
        onTap: () async {
          var userSelect = await Navigator.pushNamed(context, COUNTRY_LIST_PAGE,
              arguments: _countryList);
          if (userSelect != null && userSelect is CountryListResp) {
            setState(() => _selectCountry = userSelect);
          }
        },
        child: Text(
          _selectCountry == null
              ? AppLocalizations.of(context)!.authPageCountryUnselect
              : "+${_selectCountry!.phoneCode}",
          style: TextStyle(color: Colors.white),
        ));
  }

  /// 获取手机号码输入 Widget
  ///
  /// return 手机号码输入 Widget
  Widget _getMobileNumberWidget() {
    return Padding(
        padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
        child: TextField(
          cursorColor: Colors.white70,
          keyboardType: TextInputType.phone,
          textAlign: TextAlign.start,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: AppLocalizations.of(context)!.authPagePhone,
            hintStyle: TextStyle(color: Colors.white70),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.phone_android, color: Colors.white),
                  SizedBox(width: 8),
                  _getCountryCodeWidget(),
                  Icon(Icons.arrow_drop_down, color: Colors.white)
                ],
              ),
            ),
          ),
          onChanged: (value) => _telNo = value,
        ));
  }

  /// 请求并自动匹配当前国家
  Future<void> _reqCountryAndAutoMatch() async {
    // 国家码
    var resp = await HttpUtils.post4Array("/auth/country_list", timeout: 10000);
    if (resp == null || resp.code != 0) {
      return;
    }
    _countryList = CountryListResp.fromJsonArray(resp.data);
    if (_countryList.isEmpty) {
      return;
    }
    _countryList.sort((c1, c2) => c1.localName.compareTo(c2.localName));
    _selectCountry = _countryList.first;
    var countryCode = WidgetsBinding.instance?.window.locale.countryCode;
    if (countryCode == null || countryCode.isEmpty) {
      return;
    }
    _countryList.forEach((element) {
      if (countryCode.toUpperCase() == element.countryCode.toUpperCase()) {
        _selectCountry = element;
        return;
      }
    });
    setState(() {});
  }

  /// 下一步按钮点击事件
  void _nextButtonOnPressed() async {
    if (_selectCountry == null || _selectCountry!.phonePattern.isEmpty) {
      showToast(AppLocalizations.of(context)!.authPageCountryUnselect);
      return;
    }
    var regex = RegExp(_selectCountry!.phonePattern);
    if (_telNo == null || _telNo!.isEmpty || !regex.hasMatch(_telNo!)) {
      showToast(AppLocalizations.of(context)!.authPagePhonePatternNotMatch);
      return;
    }
    // 调用接口判断是要登录还是注册
    var req = IsSignedUpReq(_selectCountry!.phoneCode, _telNo!);
    var resp = await HttpUtils.post4Object("/auth/is_signed_up", reqBody: req);
    if (resp == null) {
      return;
    }
    // 认证与授权信息
    var authInfo = AuthInfo(
        _deviceId.isEmpty ? DateTime.now().microsecond.toString() : _deviceId,
        _selectCountry!.phoneCode,
        _telNo!);
    if (resp.code == 0) {
      // 进登录
      debugPrint("Login");
      Navigator.pushNamedAndRemoveUntil(context, LOGIN_PAGE, (_) => false,
          arguments: authInfo);
    } else {
      // 进注册
      debugPrint("Sign up");
      Navigator.pushNamedAndRemoveUntil(context, SIGN_UP_PAGE, (_) => false,
          arguments: authInfo);
    }
  }
}

/// 获取渐变背景
///
/// return 渐变背景
BoxDecoration getGradientBackgroundDecoration() {
  return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [Colors.blueGrey, Colors.lightBlueAccent]));
}

/// 获取验证码弹窗
Future<CaptchaDialogResult?> getCaptchaAndSendVerifyCode(
    BuildContext context) async {
  return await showDialog<CaptchaDialogResult?>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      builder: (_) => StatefulBuilder(builder: (context, setState) {
            return WillPopScope(
                onWillPop: () async => true, child: CaptchaDialog());
          }));
}

/// 获取下一步按钮
///
/// return 下一步按钮 Widget
Widget getNextButton(VoidCallback callback) {
  return Padding(
    padding: const EdgeInsets.only(top: 32, right: 16),
    // 使按钮右对齐
    child: Row(
      children: [
        Expanded(
          child: Container(),
          flex: 1,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30)),
          alignment: Alignment.bottomRight,
          height: 36,
          child: TextButton(
            onPressed: callback,
            child: Row(
              children: <Widget>[
                Text(
                  AppLocalizations.of(globalKey.currentState!.context)!
                      .nextStep,
                  style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

/// 认证与授权
class AuthInfo {
  // 设备 ID
  String deviceId;

  // 国际电话区号
  String phoneCode;

  // 手机号码
  String telNo;

  AuthInfo(this.deviceId, this.phoneCode, this.telNo);
}
