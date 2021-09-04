import 'package:flutter/material.dart';
import 'package:mlm/page/auth/auth_page.dart';

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
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal,
    );
  }
}
