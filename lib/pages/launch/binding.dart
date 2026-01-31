import 'package:get/get.dart';
import 'logic.dart';

class LaunchPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LaunchLogic>(LaunchLogic());
  }
}
