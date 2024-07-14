import 'package:flutter_task/src/screen/widgets/global_widget.dart';
import 'package:flutter_task/src/service/custom_logger.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final log = logger(HomeController);
  final lastDate = DateTime(2030, 1, 31);
  final firstDate = DateTime(2024, 1, 1);
  final today = DateTime.now();
  String? passedDaysStr;

  @override
  void onInit() {
    getInitialData();
    super.onInit();
  }

  void getInitialData() {
    isLoading = true;
    update();

    // calculate all date
    getPassedDaysString();
    getDifferencePercentage();

    isLoading = false;
    update();
  }

  double getDifferencePercentage() {
    final totalDays = lastDate.difference(firstDate).inDays;
    final passedDays = today.difference(firstDate).inDays;

    return totalDays / passedDays;
  }

  bool isLoading = false;

  void getPassedDaysString() {
    // isLoading = true;
    // update(['home']);

    String data = '';
    int passedDays =
        today.difference(firstDate).inDays; // get total passed days from

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

    passedDaysStr = data;

    print(passedDays);

    // isLoading = false;
    // update(['home']);
  }

  String getRemainingDays() {
    final now = DateTime.now();
    final targetDate = DateTime(2030, 1, 31);

    final difference = targetDate.difference(now);
    int totalDays = difference.inDays;

    // Approximate average days per month
    const averageDaysPerMonth = 365.25 / 12;

    int years = 0;
    while (totalDays >= 365 + (isLeapYear(now.year + years) ? 1 : 0)) {
      totalDays -= 365 + (isLeapYear(now.year + years) ? 1 : 0);
      years++;
    }

    int months = (totalDays / averageDaysPerMonth).floor();
    int days = totalDays - (months * averageDaysPerMonth).round();

    print('Years: $years');
    print('Months: $months');
    print('Days: $days');

    String data = '';

    if (years > 0) {
      if (years > 9) {
        data += "${convertNumsToBengali(years.toString())}";
      } else {
        data += "০${convertNumsToBengali(years.toString())}";
      }
    }

    if (months > 0) {
      if (months > 9) {
        data += "${convertNumsToBengali(months.toString())}";
      } else {
        data += "০${convertNumsToBengali(months.toString())}";
      }
    }

    if (days > 9) {
      data += "${convertNumsToBengali(days.toString())}";
    } else {
      data += "০${convertNumsToBengali(days.toString())}";
    }

    return data;
  }

  bool isLeapYear(int year) {
    return (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
  }
}




  // String getRemainingDaysString() {
  //   String data = '';

  //   int remainingDays = lastDate.difference(today).inDays;

  //   print(remainingDays);

  //   int passedYear = (remainingDays / 365).floor();
  //   if (passedYear > 0) {
  //     if (passedYear > 9) {
  //       data += "${convertNumsToBengali(passedYear.toString())}";
  //     } else {
  //       data += "০${convertNumsToBengali(passedYear.toString())}";
  //     }
  //     remainingDays = remainingDays % 365;
  //   }

  //   int passedMonth = (remainingDays / 30).floor();
  //   if (passedMonth > 0) {
  //     if (passedMonth > 9) {
  //       data += "${convertNumsToBengali(passedMonth.toString())}";
  //     } else {
  //       data += "০${convertNumsToBengali(passedMonth.toString())}";
  //     }
  //   }

  //   if (remainingDays > 9) {
  //     data += "${convertNumsToBengali(remainingDays.toString())}";
  //   } else {
  //     data += "০${convertNumsToBengali(remainingDays.toString())}";
  //   }

  //   return data;
  // }