import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color_schemes.dart';
import 'app_colors.dart';
import 'app_theme.dart';

/// ThemeData 工厂类
/// 根据 AppTheme 枚举生成对应的完整 ThemeData
class ThemeDataFactory {
  ThemeDataFactory._();

  /// 获取主题对应的 ThemeData
  static ThemeData getThemeData(AppTheme theme) {
    return _buildThemeData(theme);
  }

  static ThemeData _buildThemeData(AppTheme theme) {
    final colors = _getColors(theme);
    final isDark = theme.isDark;

    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: colors.primary,
      scaffoldBackgroundColor: colors.background,
      extensions: [colors],
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: colors.primary,
        onPrimary: Colors.white,
        secondary: colors.secondary,
        onSecondary: Colors.white,
        error: colors.error,
        onError: Colors.white,
        surface: colors.surface,
        onSurface: colors.textPrimary,
      ),
      dividerColor: colors.divider,
      dividerTheme: DividerThemeData(
        color: colors.divider,
        thickness: 1,
        space: 1,
      ),
      iconTheme: IconThemeData(color: colors.icon, size: 24),
      textTheme: _buildTextTheme(colors),
      appBarTheme: _buildAppBarTheme(colors),
      cardTheme: _buildCardTheme(colors),
      elevatedButtonTheme: _buildElevatedButtonTheme(colors),
      outlinedButtonTheme: _buildOutlinedButtonTheme(colors),
      textButtonTheme: _buildTextButtonTheme(colors),
      inputDecorationTheme: _buildInputDecorationTheme(colors),
      bottomNavigationBarTheme: _buildBottomNavTheme(colors),
      dialogTheme: _buildDialogTheme(colors),
      listTileTheme: _buildListTileTheme(colors),
    );
  }

  static AppColors _getColors(AppTheme theme) {
    switch (theme) {
      case AppTheme.light:
        return AppColorSchemes.light;
      case AppTheme.dark:
        return AppColorSchemes.dark;
      case AppTheme.purple:
        return AppColorSchemes.purple;
      case AppTheme.blue:
        return AppColorSchemes.blue;
    }
  }

  static TextTheme _buildTextTheme(AppColors c) {
    return TextTheme(
      displayLarge: TextStyle(
          fontSize: 32.sp, fontWeight: FontWeight.bold, color: c.textPrimary),
      titleLarge: TextStyle(
          fontSize: 20.sp, fontWeight: FontWeight.w600, color: c.textPrimary),
      titleMedium: TextStyle(
          fontSize: 16.sp, fontWeight: FontWeight.w500, color: c.textPrimary),
      bodyLarge: TextStyle(fontSize: 16.sp, color: c.textPrimary),
      bodyMedium: TextStyle(fontSize: 14.sp, color: c.textPrimary),
      bodySmall: TextStyle(fontSize: 12.sp, color: c.textSecondary),
      labelLarge: TextStyle(
          fontSize: 14.sp, fontWeight: FontWeight.w500, color: c.textPrimary),
    );
  }

  static AppBarTheme _buildAppBarTheme(AppColors c) {
    return AppBarTheme(
      backgroundColor: c.surface,
      foregroundColor: c.textPrimary,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      centerTitle: true,
      iconTheme: IconThemeData(color: c.textPrimary),
      titleTextStyle: TextStyle(
        fontSize: 17.sp,
        fontWeight: FontWeight.w600,
        color: c.textPrimary,
      ),
    );
  }

  static CardThemeData _buildCardTheme(AppColors c) {
    return CardThemeData(
      color: c.card,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: c.border, width: 1),
      ),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme(AppColors c) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: c.primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: c.textDisabled,
        elevation: 0,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme(AppColors c) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: c.primary,
        side: BorderSide(color: c.primary),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }

  static TextButtonThemeData _buildTextButtonTheme(AppColors c) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: c.primary,
        textStyle: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      ),
    );
  }

  static InputDecorationTheme _buildInputDecorationTheme(AppColors c) {
    return InputDecorationTheme(
      filled: true,
      fillColor: c.surface,
      hintStyle: TextStyle(color: c.textTertiary, fontSize: 14.sp),
      labelStyle: TextStyle(color: c.textSecondary, fontSize: 14.sp),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: c.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: c.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: c.primary, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: c.error),
      ),
    );
  }

  static BottomNavigationBarThemeData _buildBottomNavTheme(AppColors c) {
    return BottomNavigationBarThemeData(
      backgroundColor: c.surface,
      selectedItemColor: c.primary,
      unselectedItemColor: c.icon,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    );
  }

  static DialogThemeData _buildDialogTheme(AppColors c) {
    return DialogThemeData(
      backgroundColor: c.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: c.textPrimary,
      ),
    );
  }

  static ListTileThemeData _buildListTileTheme(AppColors c) {
    return ListTileThemeData(
      iconColor: c.icon,
      textColor: c.textPrimary,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
    );
  }
}
