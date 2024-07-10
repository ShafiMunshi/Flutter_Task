import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task/src/controller/home_controller.dart';
import 'package:flutter_task/src/screen/widgets/global_widget.dart';
import 'package:flutter_task/src/utils/app_assets.dart';
import 'package:flutter_task/src/utils/app_color.dart';
import 'package:flutter_task/src/utils/app_strings.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final iconList = [
    AppAssets.people,
    AppAssets.house,
    AppAssets.sitPeople,
    AppAssets.library,
    AppAssets.docs,
    AppAssets.api
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          buildAppBarWidgets(),
          const SizeVer(height: 25),
          buildProfileCardWidgets(),
          const SizeVer(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  GetBuilder(
                      init: HomeController(),
                      builder: (con) {
                        return CircularPercentIndicator(
                          radius: 55.r,
                          lineWidth: 8.0,
                          // arcBackgroundColor: AppColors.grey,
                          backgroundColor: Color(0xFFF5F5F5),
                          percent: con.getDifferencePercentage() / 100,
                          startAngle: 180,
                          center: SemiBoldTextWidget(
                            text: con.getPassedDaysString(),
                            size: 14,
                          ),
                          linearGradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: <Color>[
                                AppColors.primaryLightClr,
                                AppColors.primaryClr
                              ]),
                        );
                      }),
                  SizeVer(height: 10),
                  SemiBoldTextWidget(
                    text: "সময় অতিবাহিত",
                    size: 16,
                  )
                ],
              ),
              // SizeHor(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SemiBoldTextWidget(
                    text: "মেয়াদকাল",
                    size: 16,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.calendar, height: 15),
                      SizeHor(width: 4),
                      SemiBoldTextWidget(
                        text: "১ই জানুয়ারি ২০২৪ - ৩১ই জানুয়ারি ২০৩০",
                        weight: FontWeight.w500,
                        size: 12,
                      ),
                    ],
                  ),
                  SizeVer(height: 10),
                  SemiBoldTextWidget(
                    text: "আরও বাকি",
                    color: AppColors.red,
                  ),
                  SizeVer(height: 6),
                  GetBuilder<HomeController>(builder: (con) {
                    return Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                buildBorderContainer(
                                    con.getRemainingDaysString()[0]),
                                buildBorderContainer(
                                    con.getRemainingDaysString()[1]),
                              ],
                            ),
                            SizeVer(height: 6),
                            SemiBoldTextWidget(text: "বছর")
                          ],
                        ),
                        SizeHor(width: 20),
                        Column(
                          children: [
                            Row(
                              children: [
                                buildBorderContainer(
                                    con.getRemainingDaysString()[2]),
                                buildBorderContainer(
                                    con.getRemainingDaysString()[3]),
                              ],
                            ),
                            SizeVer(height: 6),
                            SemiBoldTextWidget(text: "মাস")
                          ],
                        ),
                        SizeHor(width: 20),
                        Column(
                          children: [
                            Row(
                              children: [
                                buildBorderContainer(
                                    con.getRemainingDaysString()[4]),
                                buildBorderContainer(
                                    con.getRemainingDaysString()[5]),
                              ],
                            ),
                            SizeVer(height: 6),
                            SemiBoldTextWidget(text: "দিন")
                          ],
                        ),
                      ],
                    );
                  })
                ],
              )
            ],
          ),
          SizeVer(height: 15),
          Expanded(
            child: GridView.builder(
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 8 / 11,
                  crossAxisCount: 3,
                  mainAxisSpacing: 20.h,
                  crossAxisSpacing: 30.w),
              itemCount: 6,
              // shrinkWrap: true,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      // height: 40,
                      height: 70.h,
                      width: 70.w,
                      // padding: EdgeInsets.symmetric(vertical: 8, horizontal: 7),
                      decoration: BoxDecoration(
                          color: AppColors.grey.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(7.r)),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(iconList[index]),
                    ),
                    SemiBoldTextWidget(
                      text: "মেনু নং",
                      size: 16,
                    ),
                    SemiBoldTextWidget(
                      text: convertToBengali("0000${index + 1}"),
                      size: 16,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 21.w)),
    );
  }

  Container buildBorderContainer(String text) {
    return Container(
      height: 24.h,
      width: 24.w,
      margin: EdgeInsets.only(right: 4.w),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.red,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(4.r)),
      alignment: Alignment.center,
      child: SemiBoldTextWidget(text: text),
    );
  }

  Container buildProfileCardWidgets() {
    return Container(
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.r),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 6,
                blurStyle: BlurStyle.outer,
                spreadRadius: 2)
          ]),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40.r,
            backgroundImage: AssetImage(
              AppAssets.avatarImg,
            ),
          ),
          const SizeHor(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BoldTextWidget(
                text: "মোঃ মোহাইমেনুল রেজা",
              ),
              const SizeVer(height: 8),
              const LightTextWidget(text: "সফটবিডি লিমিটেড"),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    AppAssets.location,
                    height: 18,
                    colorFilter:
                        const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                  ),
                  const SizeHor(width: 4),
                  const LightTextWidget(text: "ঢাকা")
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Row buildAppBarWidgets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.menu),
            const SizeHor(width: 16),
            Image.asset(AppAssets.demoImg),
            const SizeHor(width: 14),
            Text(
              "Flutter Task",
              style: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700),
            )
          ],
        ),
        SvgPicture.asset(AppAssets.notification)
      ],
    );
  }
}
