import 'package:intl/intl.dart';

abstract class DateFormats {
  static const String iso8601 = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'";
  static const String monthDayYear = "mm/dd/yy";
  static const String dayMonthYearHint = "dd/MM/yyyy";
  static const String dayMonthYearJustHint = "dd/mm/yyyy";
  static const String dayMonthYear = "d/M/y";
  static const time = 'hh:mm a';
  static const day = 'dd';
  static const dayofweek = 'EEE';
  static const monthInNameYear = 'MMM yyyy';
  static const dayMonthYearTime = 'dd MMM yyyy hh:mm a';
  static const String weekDayMonthDayYearBE = 'EEE,d MMM yyyy';
  static const String weekDayMonthDayYear = 'EEE, d MMM yyyy';
  static const String dayMonthWeek = 'EEE, d MMM';
  static const dayMonthDay = 'EEE, d';
  static const String hourWDayMonth = 'hh:mm, EEE';
  static const String hh_mm_EEE = 'hh:mm, EEE';
  static const String hh_mm_EEE_d_MMM = 'hh:mm, EEE d MMM';
  static const String hh_mm_EEE_d_MMM_yyyy = 'hh:mm, EEE d MMM yyyy';
}

abstract class DateFormatter {
  static String iso8601(DateTime date) {
    return DateFormat(DateFormats.iso8601).format(date);
  }

  static String dayMonthDayYear(DateTime date) {
    String stringDate = DateFormat(DateFormats.weekDayMonthDayYear, 'vi').format(date);

    return addDateSuffix(stringDate, date, 1);
  }

  static String addDateSuffix(String stringDate, DateTime date, int indexDay) {
    if ('vi' == 'vi') return stringDate;
    String enDateSuffix = 'vi' == 'en' ? getDateSuffix(date) : '';
    List<String> arr = stringDate.split(" ");
    arr[indexDay] = arr[indexDay] + enDateSuffix;
    return plusSplit(arr, " ");
  }

  static String plusSplit(List<String> arr, String space) {
    String result = '';
    if (arr.length > 1)
      arr.forEach((element) {
        result = result + element.toString() + (arr.last != element ? space : '');
      });
    return result;
  }

  static String dayMonthWeek(DateTime date) {
    String stringDate = DateFormat(DateFormats.dayMonthWeek, 'vi').format(date);

    return addDateSuffix(stringDate, date, 1);
  }

  static String hourWDayMonth(DateTime date) {
    return DateFormat(DateFormats.hourWDayMonth, 'vi').format(date);
  }

  static String get_hh_mm_EEE(DateTime date) {
    String stringDate = DateFormat(DateFormats.hh_mm_EEE, 'vi').format(date).toString();
    if ('vi' == 'vi') return replace(stringDate, r'Th ', 'Th');

    return stringDate;
  }

  static String get_hh_mm_EEE_d_MMM(DateTime date) {
    String stringDate = DateFormat(DateFormats.hh_mm_EEE_d_MMM, 'vi').format(date);
    stringDate = addDateSuffix(stringDate, date, 2);
    if ('vi' == 'vi') return replace(stringDate, r'Th ', 'Th');
    return stringDate;
  }

  static String get_hh_mm_EEE_d_MMM_yyyy(DateTime date) {
    String stringDate = DateFormat(DateFormats.hh_mm_EEE_d_MMM_yyyy, 'vi').format(date);
    stringDate = addDateSuffix(stringDate, date, 2);
    if ('vi' == 'vi') return replace(stringDate, r'Th ', 'Th');
    return stringDate;
  }

  static String replace(
    String original,
    String from,
    String to,
  ) {
    if (original.contains(from)) return original.replaceAll(from, to);
    return original;
  }

  static String formattedDate(DateTime date) {
    return DateFormat(DateFormats.dayMonthYear).format(date);
  }

  static String capitalize(String str) {
    return "${str[0].toUpperCase()}${str.substring(1).toLowerCase()}";
  }

  static String monthInNameYear(DateTime date) {
    return capitalize(DateFormat(DateFormats.monthInNameYear, 'vi').format(date));
  }

  static String day(DateTime date) {
    return DateFormat(DateFormats.day).format(date);
  }

  static String dayofweek(DateTime date) {
    return DateFormat(DateFormats.dayofweek).format(date);
  }

  static String time(DateTime date) {
    return DateFormat(DateFormats.time).format(date);
  }

  static String dayMonthYearTime(DateTime date) {
    return DateFormat(DateFormats.dayMonthYearTime, 'vi').format(date);
  }

  static String weekDayMonthDayYear(DateTime date) {
    String stringDate = DateFormat(DateFormats.weekDayMonthDayYear, 'vi').format(date);

    return addDateSuffix(stringDate, date, 1);
  }

  static String dayMonthDay(DateTime date) {
    String stringDate = DateFormat(DateFormats.dayMonthDay, 'vi').format(date);
    return addDateSuffix(stringDate, date, 1);
  }

  static String getDateSuffix(DateTime date) {
    var suffix = "th";
    var digit = date.day % 10;
    if ((digit > 0 && digit < 4) && (date.day < 11 || date.day > 13)) {
      suffix = ["st", "nd", "rd"][digit - 1];
    }
    return suffix;
  }
}

extension DateTimeExt on DateTime {
  String get displayTime {
    final dayMonthDay = DateFormat(DateFormats.dayMonthDay, 'vi').format(this);
    final monthInNameYear = DateFormat(DateFormats.monthInNameYear, 'vi').format(this);

    if ('vi' == 'en') {
      String suffixDay = 'th';

      if (day >= 11 && day <= 13) {
        suffixDay = 'th';
      } else {
        switch (day % 10) {
          case 1:
            suffixDay = 'st';
            break;
          case 2:
            suffixDay = 'nd';
            break;
          case 3:
            suffixDay = 'rd';
            break;
          default:
            suffixDay = 'th';
        }
      }

      return '$dayMonthDay$suffixDay $monthInNameYear';
    }

    if ('vi' == 'vi') {
      return '$dayMonthDay $monthInNameYear';
    }

    return '';
  }
}
