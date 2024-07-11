import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task/src/utils/app_assets.dart';

import 'global_widget.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      this.leadingImage,
      required this.titleText,
      this.leadingIcon});

  final String? leadingImage;
  final String titleText;
  final IconButton? leadingIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leadingIcon == null
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back))
            : leadingIcon!,
        Text(
          titleText,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
        ),
        SvgPicture.asset(AppAssets.notification)
      ],
    );
  }
}
