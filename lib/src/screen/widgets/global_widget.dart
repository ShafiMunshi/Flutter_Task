import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/src/utils/app_color.dart';

String convertNumsToBengali(String englishNumber) {
  const bengaliDigits = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
  final bengaliNumber = englishNumber
      .split('')
      .map((digit) => bengaliDigits[int.parse(digit)])
      .join();
  return bengaliNumber;
}

String convertMonthsToBengali(int monthNumber) {
  const monthNames = [
    'জানুয়ারি',
    'ফেব্রুয়ারি',
    'মার্চ',
    'এপ্রিল',
    'মে',
    'জুন',
    'জুলাই',
    'আগস্ট',
    'সেপেম্বর',
    'অক্টোবর',
    'নভেম্বর',
    'ডিসেম্বর'
  ];

  return monthNames[monthNumber - 1];
}

String convertWeekDayToBengali(int weekDayNumber) {
  const weekNames = [
    'সোম',
    'মঙ্গল',
    'বুধ',
    'বৃহঃ',
    'শুক্র',
    'শনি',
    'রবি',
  ];

  return weekNames[weekDayNumber - 1];
}

String getActualDayTime(DateTime dateTime) {
  // adding 6 hours more to check the time is AM or PM
  DateTime gmtPlus6DateTime = dateTime.toUtc().add(Duration(hours: 6));

  bool isAM = gmtPlus6DateTime.hour < 12;

  if (isAM) {
    if (dateTime.hour > 5 && dateTime.hour <= 11) {
      return "সকাল";
    } else {
      return "রাত";
    }
  } else {
    if (dateTime.hour == 12 || dateTime.hour < 4) {
      return "দুপুর";
    } else {
      return "রাত";
    }
  }
}

String getActualHourMinuteTime(DateTime dateTime) {
  String result = '';
  final hour = convertNumsToBengali(dateTime.hour.toString());
  result += "${hour}ঃ";
  if (hour.length == 1) {
    result = '০$result';
  }

  final minute = convertNumsToBengali(dateTime.minute.toString());

  if (minute.length == 1) {
    result += "০${minute}";
  } else {
    result += "${minute}";
  }

  result += " মিঃ";
  return result;
}

class SizeVer extends StatelessWidget {
  const SizeVer({super.key, required this.height});

  final int height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height.h,
    );
  }
}

class SizeHor extends StatelessWidget {
  const SizeHor({super.key, required this.width});

  final int width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width.w,
    );
  }
}

class BoldTextWidget extends StatelessWidget {
  const BoldTextWidget(
      {super.key,
      required this.text,
      this.color = AppColors.kBlackClr,
      this.size = 20});

  final String text;
  final Color color;
  final int size;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: size.sp, color: color),
        overflow: TextOverflow.ellipsis);
  }
}

class SemiBoldTextWidget extends StatelessWidget {
  const SemiBoldTextWidget(
      {super.key,
      required this.text,
      this.color = AppColors.kBlackClr,
      this.weight = FontWeight.w600,
      this.size = 15});

  final String text;
  final Color color;
  final int size;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontWeight: weight, fontSize: size.sp, color: color),
      overflow: TextOverflow.ellipsis,
    );
  }
}

class LightTextWidget extends StatelessWidget {
  const LightTextWidget(
      {super.key,
      required this.text,
      this.color = AppColors.grey,
      this.overflow = TextOverflow.ellipsis,
      this.isCenter = false,
      this.size = 14});

  final String text;
  final Color color;
  final int size;
  final TextOverflow overflow;
  final bool isCenter;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w500, fontSize: size.sp, color: color),
      overflow: overflow,
      textAlign: isCenter ? TextAlign.center : TextAlign.left,
    );
  }
}

class BodyTextWidget extends StatelessWidget {
  const BodyTextWidget(
      {super.key,
      required this.text,
      this.color = AppColors.secondaryWhite,
      this.size = 12});

  final String text;
  final Color color;
  final int size;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontWeight: FontWeight.w500, fontSize: size.sp, color: color),
    );
  }
}
