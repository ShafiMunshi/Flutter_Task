import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task/src/config/style/app_style.dart';
import 'package:flutter_task/src/controller/calendar_controller.dart';
import 'package:flutter_task/src/routes/route_pages.dart';
import 'package:flutter_task/src/screen/widgets/custom_appbar.dart';
import 'package:flutter_task/src/screen/widgets/global_widget.dart';
import 'package:flutter_task/src/utils/app_assets.dart';
import 'package:flutter_task/src/utils/app_color.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  @override
  void initState() {
    Get.lazyPut(() => CalendarController());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get.put(CalendarController());

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<CalendarController>(builder: (controller) {
          return Column(
            children: [
              CustomAppBar(
                titleText: "সময়রেখা",
                leadingIcon: IconButton(
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.menu,
                    )),
              ),
              const SizeVer(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SemiBoldTextWidget(
                    text: "আজ, ${controller.todayDate}",
                    size: 16,
                  ),
                  circularFlatButton(ontap: () {
                    Get.toNamed(Routes.NEW_ENTRY);
                  })
                ],
              ),
              const SizeVer(height: 20),
              buildWeekDayTimeline(controller),
              const SizeVer(height: 20),
              Container(
                // height: 300,
                margin: EdgeInsets.only(top: 2.h, right: 2, left: 2),
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r)),
                  boxShadow: [
                    appBoxShadow,
                    const BoxShadow(color: Colors.white, offset: Offset(3, 9)),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SemiBoldTextWidget(
                      text: "আজকের কার্যক্রম",
                      size: 16,
                    ),
                    const SizeVer(height: 20),
                    SizedBox(
                      height: 350.h,
                      child: GetBuilder<CalendarController>(builder: (con) {
                        if (con.isDataLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }

                        return ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: con.allQuotes!.data.length,
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            final quotesData = con.allQuotes!.data[index];
                            final qouteTime =
                                getActualHourMinuteTime(quotesData.date);

                            final qouteDayTime =
                                getActualDayTime(quotesData.date);

                            return Container(
                              margin: EdgeInsets.only(bottom: 15.h),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      LightTextWidget(
                                        text: qouteDayTime,
                                        color: (index + 1) % 2 == 0
                                            ? AppColors.blue
                                            : AppColors.kBlackClr,
                                      ),
                                      LightTextWidget(
                                        text: qouteTime,
                                        color: (index + 1) % 2 == 0
                                            ? AppColors.blue
                                            : AppColors.kBlackClr,
                                      ),
                                    ],
                                  ),
                                  BoxDataWidget(
                                      time: qouteTime,
                                      sentence: quotesData.name,
                                      tag: quotesData.category,
                                      locations: quotesData.location,
                                      isEven: (index + 1) % 2 == 0)
                                ],
                              ),
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              )
            ],
          ).paddingSymmetric(vertical: 5.h, horizontal: 21.w);
        }),
      ),
    );
  }

  Container buildWeekDayTimeline(CalendarController controller) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
          boxShadow: [appBoxShadow], borderRadius: appBorderRadius10),
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 12.h),
      child: GetBuilder(
          init: CalendarController(),
          builder: (con) {
            return ScrollablePositionedList.builder(
              itemScrollController: controller.itemScrollController,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: controller.allWeekendDays.length,
              itemBuilder: (BuildContext context, int index) {
                final isCurrentDate =
                    controller.allWeekendDays[index].day == DateTime.now().day;

                return Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 6.w),
                  decoration: isCurrentDate
                      ? BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: AppColors.primaryClr,
                          ),
                          borderRadius: BorderRadius.circular(20))
                      : const BoxDecoration(),
                  margin: EdgeInsets.symmetric(horizontal: 6.w),
                  child: Column(
                    // mainAxisSize: MainAxisSize.min,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LightTextWidget(
                        text:
                            "${convertWeekDayToBengali(controller.allWeekendDays[index].weekday)}",
                        size: 14,
                      ),
                      SemiBoldTextWidget(
                          text:
                              "${convertNumsToBengali(controller.allWeekendDays[index].day.toString())}",
                          size: 16)
                    ],
                  ),
                );
              },
            );
          }),
    );
  }

  GestureDetector circularFlatButton({required VoidCallback ontap}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: appLinearGradient),
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        child: const SemiBoldTextWidget(
          text: "নতুন যোগ করুন",
          color: AppColors.white,
          size: 12,
        ),
      ),
    );
  }
}

class BoxDataWidget extends StatelessWidget {
  const BoxDataWidget({
    super.key,
    required this.time,
    required this.sentence,
    required this.tag,
    required this.locations,
    required this.isEven,
  });

  final String time;
  final String sentence;
  final String tag;
  final String locations;
  final bool isEven;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210.w,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
          borderRadius: appBorderRadius10,
          gradient: isEven ? appBlackLinearGradient : appLinearGradient),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(AppAssets.clock),
              const SizeHor(width: 5),
              BodyTextWidget(text: time),
            ],
          ),
          const SizeHor(width: 10),
          BodyTextWidget(text: sentence),
          const SizeVer(height: 8),
          BodyTextWidget(text: tag),
          const SizeVer(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SvgPicture.asset(
                AppAssets.location,
                height: 18,
                colorFilter: const ColorFilter.mode(
                    AppColors.secondaryWhite, BlendMode.srcIn),
              ),
              const SizeHor(width: 4),
              BodyTextWidget(text: locations)
            ],
          )
        ],
      ),
    );
  }
}
