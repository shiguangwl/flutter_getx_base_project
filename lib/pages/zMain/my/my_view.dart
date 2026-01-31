import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/base/config/view_config.dart';
import '../../../common/base/view/base_view.dart';
import '../../../common/utils/dialog/dialog_util.dart';
import '../../../config/theme/app_colors.dart';
import '../../../service/theme_service.dart';
import '../../../widgets/theme_toggle_button.dart';
import 'my_logic.dart';

class MyPage extends BaseView<MyLogic> {
  const MyPage({super.key});

  @override
  ViewConfig get viewConfig => ViewConfig(
        addHorizontalPadding: true,
        horizontalPadding: 12.w,
      );

  @override
  Widget buildScaffold(Widget contentView) {
    return Builder(builder: (context) {
      return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          titleTextStyle: TextStyle(
            fontSize: 16.sp,
            color: AppColors.of.textPrimary,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('我的'),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 12),
              child: ThemeToggleButton(size: 36),
            ),
          ],
        ),
        body: contentView,
      );
    });
  }

  @override
  Widget buildContent() {
    return Builder(builder: (context) {
      return Obx(() => Column(
            children: [
              SizedBox(height: 20.h),
              _buildUserInfo(context),
              SizedBox(height: 30.h),
              _buildMenu(context),
            ],
          ));
    });
  }

  Widget _buildUserInfo(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.of.card,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30.r,
            backgroundColor: AppColors.of.primary.withValues(alpha: 0.15),
            child: Icon(Icons.person, size: 40.r, color: AppColors.of.primary),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                logic.username.value,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.of.textPrimary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'ID: ${logic.userId.value}',
                style: TextStyle(
                    fontSize: 14.sp, color: AppColors.of.textSecondary),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.of.card,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          _buildThemeMenuItem(),
          Divider(height: 1, color: AppColors.of.divider),
          _buildMenuItem(Icons.logout, '退出登录', AppColors.of.primary, () {
            DialogUtil.showConfirmDialog(
              title: '退出登录',
              content: '确定要退出登录吗？',
              onConfirm: () => logic.logout(),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildThemeMenuItem() {
    return Obx(() {
      final themeService = ThemeService.to;
      return ListTile(
        leading: Icon(themeService.themeIcon, color: AppColors.of.primary),
        title: const Text('主题模式'),
        subtitle: Text(themeService.themeName),
        trailing: const ThemeToggleButton(size: 32),
        onTap: themeService.cycleTheme,
      );
    });
  }

  Widget _buildMenuItem(
    IconData icon,
    String title,
    Color iconColor,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
