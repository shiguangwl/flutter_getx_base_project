import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// 任务状态按钮组件
/// 根据不同的任务状态显示不同的按钮样式
class StatusButton extends StatelessWidget {
  const StatusButton({
    super.key,
    required this.status,
    this.onPressed,
    this.height,
    this.width,
    this.borderRadius,
    this.fontSize,
  });

  final TaskStatus status;
  final VoidCallback? onPressed;
  final double? height;
  final double? width;
  final double? borderRadius;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final config = _getStatusConfig(status);

    return Container(
      width: width ?? double.infinity,
      height: height ?? 42.h,
      decoration: BoxDecoration(
        color: config.backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius ?? 25.r),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          disabledBackgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 25.r),
          ),
        ),
        child: Text(
          config.text,
          style: TextStyle(
            color: config.textColor,
            fontSize: fontSize ?? 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  /// 根据状态获取配置
  StatusButtonConfig _getStatusConfig(TaskStatus status) {
    switch (status) {
      case TaskStatus.cancelled:
        return StatusButtonConfig(
          text: '已取消',
          backgroundColor: Color(0xFFCCCCCC),
          textColor: Color(0xFFFFFFFF),
        );
      case TaskStatus.failed:
        return StatusButtonConfig(
          text: '失败',
          backgroundColor: Color(0xFFFF3636),
          textColor: Color(0xFFFFFFFF),
        );
      case TaskStatus.cancelTask:
        return StatusButtonConfig(
          text: '取消任务',
          backgroundColor: Color(0xFF6936FF),
          textColor: Color(0xFFFFFFFF),
        );
      case TaskStatus.inProgressDisabled:
        return StatusButtonConfig(
          text: '订单进行中，无法取消',
          backgroundColor: Color(0xFFCCCCCC),
          textColor: Color(0xFF6D6D6D),
        );
      case TaskStatus.completedDisabled:
        return StatusButtonConfig(
          text: '订单已完成',
          backgroundColor: Color(0xFFCCCCCC),
          textColor: Color(0xFF6D6D6D),
        );
    }
  }
}

/// 任务状态枚举
enum TaskStatus {
  cancelled, // 已取消
  failed, // 失败
  cancelTask, // 取消任务（可点击）
  inProgressDisabled, // 订单进行中，无法取消（禁用）
  completedDisabled, // 订单已完成（禁用）
}

/// 状态按钮配置
class StatusButtonConfig {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  StatusButtonConfig({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });
}
