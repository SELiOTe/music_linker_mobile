import 'package:flutter/material.dart';
import 'package:mlm/util/typedef_utils.dart';

/// 含 Loading 的按钮
///
/// @author seliote
/// @version 2021-09-08

/// 含 Loading 的按钮
class LoadingButton extends StatefulWidget {
  final Widget childWidget;
  final Widget loadingWidget;
  final AsyncVoidCallback? callback;
  final VoidCallback? onLongPress;
  final ButtonStyle? style;
  final FocusNode? focusNode;
  final bool autofocus;
  final Clip clipBehavior;

  const LoadingButton(this.childWidget, this.loadingWidget, this.callback,
      {Key? key,
      this.onLongPress,
      this.style,
      this.focusNode,
      this.autofocus = false,
      this.clipBehavior = Clip.none})
      : super(key: key);

  @override
  _LoadingButtonState createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? widget.loadingWidget
        : TextButton(
            child: loading ? widget.loadingWidget : widget.childWidget,
            // 保留原始功能，为 null 时或 loading 时禁用按钮
            onPressed: loading
                ? () => null
                : (widget.callback == null
                    ? () => null
                    : () async {
                        // 执行前变换
                        setState(() {
                          loading = !loading;
                        });
                        await widget.callback!();
                        // 等待执行完成后再变换
                        setState(() {
                          loading = !loading;
                        });
                      }),
            onLongPress: widget.onLongPress,
            style: widget.style,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            clipBehavior: widget.clipBehavior);
  }
}
