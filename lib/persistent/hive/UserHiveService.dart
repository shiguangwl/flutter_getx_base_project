import 'package:flutter_getx_base_project/persistent/hive/base/hive_base_service.dart';
import 'package:flutter_getx_base_project/persistent/hive/model/User.dart';
import 'package:flutter_getx_base_project/persistent/hive/base/hive_manager.dart';

class UserHiveService extends HiveBaseService<User> {
  static final UserHiveService _instance = UserHiveService._();
  static UserHiveService get instance => HiveManager().registerService(_instance);
  
  UserHiveService._() : super('users');

  List<User> findUsersByAge(int age) {
    return where((user) => user.age == age);
  }

  User? findUserByName(String name) {
    return firstWhere((user) => user.name == name);
  }


}


// 使Demo
// // 注册适配器（在app启动时）
// void main() async {
//   await Hive.initFlutter();
//   Hive.registerAdapter(UserAdapter()); // 需要先创建 UserAdapter

//   runApp(MyApp());
// }

// // 使用服务
// final userService = UserHiveService();
// await userService.init();

// // 添加用户
// await userService.add(User('张三', 25));

// // 查询用户
// final user = userService.findUserByName('张三');

// // 监听变化
// final subscription = userService.watch(
//   onData: (event) {
//     print('数据发生变化：${event.value}');
//   },
// );

// // 关闭数据库
// await userService.close();