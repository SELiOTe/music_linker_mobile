import 'package:flutter/material.dart';
import 'package:mlm/page/auth/auth_page.dart';

/// 登录页
///
/// @author seliote
/// @version 2021-08-24

const LOGIN_PAGE = "/login";

class LoginPage extends StatefulWidget {
  final AuthInfo authInfo;

  const LoginPage(this.authInfo, {Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlue,
    );
  }
}
