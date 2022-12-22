import 'dart:convert';
import "package:http/http.dart" as http;

import '../../constants/constant.dart';

class ShowHoliday {
  ShowHoliday() : super();

  Future<dynamic> showHoliday(
      {required String TANT_CD,
      required Function(dynamic) onSuccess}) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${Constant.url}Request/Schedule/requestShowHoliday.php?TANT_CD=$TANT_CD"),
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
