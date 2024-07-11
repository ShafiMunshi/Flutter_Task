import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task/src/screen/calendar/calendar_screen.dart';
import 'package:flutter_task/src/screen/calendar/new_entry_screen.dart';
import 'package:flutter_task/src/screen/home/home_screen.dart';
import 'package:flutter_task/src/utils/app_color.dart';

import '../config/style/app_style.dart';

class KBottomNavigation extends StatefulWidget {
  const KBottomNavigation({
    super.key,
  });

  @override
  KBottomNavigationState createState() => KBottomNavigationState();
}

class KBottomNavigationState extends State<KBottomNavigation> {
  var isSelected = 0;

  List pageLists = [];

  @override
  void initState() {
    super.initState();
    pageLists = [
      HomeScreen(),
      CalendarScreen(),
      HomeScreen(),
      HomeScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    Widget tabItem(var pos, var icon) {
      return GestureDetector(
        onTap: () {
          setState(() {
            isSelected = pos;
          });
        },
        child: Column(
          children: [
            Container(
              width: 70.w,
              height: 45.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.white,
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                isSelected == pos ? "${icon}_fill.svg" : "$icon.svg",
                width: 24.w,
                height: 24.h,
              ),
            ),
            Container(
              height: 8,
              width: 8,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected == pos
                      ? AppColors.primaryClr
                      : AppColors.white),
            )
          ],
        ),
      );
    }

    return Scaffold(
      // backgroundColor: AppColors.scaffollDarkColor,
      body: pageLists[isSelected],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusElevation: 1,
        highlightElevation: 0,
        backgroundColor: Colors.transparent,
        elevation: 0,
        onPressed: () {},
        child: Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, gradient: appLinearGradient),
            child: Image.asset(
              'assets/icons/cameraa.png',
              height: 10,
              width: 10,
            )),
      ),
      bottomNavigationBar: BottomAppBar(
        // surfaceTintColor: Colors.red,
        shadowColor: Colors.black,

        shape: CircularNotchedRectangle(),
        // clipBehavior: Clip.none,
        notchMargin: 10.h,
        elevation: 10,
        height: 75.h,
        color: AppColors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            tabItem(0, "assets/icons/home"),
            tabItem(1, "assets/icons/calendar"),
            Container(width: 60.w, height: 45.h),
            tabItem(2, "assets/icons/menu"),
            tabItem(3, "assets/icons/profile"),
          ],
        ),
      ),
    );
  }
}
