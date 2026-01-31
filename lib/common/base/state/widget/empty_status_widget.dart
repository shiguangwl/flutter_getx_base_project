import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum EmptyStatusType {
  fail, // 请求失败，网络异常
  noMessage, // 无数据
}

class EmptyStatusWidget extends StatefulWidget {
  final String? message;
  final String? refreshTitle;
  final Color? bgColor;
  final Function()? onTap;
  final double? paddingTop;
  final double? width;
  final double? height;
  final Widget? customIcon;
  final TextStyle? messageStyle;
  final TextStyle? buttonStyle;

  const EmptyStatusWidget({
    super.key,
    this.message,
    this.refreshTitle,
    this.bgColor,
    this.onTap,
    this.paddingTop,
    this.width,
    this.height,
    this.customIcon,
    this.messageStyle,
    this.buttonStyle,
  });

  @override
  State<EmptyStatusWidget> createState() => _EmptyStatusWidgetState();
}

class _EmptyStatusWidgetState extends State<EmptyStatusWidget> {
  /// 标题
  Widget _title() {
    final defaultStyle = TextStyle(
      fontSize: 14.sp,
      color: const Color(0xFF999999),
    );
    final style = widget.messageStyle ?? defaultStyle;
    return Text(_getTitleString(), style: style);
  }

  String _getTitleString() {
    if (widget.message != null) {
      return widget.message!;
    }
    {
      return '暂无数据';
    }
  }

  /// 图片
  Widget _image() {
    if (widget.customIcon != null) {
      return widget.customIcon!;
    }

    return SizedBox(
      width: 160.w,
      height: 160.w,
      child: _getImageWidget(),
    );
  }

  /// 获取图片名称
  Widget _getImageWidget() {
    return _buildDefaultIcon(Icons.inbox_outlined, Colors.grey[400]);
  }

  /// 构建默认图标
  Widget _buildDefaultIcon(IconData icon, Color? color) {
    return Icon(
      icon,
      size: 80.w,
      color: color,
    );
  }

  /// 刷新按钮
  Widget _refreshButton() {
    if (widget.refreshTitle != null && widget.refreshTitle!.isNotEmpty) {
      final defaultStyle =
          TextStyle(fontSize: 16.sp, color: const Color(0xFFFFFFFF));
      final style = widget.buttonStyle ?? defaultStyle;

      final decoration = BoxDecoration(
        color: const Color(0xFF102FA5),
        borderRadius: BorderRadius.circular(19.r),
      );

      return GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: 96.w,
          height: 38.h,
          decoration: decoration,
          margin: EdgeInsets.only(top: 18.h),
          alignment: Alignment.center,
          child: Text(widget.refreshTitle!, style: style),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.width,
        height: widget.height,
        color: widget.bgColor,
        padding: widget.paddingTop != null
            ? EdgeInsets.only(top: widget.paddingTop!)
            : null,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _image(),
              SizedBox(height: 16.h),
              _title(),
              _refreshButton(),
            ],
          ),
        ),
      ),
    );
  }
}
