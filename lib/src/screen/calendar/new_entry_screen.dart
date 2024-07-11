import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task/src/config/style/app_style.dart';
import 'package:flutter_task/src/screen/widgets/custom_appbar.dart';
import 'package:flutter_task/src/screen/widgets/global_widget.dart';
import 'package:flutter_task/src/utils/app_assets.dart';
import 'package:flutter_task/src/utils/app_color.dart';
import 'package:get/get.dart';

class NewEntryScreen extends StatefulWidget {
  const NewEntryScreen({super.key});

  @override
  State<NewEntryScreen> createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  final nameController = TextEditingController();
  final sentenceController = TextEditingController();
  final dateTimeController = TextEditingController();
  final fullDataController = TextEditingController();

  DateTime? finalSelectedDate;

  var bivagList = ['বাক্য', 'অনুচ্ছেদ', 'কবিতা', 'ছোট গল্প'];
  String? selectedBivag;

  var placeList = [
    'ঢাকা',
    'কুমিল্লা',
    'চট্টগ্রাম',
    'রাজশাহী',
    'খুলনা',
    'বরিশাল',
    'সিলেট',
    'রংপুর',
    'ময়মনসিংহ'
  ];
  String? selectedPlcae;
  @override
  void dispose() {
    nameController.dispose();
    sentenceController.dispose();
    dateTimeController.dispose();
    fullDataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(titleText: "নতুন যোগ করুন"),
            const SizeVer(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoldTextWidget(
                  text: "অনুচ্ছেদ",
                  size: 16,
                ),
                LightTextWidget(text: "৪৫ শব্দ"),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            FormField(
                controller: nameController,
                hintText: "অনুচ্ছেদ লিখুন",
                maximumWords: 42),
            const SizeVer(height: 20),
            const BoldTextWidget(
              text: "অনুচ্ছেদের বিভাগ",
              size: 16,
            ),
            const SizedBox(
              height: 8,
            ),
            dropDownFieldWidget(
              allValues: bivagList,
              hintText: "অনুচ্ছেদের বিভাগ নির্বাচন করুন",
              resultValue: selectedBivag,
              onChanged: (val) {
                setState(() {
                  selectedBivag = val;
                });
              },
            ),
            const SizeVer(height: 20),
            const BoldTextWidget(
              text: "তারিখ ও সময়",
              size: 16,
            ),
            const SizedBox(
              height: 8,
            ),
            FormField(
              controller: dateTimeController,
              hintText: "নির্বাচন করুন",
              maximumWords: 1,
              leadingIcon: Container(
                alignment: Alignment.center,
                // height: 10,
                width: 10,
                child: SvgPicture.asset(
                  AppAssets.calendar,
                  height: 16,
                  width: 16,
                  fit: BoxFit.scaleDown,
                  color: AppColors.grey,
                ),
              ),
              onTap: () async {
                await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2030),
                ).then((selectedDate) {
                  // After selecting the date, display the time picker.
                  if (selectedDate != null) {
                    showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((selectedTime) {
                      // Handle the selected date and time here.
                      if (selectedTime != null) {
                        DateTime selectedDateTime = DateTime(
                          selectedDate.year,
                          selectedDate.month,
                          selectedDate.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );
                        print(
                            selectedDateTime); // You can use the selectedDateTime as needed.

                        // formate this to bengali language
                        final day = convertNumsToBengali(
                            selectedDateTime.day.toString());
                        final month =
                            convertMonthsToBengali(selectedDateTime.month);
                        final year = convertNumsToBengali(
                            selectedDateTime.year.toString());
                        final hour = convertNumsToBengali(
                            selectedDateTime.hour.toString());
                        final min = convertNumsToBengali(
                            selectedDateTime.minute.toString());

                        finalSelectedDate = selectedDateTime;

                        dateTimeController.text =
                            "${day}ই ${month}, $year সময়- ${hour}:${min}";
                      }
                    });
                  }
                });
              },
            ),
            const SizeVer(height: 20),
            const BoldTextWidget(
              text: "স্থান",
              size: 16,
            ),
            const SizedBox(
              height: 8,
            ),
            dropDownFieldWidget(
              allValues: placeList,
              hintText: "নির্বাচন করুন",
              leadingIcon: SvgPicture.asset(
                AppAssets.location,
                color: AppColors.grey,
              ),
              resultValue: selectedPlcae,
              onTap: () {},
              onChanged: (val) {
                setState(() {
                  selectedPlcae = val;
                });
              },
            ),
            const SizeVer(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoldTextWidget(
                  text: "অনুচ্ছেদের বিবরণ",
                  size: 16,
                ),
                LightTextWidget(text: "১২০ শব্দ"),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            FormField(
              controller: fullDataController,
              hintText: "কার্যক্রমের বিবরণ লিখুন",
              maximumWords: 120,
              maxLines: 7,
            ),
            const SizeVer(height: 20),
            Container(
              alignment: Alignment.center,
              width: double.maxFinite,
              height: 45.h,
              decoration: BoxDecoration(
                  gradient: appLinearGradient, borderRadius: appBorderRadius10),
              child: SemiBoldTextWidget(
                text: "সংরক্ষন করুন",
                color: AppColors.white,
                size: 18,
              ),
            ),
            SizeVer(height: 20),
          ],
        ).paddingSymmetric(vertical: 5.h, horizontal: 21.w),
      ),
    );
  }

  Container dropDownFieldWidget(
      {required List<String> allValues,
      required String hintText,
      required String? resultValue,
      Widget? leadingIcon,
      VoidCallback? onTap,
      required void Function(dynamic)? onChanged}) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.white10,
          ),
          borderRadius: appBorderRadius10),
      child: DropdownButtonHideUnderline(
          child: DropdownButton(
        key: Key("key - $hintText"),
        isDense: true,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
        hint: Row(
          children: [
            leadingIcon != null ? leadingIcon : SizedBox(),
            leadingIcon != null ? SizeHor(width: 14) : SizedBox(),
            Text(
              hintText,
              style: hintTextStyle,
            ),
          ],
        ),
        isExpanded: true,
        icon: Icon(
          Icons.arrow_forward_ios_rounded,
          size: 17,
          color: AppColors.grey.withOpacity(.5),
        ),
        value: resultValue,
        onChanged: onChanged,
        onTap: onTap,
        elevation: 0,
        dropdownColor: AppColors.white,
        items: allValues.map<DropdownMenuItem>((e) {
          return DropdownMenuItem(value: e, child: Text(e));
        }).toList(),
      ) // your Dropdown Widget here
          ),
    );
  }
}

class FormField extends StatelessWidget {
  const FormField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.maximumWords,
      this.maxLines = 1,
      this.onTap,
      this.leadingIcon});

  final TextEditingController controller;
  final String hintText;
  final int maximumWords;
  final VoidCallback? onTap;
  final Widget? leadingIcon;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      // enabled: onTap != null,
      readOnly: onTap != null,
      controller: controller,
      cursorColor: Colors.black,
      maxLines: maxLines,
      inputFormatters: [LengthLimitingTextInputFormatter(maximumWords)],
      decoration: InputDecoration(
        isDense: true,
        hintText: hintText,
        prefixIcon: leadingIcon,
        suffixIcon: leadingIcon != null
            ? Icon(
                Icons.arrow_forward_ios_rounded,
                size: 17,
                color: AppColors.grey.withOpacity(.5),
              )
            : SizedBox(),
        hintStyle: hintTextStyle,
        border: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        errorBorder: outlineInputErrorBorder,
        focusedErrorBorder: outlineInputErrorBorder,
        enabledBorder: outlineInputBorder,
      ),
    );
  }
}
