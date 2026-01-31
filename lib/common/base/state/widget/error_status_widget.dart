import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'empty_status_widget.dart';

class ErrorStatusWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final double? width;
  final double? height;
  final String? errorMessage;
  final Widget? customIcon;
  final TextStyle? messageStyle;
  final TextStyle? buttonStyle;
  final Color? backgroundColor;

  const ErrorStatusWidget({
    super.key,
    this.onRetry,
    this.width,
    this.height,
    this.errorMessage,
    this.customIcon,
    this.messageStyle,
    this.buttonStyle,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStatusWidget(
      message: errorMessage,
      refreshTitle: onRetry != null ? '重新加载' : null,
      width: width ?? 1.sw,
      height: height ?? 1.sh,
      onTap: onRetry,
      customIcon: customIcon,
      messageStyle: messageStyle,
      buttonStyle: buttonStyle,
      bgColor: backgroundColor,
    );
  }
}
