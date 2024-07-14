import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task/src/config/style/app_style.dart';
import 'package:flutter_task/src/controller/home_controller.dart';
import 'package:flutter_task/src/screen/widgets/global_widget.dart';
import 'package:flutter_task/src/utils/app_assets.dart';
import 'package:flutter_task/src/utils/app_color.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeController controller;
  @override
  void initState() {
    controller = Get.find<HomeController>();
    controller.getPassedDaysString();
    super.initState();
  }

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
    final remainingDay = controller.getRemainingDays();
    print(controller.passedDaysStr);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        children: [
          buildAppbarWidgets(),
          const SizeVer(height: 25),
          buildProfileCardWidgets(),
          const SizeVer(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  GetBuilder<HomeController>(builder: (con) {
                    if (con.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    }

                    return CircularPercentIndicator(
                      radius: 55.r,
                      lineWidth: 8.0,
                      // arcBackgroundColor: AppColors.grey,
                      backgroundColor: const Color(0xFFF5F5F5),
                      percent: con.getDifferencePercentage() / 100,
                      startAngle: 180,

                      center: SemiBoldTextWidget(
                        text: con.passedDaysStr ?? '.......',
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
                  const SizeVer(height: 10),
                  const SemiBoldTextWidget(
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
                  const SemiBoldTextWidget(
                    text: "মেয়াদকাল",
                    size: 16,
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(AppAssets.calendar, height: 15),
                      const SizeHor(width: 4),
                      const SemiBoldTextWidget(
                        text: "১ই জানুয়ারি ২০২৪ - ৩১ই জানুয়ারি ২০৩০",
                        weight: FontWeight.w500,
                        size: 12,
                      ),
                    ],
                  ),
                  const SizeVer(height: 10),
                  const SemiBoldTextWidget(
                    text: "আরও বাকি",
                    color: AppColors.red,
                  ),
                  const SizeVer(height: 6),
                  Row(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              buildBorderContainer(remainingDay[0]),
                              buildBorderContainer(remainingDay[1]),
                            ],
                          ),
                          const SizeVer(height: 6),
                          const SemiBoldTextWidget(text: "বছর")
                        ],
                      ),
                      const SizeHor(width: 20),
                      Column(
                        children: [
                          Row(
                            children: [
                              buildBorderContainer(remainingDay[2]),
                              buildBorderContainer(remainingDay[3]),
                            ],
                          ),
                          const SizeVer(height: 6),
                          const SemiBoldTextWidget(text: "মাস")
                        ],
                      ),
                      const SizeHor(width: 20),
                      Column(
                        children: [
                          Row(
                            children: [
                              buildBorderContainer(remainingDay[4]),
                              buildBorderContainer(remainingDay[5]),
                            ],
                          ),
                          const SizeVer(height: 6),
                          const SemiBoldTextWidget(text: "দিন")
                        ],
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
          const SizeVer(height: 15),
          Expanded(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                    const SemiBoldTextWidget(
                      text: "মেনু নং",
                      size: 16,
                    ),
                    SemiBoldTextWidget(
                      text: convertNumsToBengali("0000${index + 1}"),
                      size: 16,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ).paddingSymmetric(horizontal: 21.w, vertical: 5.h)),
    );
  }

  Row buildAppbarWidgets() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
            const SizeHor(width: 5),
            Image.asset(AppAssets.demoImg),
            const SizeHor(width: 7),
            Text(
              "Flutter Task",
              style: TextStyle(
                  fontFamily: 'Arial',
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        SvgPicture.asset(AppAssets.notification)
      ],
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
          boxShadow: [appBoxShadow]),
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
}
