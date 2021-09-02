import 'package:flutter/material.dart';

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
    return Container(color: Colors.amber);
  }
}
