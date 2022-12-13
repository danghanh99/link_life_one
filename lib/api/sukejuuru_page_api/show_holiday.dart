import 'dart:convert';
import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;

import '../../constants/constant.dart';

class ShowHoliday {
  ShowHoliday() : super();

  Future<dynamic> showHoliday(
      {required String TANT_CD,
      required DateTime date,
      required Function(dynamic) onSuccess}) async {
    try {
      // final box = Hive.box<String>('user');
      // final id = box.values.last.toString();
      final year = date.year.toString();
      final month = date.month.toString();
      final response = await http.get(
        Uri.parse(
            "${Constant.url}Request/Schedule/requestShowHoliday.php?TANT_CD=${TANT_CD}&HOLIDAY_YEAR=${year}&GET_MONTH=${month}&GET_YEAR=${year}"),
      );

      if (response.statusCode == 200) {
        final dynamic body = jsonDecode(response.body);
        onSuccess.call(body);
        return body;
      } else {
        throw Exception('Failed to get list phong ban');
      }
    } catch (e) {
      print(e);
    }
  }
}
