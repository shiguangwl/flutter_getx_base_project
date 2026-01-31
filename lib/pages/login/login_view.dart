import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/base/config/view_config.dart';
import '../../../common/base/view/base_view.dart';
import '../../config/theme/app_colors.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input_field.dart';
import 'login_logic.dart';

class LoginPage extends BaseView<LoginLogic> {
  const LoginPage({super.key});

  @override
  ViewConfig get viewConfig => ViewConfig(
        addHorizontalPadding: true,
        horizontalPadding: 12.w,
      );

  @override
  Widget buildContent() {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLogo(),
                _buildUsernameField(),
                SizedBox(height: 10.h),
                _buildPasswordField(),
                SizedBox(height: 20.h),
                _buildLoginButton(),
                SizedBox(height: 20.h),
                _buildTermsCheckbox(context),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/logo.png'),
            ),
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  Widget _buildUsernameField() {
    return CustomInputField(
      controller: logic.usernameController,
      focusNode: logic.usernameFocusNode,
      hintText: '请输入用户名',
      onChanged: logic.updateUsername,
      onClear: logic.clearUsername,
    );
  }

  Widget _buildPasswordField() {
    return CustomInputField(
      controller: logic.passwordController,
      focusNode: logic.passwordFocusNode,
      hintText: '请输入密码',
      isPassword: true,
      showClearButton: false,
    );
  }

  Widget _buildLoginButton() {
    return Obx(
      () => CustomButton(
        onPressed: logic.performLogin,
        text: '登录',
        isLoading: logic.isLoading.value,
      ),
    );
  }

  Widget _buildTermsCheckbox(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: logic.toggleTermsAgreement,
            child: Container(
              width: 18.w,
              height: 18.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: logic.agreeToTerms.value
                      ? AppColors.of.primary
                      : AppColors.of.textSecondary,
                  width: 2,
                ),
                color: logic.agreeToTerms.value
                    ? AppColors.of.primary
                    : Colors.transparent,
              ),
              child: logic.agreeToTerms.value
                  ? Icon(Icons.check, color: Colors.white, size: 12.w)
                  : null,
            ),
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: RichText(
              text: TextSpan(
                text: '已阅读并同意 ',
                style: TextStyle(
                    color: AppColors.of.textSecondary, fontSize: 12.sp),
                children: [
                  TextSpan(
                    text: '《服务条款》',
                    style:
                        TextStyle(color: AppColors.of.primary, fontSize: 12.sp),
                  ),
                  TextSpan(
                    text: ' 和 ',
                    style: TextStyle(
                        color: AppColors.of.textSecondary, fontSize: 12.sp),
                  ),
                  TextSpan(
                    text: '《隐私政策》',
                    style:
                        TextStyle(color: AppColors.of.primary, fontSize: 12.sp),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
