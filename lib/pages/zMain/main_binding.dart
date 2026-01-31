import 'package:get/get.dart';

import 'home/home_binding.dart';
import 'main_logic.dart';
import 'my/my_binding.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainPageLogic());
    HomePageBinding().dependencies();
    MyPageBinding().dependencies();
  }
}
