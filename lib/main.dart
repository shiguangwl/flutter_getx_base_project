import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_getx_base_project/pages/launch/view.dart';
import 'package:flutter_getx_base_project/routes/router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import 'config/them_config.dart';
import 'global.dart';


Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

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