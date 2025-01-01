import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'empty_status.dart';

class ErrorStatusWidget extends StatelessWidget {
  final VoidCallback? onRetry;
  final double? width;
  final double? height;

  const ErrorStatusWidget({
    super.key, 
    this.onRetry,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyStatusWidget(
      emptyType: EmptyStatusType.fail,
      refreshTitle: '重新加载',
      width: width ?? 1.sw,
      height: height ?? 1.sh,
      onTap: onRetry,
    );
  }
} 