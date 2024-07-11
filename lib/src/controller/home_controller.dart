import 'package:flutter_task/src/screen/widgets/global_widget.dart';
import 'package:flutter_task/src/service/custom_logger.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final log = logger(HomeController);
  final lastDate = DateTime(2030, 1, 31);
  final firstDate = DateTime(2024, 1, 1);
  final today = DateTime.now();

  @override
  void onInit() {
    super.onInit();

    // calculate all date
    getDifferencePercentage();
  }

  double getDifferencePercentage() {
    final totalDays = lastDate.difference(firstDate).inDays;
    final passedDays = today.difference(firstDate).inDays;

    return totalDays / passedDays;
  }

  getPassedDaysString() {
    String data = '';
    int passedDays = today.difference(firstDate).inDays;

    int passedYear = (passedDays / 365).floor();
    if (passedYear > 0) {
      data += "${convertNumsToBengali(passedYear.toString())} বছর ";
      passedDays = passedDays - (passedYear * 365);
    }

    int passedMonth = (passedDays / 30).floor();
    if (passedMonth > 0) {
      data += "${convertNumsToBengali(passedMonth.toString())} মাস ";
      // passedDays = passedDays % 30;
      passedDays = passedDays - (passedMonth * 30);
    }

    data += "${convertNumsToBengali(passedDays.toString())} দিন";

    return data;
  }

  String getRemainingDaysString() {
    String data = '';
    final totalDays = lastDate.difference(firstDate).inDays;
    final passedDays = today.difference(firstDate).inDays;

    int remainingDays = totalDays - passedDays;

    int passedYear = (remainingDays / 365).floor();
    if (passedYear > 0) {
      if (passedYear > 9) {
        data += "${convertNumsToBengali(passedYear.toString())}";
      } else {
        data += "০${convertNumsToBengali(passedYear.toString())}";
      }
      remainingDays = remainingDays % 365;
    }

    int passedMonth = (remainingDays / 30).floor();
    if (passedMonth > 0) {
      if (passedMonth > 9) {
        data += "${convertNumsToBengali(passedMonth.toString())}";
      } else {
        data += "০${convertNumsToBengali(passedMonth.toString())}";
      }
      remainingDays = remainingDays % 30;
    }

    if (passedDays > 9) {
      data += "${convertNumsToBengali(remainingDays.toString())}";
    } else {
      data += "০${convertNumsToBengali(remainingDays.toString())}";
    }

    return data;
  }
}
