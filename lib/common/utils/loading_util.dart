import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'toast_util.dart';

/// Loading工具类
class LoadingUtil {
  const LoadingUtil._internal();

  static int _loadingCount = 0;
  static final _lock = Object();

  /// 显示Loading对话框
  static void showLoading({
    String message = '加载中...',
    bool barrierDismissible = false,
  }) {
    synchronized(_lock, () {
      _loadingCount++;
      if (_loadingCount == 1) {
        Get.dialog(
          PopScope(
            canPop: barrierDismissible,
            child: Material(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CircularProgressIndicator(),
                      if (message.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          message,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black87),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          barrierDismissible: barrierDismissible,
          barrierColor: Colors.black26,
        );
      }
    });
  }

  /// 隐藏Loading对话框
  static void hideLoading() {
    synchronized(_lock, () {
      if (_loadingCount > 0) {
        _loadingCount--;
        if (_loadingCount == 0 && Get.isDialogOpen == true) {
          Get.back();
        }
      }
    });
  }

  /// 强制隐藏所有Loading
  static void forceHideLoading() {
    synchronized(_lock, () {
      _loadingCount = 0;
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    });
  }

  /// 执行异步操作并显示Loading
  static Future<T> executeWithLoading<T>(
    Future<T> Function() action, {
    String loadingMessage = '加载中...',
    String? successMessage,
    String? errorMessage,
    bool barrierDismissible = false,
    bool showErrorToast = true,
    bool showSuccessToast = false,
  }) async {
    try {
      showLoading(
          message: loadingMessage, barrierDismissible: barrierDismissible);
      final T result = await action();
      hideLoading();

      if (showSuccessToast &&
          successMessage != null &&
          successMessage.isNotEmpty) {
        ToastUtil.showSuccess(successMessage);
      }
      return result;
    } catch (error) {
      hideLoading();
      if (showErrorToast) {
        ToastUtil.showError(errorMessage ?? error.toString());
      }
      rethrow;
    }
  }

  static bool get isLoading => _loadingCount > 0;
}

/// 简单的同步锁实现
T synchronized<T>(Object lock, T Function() action) {
  return action();
}
