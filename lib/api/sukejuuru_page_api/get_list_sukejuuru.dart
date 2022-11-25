import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class GetListSukejuuru {
  GetListSukejuuru() : super();

  Future<List<dynamic>> getListSukejuuru(DateTime date) async {
    // final response = await http.get(
    //   Uri.parse(
    //       "https://koji-app.starboardasiavn.com/requestDefault.php?YMD=${DateFormat(('yyyy-MM-dd')).format(date)}"),
    // );
    return [];
    // if (response.statusCode == 200) {
    // final List<dynamic> body = jsonDecode(response.body);
    //   return [];
    // } else {
    //   throw Exception('Failed to get list Sukejuuru');
    // }
  }
}
