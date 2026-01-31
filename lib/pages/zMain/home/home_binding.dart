import 'package:get/get.dart';

import 'home_logic.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomePageLogic());
  }
}
