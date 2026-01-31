import 'package:flutter/material.dart';

import 'app_colors.dart';

/// 预定义配色方案集合
class AppColorSchemes {
  AppColorSchemes._();

  // 共享功能色（所有主题通用）
  static const _success = Color(0xFF10B981);
  static const _warning = Color(0xFFF59E0B);
  static const _error = Color(0xFFEF4444);

  /// 浅色主题配色
  static const light = AppColors(
    primary: Color(0xFF6936FF),
    onPrimary: Color(0xFFFFFFFF),
    primaryLight: Color(0xFF8B5CF6),
    primaryDark: Color(0xFF5429CC),
    secondary: Color(0xFF3B82F6),
    background: Color(0xFFF8FAFC),
    surface: Color(0xFFFFFFFF),
    card: Color(0xFFFFFFFF),
    overlay: Color(0x80000000),
    inputFill: Color(0xFFF1F5F9),
    textPrimary: Color(0xFF0F172A),
    textSecondary: Color(0xFF64748B),
    textTertiary: Color(0xFF94A3B8),
    textDisabled: Color(0xFFCBD5E1),
    border: Color(0xFFE2E8F0),
    divider: Color(0xFFF1F5F9),
    icon: Color(0xFF64748B),
    iconActive: Color(0xFF6936FF),
    success: _success,
    warning: _warning,
    error: _error,
    info: Color(0xFF3B82F6),
  );

  /// 深色主题配色
  static const dark = AppColors(
    primary: Color(0xFF8B5CF6),
    onPrimary: Color(0xFFFFFFFF),
    primaryLight: Color(0xFFA78BFA),
    primaryDark: Color(0xFF7C3AED),
    secondary: Color(0xFF60A5FA),
    background: Color(0xFF0F172A),
    surface: Color(0xFF1E293B),
    card: Color(0xFF1E293B),
    overlay: Color(0xB3000000),
    inputFill: Color(0xFF334155),
    textPrimary: Color(0xFFF8FAFC),
    textSecondary: Color(0xFF94A3B8),
    textTertiary: Color(0xFF64748B),
    textDisabled: Color(0xFF475569),
    border: Color(0xFF334155),
    divider: Color(0xFF1E293B),
    icon: Color(0xFF94A3B8),
    iconActive: Color(0xFF8B5CF6),
    success: _success,
    warning: _warning,
    error: _error,
    info: Color(0xFF60A5FA),
  );

  /// 紫色主题配色（亮底）
  static const purple = AppColors(
    primary: Color(0xFF7C3AED),
    onPrimary: Color(0xFFFFFFFF),
    primaryLight: Color(0xFF8B5CF6),
    primaryDark: Color(0xFF6D28D9),
    secondary: Color(0xFFEC4899),
    background: Color(0xFFFAF5FF),
    surface: Color(0xFFFFFFFF),
    card: Color(0xFFFFFFFF),
    overlay: Color(0x80000000),
    inputFill: Color(0xFFF3E8FF),
    textPrimary: Color(0xFF1E1B4B),
    textSecondary: Color(0xFF6B7280),
    textTertiary: Color(0xFF9CA3AF),
    textDisabled: Color(0xFFD1D5DB),
    border: Color(0xFFE9D5FF),
    divider: Color(0xFFF3E8FF),
    icon: Color(0xFF7C3AED),
    iconActive: Color(0xFF7C3AED),
    success: _success,
    warning: _warning,
    error: _error,
    info: Color(0xFF8B5CF6),
  );

  /// 蓝色主题配色（亮底）
  static const blue = AppColors(
    primary: Color(0xFF2563EB),
    onPrimary: Color(0xFFFFFFFF),
    primaryLight: Color(0xFF3B82F6),
    primaryDark: Color(0xFF1D4ED8),
    secondary: Color(0xFF06B6D4),
    background: Color(0xFFF0F9FF),
    surface: Color(0xFFFFFFFF),
    card: Color(0xFFFFFFFF),
    overlay: Color(0x80000000),
    inputFill: Color(0xFFE0F2FE),
    textPrimary: Color(0xFF0C4A6E),
    textSecondary: Color(0xFF64748B),
    textTertiary: Color(0xFF94A3B8),
    textDisabled: Color(0xFFCBD5E1),
    border: Color(0xFFBAE6FD),
    divider: Color(0xFFE0F2FE),
    icon: Color(0xFF0284C7),
    iconActive: Color(0xFF2563EB),
    success: _success,
    warning: _warning,
    error: _error,
    info: Color(0xFF0EA5E9),
  );
}
