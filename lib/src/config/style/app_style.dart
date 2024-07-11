import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_color.dart';

const appLinearGradient = LinearGradient(
    colors: [AppColors.primaryLightClr, AppColors.primaryClr],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);
const appBlackLinearGradient = LinearGradient(
    colors: [AppColors.kBlackClr, AppColors.kBlackClr],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

var appBoxShadow = BoxShadow(
    color: Colors.black.withOpacity(.1),
    blurRadius: 6,
    blurStyle: BlurStyle.outer,
    spreadRadius: 2);
var appBorderRadius10 = BorderRadius.circular(10.r);

var outlineInputBorder = OutlineInputBorder(
    borderSide: BorderSide(
        width: 1, color: AppColors.white10, style: BorderStyle.solid),
    borderRadius: BorderRadius.all(Radius.circular(10.r)));
var outlineInputErrorBorder = OutlineInputBorder(
    borderSide:
        BorderSide(width: 1, color: Colors.red, style: BorderStyle.solid),
    borderRadius: BorderRadius.all(Radius.circular(10.r)));

var hintTextStyle = TextStyle(
    fontWeight: FontWeight.w500, fontSize: 14.sp, color: AppColors.grey);
