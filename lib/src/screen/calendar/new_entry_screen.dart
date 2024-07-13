import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_task/src/config/custom/custom_snacber.dart';
import 'package:flutter_task/src/config/style/app_style.dart';
import 'package:flutter_task/src/controller/calendar_controller.dart';
import 'package:flutter_task/src/screen/widgets/custom_appbar.dart';
import 'package:flutter_task/src/screen/widgets/global_widget.dart';
import 'package:flutter_task/src/utils/app_assets.dart';
import 'package:flutter_task/src/utils/app_color.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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

    updateWordCounterValue();
    super.dispose();
  }

  final _fromKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Form(
          key: _fromKey,
          child: GetBuilder<CalendarController>(builder: (controller) {
            return Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                if (controller.isSubmitLoading)
                  const Center(child: CircularProgressIndicator()),
                ListView(
                  shrinkWrap: true,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CustomAppBar(titleText: "নতুন যোগ করুন"),
                    const SizeVer(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoldTextWidget(
                          text: "অনুচ্ছেদ",
                          size: 16,
                        ),
                        Obx(() => LightTextWidget(
                            text:
                                "${convertNumsToBengali(controller.nameWordCounter.value.toString())} শব্দ")),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    FormField(
                      controller: nameController,
                      onChanged: (val) {
                        controller.changeNameWordCount(val);
                      },
                      hintText: "অনুচ্ছেদ লিখুন",
                      maximumWords: 45,
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return "It's empty";
                        }

                        return null;
                      },
                    ),
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
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return "Select a date";
                        }

                        return null;
                      },
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

                                selectedDateTime =
                                    selectedDateTime.toUtc().toLocal();

                                // Format for 12-hour display
                                final formatter = DateFormat('hh:mm a');
                                final formattedTime =
                                    formatter.format(selectedDateTime);

                                print(formattedTime); // Output: e.g., 09:30 PM

                                selectedDateTime = selectedDateTime.copyWith(
                                    hour: int.parse(
                                      formattedTime.substring(0, 2),
                                    ),
                                    minute: int.parse(
                                      formattedTime.substring(3, 5),
                                    ));

                                // formate this to bengali language
                                final day = convertNumsToBengali(
                                    selectedDateTime.day.toString());
                                final month = convertMonthsToBengali(
                                    selectedDateTime.month);
                                final year = convertNumsToBengali(
                                    selectedDateTime.year.toString());
                                final hour = convertNumsToBengali(
                                    formattedTime.substring(0, 2)); // 07:43
                                final min = convertNumsToBengali(
                                    formattedTime.substring(3, 5));

                                finalSelectedDate = selectedDateTime;

                                print(selectedDateTime.toString());

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BoldTextWidget(
                          text: "অনুচ্ছেদের বিবরণ",
                          size: 16,
                        ),
                        Obx(() => LightTextWidget(
                            text:
                                "${convertNumsToBengali(controller.sentenceWordCounter.value.toString())} শব্দ")),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    FormField(
                      controller: fullDataController,
                      onChanged: (val) {
                        controller.changeSentenceWordCount(val);
                      },
                      validator: (val) {
                        if (val!.trim().isEmpty) {
                          return "It's empty";
                        }

                        return null;
                      },
                      hintText: "কার্যক্রমের বিবরণ লিখুন",
                      maximumWords: 120,
                      maxLines: 7,
                    ),
                    const SizeVer(height: 20),
                    ExpandedFlatButton(
                      text: "সংরক্ষন করুন",
                      ontap: () async {
                        if (_fromKey.currentState!.validate()) {
                          print("it's validate");

                          if (selectedBivag == null || selectedPlcae == null) {
                            CustomSnackBar.showCustomErrorToast(
                                message: "Please select something");
                          } else {
                            final isSubmitDone =
                                await controller.submitQouteData(
                                    bivag: selectedBivag!,
                                    name: nameController.text.trim(),
                                    date: finalSelectedDate!,
                                    location: selectedPlcae!,
                                    fullSentence:
                                        fullDataController.text.trim());

                            if (isSubmitDone) {
                              showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: AppColors.white,
                                    content: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          SvgPicture.asset(AppAssets.correct),
                                          const SizeVer(height: 20),
                                          const BoldTextWidget(
                                            text: "নতুন অনুচ্ছেদ সংরক্ষন",
                                            size: 16,
                                          ),
                                          const SizeVer(height: 8),
                                          const LightTextWidget(
                                            text:
                                                "আপনার সময়রেখাতে নতুন অনুচ্ছেদ সংরক্ষণ সম্পুর্ন হয়েছে ",
                                            overflow: TextOverflow.visible,
                                            isCenter: true,
                                          ),
                                          const SizeVer(height: 20),
                                          SizedBox(
                                            width: 200.w,
                                            child: ExpandedFlatButton(
                                                ontap: () {
                                                  Navigator.pop(context);
                                                  clearEverything();
                                                },
                                                text: "আরও যোগ করুন"),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                          }
                        }
                      },
                    ),
                    const SizeVer(height: 20),
                  ],
                ).paddingSymmetric(vertical: 5.h, horizontal: 21.w),
              ],
            );
          }),
        ),
      ),
    );
  }

  void clearEverything() {
    setState(() {
      fullDataController.text = '';
      nameController.text = '';
      // dateTimeController.;
      selectedBivag = null;
      selectedPlcae = null;

      updateWordCounterValue();
    });
  }

  void updateWordCounterValue() {
    var controller = Get.find<CalendarController>();
    controller.nameWordCounter.value = 45;
    controller.sentenceWordCounter.value = 120;
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
            leadingIcon ?? const SizedBox(),
            leadingIcon != null ? const SizeHor(width: 14) : const SizedBox(),
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

class ExpandedFlatButton extends StatelessWidget {
  const ExpandedFlatButton({
    super.key,
    required this.ontap,
    required this.text,
  });
  final VoidCallback ontap;
  final String text;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        alignment: Alignment.center,
        width: double.maxFinite,
        height: 45.h,
        decoration: BoxDecoration(
            gradient: appLinearGradient, borderRadius: appBorderRadius10),
        child: SemiBoldTextWidget(
          text: text,
          color: AppColors.white,
          size: 18,
        ),
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
      this.onChanged,
      this.validator,
      this.leadingIcon});

  final TextEditingController controller;
  final String hintText;
  final int maximumWords;
  final VoidCallback? onTap;
  final Widget? leadingIcon;
  final int maxLines;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      onChanged: onChanged,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
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
            : const SizedBox(),
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
