import 'dart:convert';
import "package:http/http.dart" as http;

import '../../constants/constant.dart';

class ShowHoliday {
  ShowHoliday() : super();

  Future<dynamic> showHoliday({
    required String tantCd,
    required String yearMonth,
      required Function(dynamic) onSuccess
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${Constant.url}Request/Schedule/requestShowHoliday.php?TANT_CD=$tantCd&YM=$yearMonth"),
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
