import 'package:flutter_task/src/controller/calendar_controller.dart';
import 'package:flutter_task/src/controller/home_controller.dart';
import 'package:get/get.dart';

class MyPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<CalendarController>(() => CalendarController());
  }
}
