import 'package:get/get.dart';
import '../../../../common/base/state/page_constant.dart';
import '../../../../common/base/state/page_status_controller.dart';

/// PageStatus 演示控制器
/// 演示如何手动控制页面状态
class PageStatusDemoLogic extends GetxController {
  late PageStatusController statusController;

  // 当前选中的状态
  final selectedStatus = PageState.success.obs;

  @override
  void onInit() {
    super.onInit();
    statusController = PageStatusController(_loadData);
  }

  Future<PageResult> _loadData() async {
    await Future.delayed(const Duration(seconds: 1));
    return const PageSuccess();
  }

  /// 切换到加载状态
  void setLoading() {
    selectedStatus.value = PageState.loading;
    statusController.setState(PageState.loading);
  }

  /// 切换到成功状态
  void setSuccess() {
    selectedStatus.value = PageState.success;
    statusController.setSuccess();
  }

  /// 切换到空数据状态
  void setEmpty() {
    selectedStatus.value = PageState.empty;
    statusController.setEmpty();
  }

  /// 切换到错误状态
  void setError() {
    selectedStatus.value = PageState.error;
    statusController.setError(PageError.networkError);
  }

  /// 模拟加载流程
  Future<void> simulateLoading() async {
    setLoading();
    await Future.delayed(const Duration(seconds: 2));
    setSuccess();
  }

  /// 模拟加载失败
  Future<void> simulateError() async {
    setLoading();
    await Future.delayed(const Duration(seconds: 1));
    setError();
  }
}
