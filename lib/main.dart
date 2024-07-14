import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/languages/translation.dart';
import 'package:flutter_task/src/bindings/all_bindings.dart';
import 'package:flutter_task/src/config/extension/string.dart';
import 'package:flutter_task/src/config/theme/my_theme.dart';
import 'package:flutter_task/src/routes/route_pages.dart';
import 'package:flutter_task/src/routes/routes.dart';
import 'package:flutter_task/src/screen/bottom_nav_screen.dart';
import 'package:flutter_task/src/screen/home/home_screen.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent, // navigation bar color
    statusBarColor: Colors.transparent, // status bar color
    statusBarIconBrightness: Brightness.dark,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.updateLocale(Locale('bd', 'BD'));

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => GetMaterialApp(
        title: 'Flutter Task',
        theme: myThemeData(),
        locale: Get.deviceLocale,
        fallbackLocale: Locale('en', 'US'),
        translations: Languages(),
        initialBinding: MyPageBinding(),
        initialRoute: Routes.HOME,
        getPages: AppPages.pages,
        // home: HomeScreen(),
      ),
    );
  }
}
