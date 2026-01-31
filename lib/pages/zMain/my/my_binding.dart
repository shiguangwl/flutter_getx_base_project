import 'package:get/get.dart';

import '../../zMain/my/my_logic.dart';

class MyPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyLogic());
  }
}
