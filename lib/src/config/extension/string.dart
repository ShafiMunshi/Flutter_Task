extension StringExtention on String {
  static String getActualDayTime(DateTime dateTime) {
  // adding 6 hours more to check the time is AM or PM
  DateTime gmtPlus6DateTime = dateTime.toUtc().add(Duration(hours: 6));

  bool isAM = gmtPlus6DateTime.hour < 12;

  if (isAM) {
    if (dateTime.hour > 5 && dateTime.hour <= 11) {
      return "সকাল";
    } else {
      return "রাত";
    }
  } else {
    if (dateTime.hour == 12 || dateTime.hour < 4) {
      return "দুপুর";
    } else {
      return "রাত";
    }
  }
}
}
