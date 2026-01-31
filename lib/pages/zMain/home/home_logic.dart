import '../../../common/base/controller/base_controller.dart';
import '../../../common/base/state/page_constant.dart';

class HomePageLogic extends BaseController {
  @override
  Future<PageResult> onLoadPage() async {
    return const PageSuccess();
  }
}
