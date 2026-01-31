import '../../../../common/base/controller/base_controller.dart';
import '../../../../common/base/state/page_constant.dart';

/// BaseView 演示控制器
/// 演示 BaseController 的基本用法
class BaseViewDemoLogic extends BaseController {
  String message = '这是通过 Controller 管理的数据';
  int counter = 0;

  void incrementCounter() {
    counter++;
    update(); // 通知 GetBuilder 刷新
  }

  void resetCounter() {
    counter = 0;
    update();
  }

  /// 页面加载逻辑
  /// 返回 PageResult 表示加载结果状态
  @override
  Future<PageResult> onLoadPage() async {
    // 模拟网络请求延迟
    await Future.delayed(const Duration(milliseconds: 500));
    return const PageSuccess();
  }
}
