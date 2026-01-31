import '../state/page_status_controller.dart';
import '../state/page_constant.dart';
import '../view/abstract_base.dart';

/// 基础控制器类
/// 提供页面状态管理和数据加载的基础功能
/// 优化了状态管理逻辑，提升性能和可维护性
abstract class BaseController extends AbstractBaseController {
  late PageStatusController pageStatusController;

  @override
  void onInit() {
    super.onInit();
    pageStatusController = PageStatusController(onLoadPage);
  }

  /// 返回PageResult表示加载结果状态
  Future<PageResult> onLoadPage();
}
