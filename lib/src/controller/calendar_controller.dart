import 'package:flutter/material.dart';
import 'package:flutter_task/src/config/custom/custom_snacber.dart';
import 'package:flutter_task/src/data/models/quotes_model.dart';
import 'package:flutter_task/src/data/remote/dio_call.dart';
import 'package:flutter_task/src/screen/widgets/global_widget.dart';
import 'package:flutter_task/src/utils/app_url.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CalendarController extends GetxController {
  String todayDate = '';
  List<DateTime> allWeekendDays = [];
  final nameWordCounter = 45.obs;
  final sentenceWordCounter = 120.obs;

  ItemScrollController itemScrollController = ItemScrollController();

  @override
  void onInit() {
    todayDate = getTodayDateString();
    allWeekendDays = getAllWeekends();
    do_jump();
    getAllQuotes();
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

  bool isDataLoading = false;
  QuotesModel? allQuotes;

  Future<void> getAllQuotes() async {
    await BaseClient.safeApiCall(AppUrl.api_endpoint, RequestType.get,
        onLoading: () {
      isDataLoading = true;
      update(['lists']);
    }, onSuccess: (response) {
      allQuotes = quotesModelFromJson(response.toString());

      // sorting the list data according to most neighbor date
      allQuotes!.data.sort((a, b) => b.date.compareTo(a.date));
    }, onError: (error) {
      // CustomSnackBar.showCustomErrorToast(message: error.message);
    });

    isDataLoading = false;
    update(['lists']);
  }

  bool isSubmitLoading = false;
  Future<bool> submitQouteData(
      {required String name,
      required String bivag,
      required DateTime date,
      required String location,
      required String fullSentence}) async {
    // here we can send form data to out api endpoint
    // for simplicity we will add these data to QoutsModel so that we can show that, to our calendar screen

    isSubmitLoading = true;
    update();

    await Future.delayed(const Duration(milliseconds: 500), () {
// Here you can write your code

      allQuotes?.data.insert(
          0,
          QutesInfo(
              date: date, name: name, category: bivag, location: location));

      isSubmitLoading = false;
      update();
      update(['lists']);
      return true;
    });

    return true;
  }

  void changeNameWordCount(String val) {
    if (val.length <= 45) {
      nameWordCounter.value = (45 - val.length);
    }
  }

  void changeSentenceWordCount(String val) {
    if (val.length <= 120) {
      sentenceWordCounter.value = (120 - val.length);
    }
  }
}
