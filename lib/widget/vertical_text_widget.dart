import 'package:flutter/material.dart';

/// 垂直文本组件
///
/// @author seliote
/// @version 2021-08-08

/// 垂直文本组件
class VerticalTextWidget extends StatelessWidget {
  // 组件内文本
  final String text;

  // 旋转角度
  final int quarterTurns;

  // 组件 padding
  final EdgeInsets padding;

  // 文本样式
  final TextStyle textStyle;

  /// 构造器
  ///
  /// param text 文本
  /// param key Widget Key，默认为空
  /// param quarterTurns 旋转角度，1 为顺时针 90 度，-1 为逆时针 90 度，默认为 -1
  /// param padding Widget padding，默认为 0
  /// param textStyle 文本 TextStyle，默认为无样式
  VerticalTextWidget(this.text,
      {Key? key, int? quarterTurns, EdgeInsets? padding, TextStyle? textStyle})
      : quarterTurns = quarterTurns == null ? -1 : quarterTurns,
        padding = padding == null ? EdgeInsets.zero : padding,
        textStyle = textStyle == null ? TextStyle() : textStyle,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: RotatedBox(
        quarterTurns: quarterTurns,
        child: Text(text, style: textStyle),
      ),
    );
  }
}
