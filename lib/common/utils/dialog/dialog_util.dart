import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../loading_util.dart';
import 'dialog_builder.dart';
import 'dialog_button.dart';
import 'dialog_config.dart';

export 'dialog_button.dart';
export 'dialog_config.dart';

/// 对话框工具类
class DialogUtil {
  const DialogUtil._internal();

  /// 显示确认对话框
  static Future<bool?> showConfirmDialog({
    String? title,
    String? content,
    Widget? contentWidget,
    String confirmText = '确认',
    String cancelText = '取消',
    VoidCallback? onConfirm,
    VoidCallback? onCancel,
    DialogConfig? config,
  }) async {
    final cfg = config ?? const DialogConfig();
    return await Get.dialog<bool>(
      DialogBuilder.build(
        config: cfg,
        title: title,
        content: content,
        contentWidget: contentWidget,
        buttons: [
          DialogButton(
            text: cancelText,
            onPressed: () {
              onCancel?.call();
              Get.back(result: false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
              foregroundColor: Colors.black87,
            ),
          ),
          DialogButton(
            text: confirmText,
            onPressed: () {
              Get.back(result: true);
              onConfirm?.call();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(Get.context!).primaryColor,
              foregroundColor: Colors.white,
            ),
            isPrimary: true,
          ),
        ],
      ),
      barrierDismissible: cfg.barrierDismissible,
    );
  }

  /// 显示确认对话框并执行action
  static Future<T?> showConfirmAndExecute<T>({
    String? title,
    String? content,
    Widget? contentWidget,
    required Future<T> Function() action,
    String confirmText = '确认',
    String cancelText = '取消',
    DialogConfig? config,
    bool showLoading = true,
    String loadingMessage = '处理中...',
    String? successMessage,
    String? errorMessage,
    bool showSuccessToast = false,
    bool showErrorToast = true,
  }) async {
    final confirmed = await showConfirmDialog(
      title: title,
      content: content,
      contentWidget: contentWidget,
      confirmText: confirmText,
      cancelText: cancelText,
      config: config,
    );

    if (confirmed == true) {
      if (showLoading) {
        return await LoadingUtil.executeWithLoading<T>(
          action,
          loadingMessage: loadingMessage,
          successMessage: successMessage,
          errorMessage: errorMessage,
          showSuccessToast: showSuccessToast,
          showErrorToast: showErrorToast,
        );
      } else {
        return await action();
      }
    }
    return null;
  }

  /// 显示自定义按钮对话框
  static Future<T?> showCustomDialog<T>({
    String? title,
    String? content,
    Widget? contentWidget,
    required List<DialogButton> buttons,
    DialogConfig? config,
  }) async {
    final cfg = config ?? const DialogConfig();
    return await Get.dialog<T>(
      DialogBuilder.build(
        config: cfg,
        title: title,
        content: content,
        contentWidget: contentWidget,
        buttons: buttons,
      ),
      barrierDismissible: cfg.barrierDismissible,
    );
  }

  /// 显示单个按钮的提示对话框
  static Future<void> showAlertDialog({
    String? title,
    String? content,
    Widget? contentWidget,
    String buttonText = '确定',
    VoidCallback? onPressed,
    DialogConfig? config,
  }) async {
    final cfg = config ?? const DialogConfig();
    await Get.dialog(
      DialogBuilder.build(
        config: cfg,
        title: title,
        content: content,
        contentWidget: contentWidget,
        buttons: [
          DialogButton(
            text: buttonText,
            onPressed: () {
              onPressed?.call();
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(Get.context!).primaryColor,
              foregroundColor: Colors.white,
            ),
            isPrimary: true,
          ),
        ],
      ),
      barrierDismissible: cfg.barrierDismissible,
    );
  }

  /// 显示选择对话框
  static Future<int?> showChoiceDialog({
    String? title,
    String? content,
    Widget? contentWidget,
    required List<String> options,
    DialogConfig? config,
  }) async {
    final cfg = config ?? const DialogConfig();
    final buttons = <DialogButton>[
      ...options.asMap().entries.map((entry) {
        return DialogButton(
          text: entry.value,
          onPressed: () => Get.back(result: entry.key),
          style: ElevatedButton.styleFrom(
            backgroundColor: entry.key == 0
                ? Theme.of(Get.context!).primaryColor
                : Colors.grey[300],
            foregroundColor: entry.key == 0 ? Colors.white : Colors.black87,
          ),
          isPrimary: entry.key == 0,
        );
      }),
      DialogButton(
        text: '取消',
        onPressed: () => Get.back(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[300],
          foregroundColor: Colors.black87,
        ),
      ),
    ];

    return await Get.dialog<int>(
      DialogBuilder.build(
        config: cfg,
        title: title,
        content: content,
        contentWidget: contentWidget,
        buttons: buttons,
      ),
      barrierDismissible: cfg.barrierDismissible,
    );
  }

  /// 关闭当前对话框
  static void closeDialog() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}
