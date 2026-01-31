import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'common/error/default_error_reporter.dart';
import 'common/error/error_catcher.dart';
import 'i18n/translations.dart';
import 'init.dart';
import 'routes/router.dart';
import 'service/locale_service.dart';
import 'service/theme_service.dart';

Future<void> main() async {
  final reporter = DefaultErrorReporter();
  ErrorCatcher.init(reporter);

  await ErrorCatcher.run(() async {
    await Global.init();
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) => Obx(
        () => GetMaterialApp(
          getPages: AppRoutes.routes,
          defaultTransition: Transition.cupertino,
          builder: (context, widget) {
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaler: TextScaler.linear(1.0),
                ),
                child: widget!);
          },
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeService.to.themeData,
          routingCallback: (routing) {},
          translations: AppTranslations(),
          locale: LocaleService.to.locale,
          fallbackLocale: LocaleService.to.supportedLocales.first,
          supportedLocales: LocaleService.to.supportedLocales,
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          initialRoute: AppRoutes.Launch,
        ),
      ),
    );
  }
}
