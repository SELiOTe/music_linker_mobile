import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

/// UI 相关工具
///
/// @author seliote
/// @version 2021-08-10

/// 显示 Toast
///
/// param msg 要显示的信息
/// param clearOld 是否请求之前还未显示完的 Toast
void showToast(String msg, {bool clearOld = true}) {
  if (clearOld) {
    Fluttertoast.cancel().then((value) => _showToast(msg));
  } else {
    _showToast(msg);
  }
}

/// 显示 Toast
///
/// param msg 要显示的信息
/// param clearOld 是否请求之前还未显示完的 Toast
void _showToast(String msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: Colors.blueGrey,
      textColor: Colors.white,
      fontSize: 16);
}
