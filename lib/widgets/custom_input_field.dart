import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../config/theme/app_colors.dart';

/// 自定义输入框组件
class CustomInputField extends StatefulWidget {
  /// 输入控制器
  final TextEditingController? controller;

  /// 焦点节点
  final FocusNode? focusNode;

  /// 提示文本
  final String? hintText;

  /// 是否密码输入框
  final bool isPassword;

  /// 输入值变化回调
  final ValueChanged<String>? onChanged;

  /// 是否显示清除按钮
  final bool showClearButton;

  /// 清除按钮点击回调
  final VoidCallback? onClear;

  /// 自定义后缀图标
  final Widget? suffixIcon;

  /// 输入框样式
  final TextStyle? textStyle;

  /// 提示文本样式
  final TextStyle? hintStyle;

  const CustomInputField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.isPassword = false,
    this.onChanged,
    this.showClearButton = true,
    this.onClear,
    this.suffixIcon,
    this.textStyle,
    this.hintStyle,
  });

  @override
  State<CustomInputField> createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _obscureText = true;
  bool _showClearIcon = false;

  @override
  void initState() {
    super.initState();

    // 监听输入框内容变化，控制清除按钮显示
    widget.controller?.addListener(_onTextChanged);

    // 如果是密码输入框，默认隐藏文本
    if (widget.isPassword) {
      _obscureText = true;
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onTextChanged);
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = widget.controller?.text.isNotEmpty ?? false;
    if (_showClearIcon != hasText) {
      setState(() {
        _showClearIcon = hasText;
      });
    }
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _clearText() {
    widget.controller?.clear();
    widget.onClear?.call();
    widget.onChanged?.call('');
  }

  Widget? _buildSuffixIcon() {
    if (widget.suffixIcon != null) {
      return widget.suffixIcon;
    }

    if (widget.isPassword) {
      return GestureDetector(
        onTap: _togglePasswordVisibility,
        child: Icon(
          _obscureText ? Icons.visibility_off : Icons.visibility,
          color: AppColors.of.primary,
          size: 20.w,
        ),
      );
    }

    if (widget.showClearButton && _showClearIcon) {
      return GestureDetector(
        onTap: _clearText,
        child: Icon(
          Icons.clear,
          color: AppColors.of.icon,
          size: 20.w,
        ),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        obscureText: widget.isPassword ? _obscureText : false,
        onChanged: widget.onChanged,
        style: widget.textStyle ??
            TextStyle(
              fontSize: 14.sp,
              color: AppColors.of.textPrimary,
            ),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: widget.hintStyle ??
              TextStyle(
                color: AppColors.of.textTertiary,
                fontSize: 16.sp,
              ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.of.border, width: 1.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.of.border, width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.of.primary, width: 2.0),
          ),
          suffixIcon: _buildSuffixIcon(),
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        ),
      ),
    );
  }
}
