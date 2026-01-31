import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/base/controller/base_controller.dart';
import '../../common/base/state/page_constant.dart';
import '../../common/utils/toast_util.dart';
import '../../service/persistent_service.dart';
import '../../routes/router.dart';
import '../../service/api_service/user_service.dart';

class LoginLogic extends BaseController {
  static LoginLogic get to => Get.find<LoginLogic>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  final usernameFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final RxString username = ''.obs;
  final RxBool obscurePassword = true.obs;
  final RxBool agreeToTerms = false.obs;
  final RxBool isLoading = false.obs;

  PersistentService get _persistent => PersistentService.to;

  @override
  void onInit() {
    super.onInit();
    agreeToTerms.value = _persistent.config.getAgreeTerms();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    usernameFocusNode.dispose();
    passwordFocusNode.dispose();
    super.onClose();
  }

  /// 切换密码显示状态
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  /// 清除用户名
  void clearUsername() {
    usernameController.clear();
    username.value = '';
  }

  /// 更新用户名
  void updateUsername(String value) {
    username.value = value;
  }

  /// 切换服务条款同意状态
  void toggleTermsAgreement() {
    agreeToTerms.value = !agreeToTerms.value;
    _persistent.config.setAgreeTerms(agreeToTerms.value);
  }

  /// 执行登录
  Future<void> performLogin() async {
    // 验证输入
    if (usernameController.text.trim().isEmpty) {
      ToastUtil.showError('请输入用户名');
      return;
    }

    if (passwordController.text.isEmpty) {
      ToastUtil.showError('请输入密码');
      return;
    }

    if (!agreeToTerms.value) {
      ToastUtil.showError('请同意服务条款和隐私政策');
      return;
    }

    try {
      isLoading.value = true;

      // 模拟登录延迟
      await Future.delayed(const Duration(seconds: 1));

      // 更新登录状态
      await UserService.to.login(
        username: usernameController.text.trim(),
        password: passwordController.text,
      );

      // 跳转到主页
      Get.offAllNamed(AppRoutes.Home);
      ToastUtil.showSuccess('登录成功');
    } finally {
      isLoading.value = false;
    }
  }

  /// 忘记密码
  void forgotPassword() {
    // Get.snackbar('提示', '忘记密码功能暂未开放');
  }

  @override
  Future<PageResult> onLoadPage() async {
    return const PageSuccess();
  }
}
