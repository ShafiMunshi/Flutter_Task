import 'package:flutter/material.dart';
import 'package:flutter_task/src/utils/app_color.dart';

ThemeData myThemeData() {
  return ThemeData(
      fontFamily: 'NotoSerif',
      primaryColor: AppColors.primaryClr,
      scaffoldBackgroundColor: AppColors.white,
      useMaterial3: true,
      indicatorColor: AppColors.primaryClr,
      progressIndicatorTheme:
          ProgressIndicatorThemeData(color: AppColors.primaryClr));
}
