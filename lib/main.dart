import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_getx_base_project/pages/launch/view.dart';
import 'package:flutter_getx_base_project/routes/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import 'config/them_config.dart';
import 'global.dart';
import 'services/storage/hive_storage_service.dart';
import 'services/storage/isar_storage_service.dart';
import 'persistent/hive/base/hive_manager.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PersistentInit.init();
  
  // 初始化存储服务
  await HiveStorageService.init();
  await IsarStorageService.init();
  
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void dispose() {
    // 应用退出时关闭Hive
    HiveManager().dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) => GetMaterialApp(
        getPages: AppRoutes.routes,
        defaultTransition: Transition.fade,
        builder: (context, widget) {
          return MediaQuery(
            //设置文字大小不随系统设置改变
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(1.0),
            ),
            child: widget!
          );
        },
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: LaunchPage(),
        // initialBinding: LaunchPageBinding(),
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        routingCallback: (routing) {},
      ),
    );
  }
}