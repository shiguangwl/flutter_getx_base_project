import 'package:flutter/material.dart';
import 'package:flutter_getx_base_project/R.dart';
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
  final EmptyStatusType emptyType;
  final double? paddingTop;
  final double? width;
  final double? height;

  const EmptyStatusWidget({
    super.key,
    this.message,
    this.refreshTitle,
    this.bgColor,
    this.onTap,
    this.paddingTop,
    required this.emptyType,
    this.width,
    this.height,
  });

  @override
  State<EmptyStatusWidget> createState() => _EmptyStatusWidgetState();
}

class _EmptyStatusWidgetState extends State<EmptyStatusWidget> {

  /// 标题
  Widget _title() {
    TextStyle style =
        TextStyle(fontSize: 14.sp, color: const Color(0xFF999999));
    return Text(_getTitleString(), style: style);
  }

  String _getTitleString() {
    if (widget.message != null) {
      return widget.message!;
    } else if (widget.emptyType == EmptyStatusType.fail) {
      return '网络异常，请重新加载';
    } else {
      return '暂无数据';
    }
  }

  /// 图片
  Widget _image() {
    return SizedBox(
      width: 160.w,
      height: 160.w,
      child: _getImageWidget(),
    );
  }

  /// 获取图片名称
  Widget _getImageWidget() {
    if (widget.emptyType == EmptyStatusType.fail) {
      return Image.asset(R.ImageFail);
    } else {
      return Image.asset(R.ImageEmpty);
    }
  }

  /// 刷新按钮
  Widget _refreshButton() {
    if (widget.refreshTitle != null && widget.refreshTitle!.isNotEmpty) {
      TextStyle style =
          TextStyle(fontSize: 16.sp, color: const Color(0xFFFFFFFF));
      Decoration decoration = BoxDecoration(
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
      onTap: () => widget.onTap,
      child: Container(
        width: widget.width ?? MediaQuery.of(context).size.width,
        height: widget.height ?? MediaQuery.of(context).size.height,
        color: widget.bgColor ?? Colors.white,
        padding: EdgeInsets.only(top: widget.paddingTop ?? 140.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _image(),
            _title(),
            _refreshButton(),
          ],
        ),
      ),
    );
  }
}
