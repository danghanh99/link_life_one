import 'package:intl/intl.dart';

abstract class DateFormats {
  static const String yearMonthDay = 'yyyy/MM/dd';
  static const monthYear = 'MMM yyyy';
}

abstract class DateFormatter {
  static DateTime yearMonthDay(String date) {
    return DateFormat(DateFormats.yearMonthDay).parse(date);
  }

  static String yearMonthDay2(DateTime date) {
    return DateFormat(DateFormats.yearMonthDay).format(date);
  }

  static String monthYear(DateTime date) {
    return DateFormat(DateFormats.monthYear).format(date);
  }
}
