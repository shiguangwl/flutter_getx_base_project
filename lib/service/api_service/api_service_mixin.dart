import '../../common/log/logger.dart';
import '../../common/network/exception/api_exception.dart';
import '../../common/network/exception/network_exception.dart';
import '../../common/utils/toast_util.dart';
import '../../network/models/base/result.dart';

/// 服务层 Mixin
/// 提供统一的API调用处理、异常处理和状态管理
mixin ApiServiceMixin {
  /// 统一的API调用处理
  ///
  /// 参数：
  /// - [apiCall] API调用函数
  /// - [operationName] 操作名称，用于日志记录
  /// - [showErrorToast] 是否显示错误提示，默认true
  /// - [showSuccessToast] 是否显示成功提示，默认false
  /// - [successMessage] 成功提示消息
  ///
  /// 返回：处理结果，成功时返回数据，失败时返回null
  Future<T?> handleApiCall<T>({
    required Future<Result<T>> Function() apiCall,
    required String operationName,
    bool showErrorToast = true,
    bool showSuccessToast = false,
    String? successMessage,
  }) async {
    try {
      final result = await apiCall();

      if (result.success) {
        if (showSuccessToast && successMessage != null) {
          ToastUtil.showSuccess(successMessage);
        }
        return result.data;
      } else {
        final errorMessage = result.msg ?? '$operationName失败';
        Log.e('$operationName失败: $errorMessage');
        if (showErrorToast) {
          ToastUtil.showError(errorMessage);
        }
        return null;
      }
    } catch (e, stackTrace) {
      Log.e('$operationName异常', e, stackTrace);
      if (showErrorToast) {
        if (e is ApiException) {
          Log.e("API异常: ${e.message}");
        } else if (e is NetworkException) {
          ToastUtil.showError("网络错误: ${e.message}");
        } else {
          ToastUtil.showError('$operationName失败，请稍后重试');
        }
      }
      rethrow;
    }
  }

  /// 统一的API调用处理（返回bool结果）
  Future<bool> handleApiBoolCall({
    required Future<Result<dynamic>> Function() apiCall,
    required String operationName,
    bool showErrorToast = true,
    bool showSuccessToast = false,
    String? successMessage,
  }) async {
    await handleApiCall<dynamic>(
      apiCall: apiCall,
      operationName: operationName,
      showErrorToast: showErrorToast,
      showSuccessToast: showSuccessToast,
      successMessage: successMessage,
    );
    return true;
  }

  /// 静默API调用（不显示任何提示）
  Future<T?> handleApiCallSilently<T>({
    required Future<Result<T>> Function() apiCall,
    required String operationName,
  }) async {
    return handleApiCall<T>(
      apiCall: apiCall,
      operationName: operationName,
      showErrorToast: false,
      showSuccessToast: false,
    );
  }
}
