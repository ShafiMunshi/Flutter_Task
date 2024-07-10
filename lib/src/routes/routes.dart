import 'package:flutter_task/src/routes/route_pages.dart';
import 'package:flutter_task/src/screen/bottom_nav_screen.dart';
import 'package:flutter_task/src/screen/home/home_screen.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () =>  KBottomNavigation(),
    ),
  ];
}
