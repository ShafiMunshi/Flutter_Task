import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_task/src/screen/widgets/global_widget.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CalendarController extends GetxController {
  String todayDate = '';
  List<DateTime> allWeekendDays = [];

  ItemScrollController itemScrollController = ItemScrollController();

  @override
  void onInit() {
    todayDate = getTodayDateString();
    allWeekendDays = getAllWeekends();
    do_jump();
    super.onInit();

    
  }

  void do_jump() {
    WidgetsBinding.instance.addPostFrameCallback((_) => jumpToIndex(4));
  }

  void jumpToIndex(int index) => itemScrollController.jumpTo(index: index);

  String getTodayDateString() {
    final today = DateTime.now();

    final curDate = convertNumsToBengali(today.day.toString());
    final curMonth = convertMonthsToBengali(today.month);
    return "$curDateই $curMonth";
  }

  List<DateTime> getAllWeekends() {
    List<DateTime> lists = [];
    DateTime curDateTime = DateTime.now();
    lists.add(curDateTime);

    // get the previous 7 days from today

    for (var i = 0; i < 7; i++) {
      curDateTime = curDateTime.subtract(Duration(days: 1));
      lists.insert(0, curDateTime);
    }

    curDateTime = DateTime.now();

    for (var i = 0; i < 7; i++) {
      curDateTime = curDateTime.add(Duration(days: 1));
      lists.add(curDateTime);
    }

    return lists;
  }
}
