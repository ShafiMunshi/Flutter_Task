import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_task/src/utils/app_color.dart';

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
      this.size = 14});

  final String text;
  final Color color;
  final int size;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: TextStyle(
            fontWeight: FontWeight.w500, fontSize: size.sp, color: color),
        overflow: TextOverflow.ellipsis);
  }
}
