import 'package:flutter/material.dart';
import 'package:mlm/page/auth/auth_page.dart';
import 'package:mlm/util/sp_utils.dart';

/// 主页
///
/// @author seliote
/// @version 2021-08-07

const HOME_PAGE = "/home";

/// 主页
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          child: Text("Click Me"),
          onPressed: () async {
            var sp = await SpUtils.getInstance();
            sp.remove(SP_TOKEN);
            Navigator.pushNamedAndRemoveUntil(
                context, AUTH_PAGE, (route) => false);
            return;
          }),
    );
  }
}
