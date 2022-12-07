import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class GetAnkenCuaMotPhongBan {
  GetAnkenCuaMotPhongBan() : super();

  Future<dynamic> getAnkenCuaMotPhongBan(String kojiGyoSyaCd, DateTime dateTime,
      Function(dynamic) onSuccess) async {
    if (kojiGyoSyaCd == "") {
      return null;
    } else {
      final response = await http.get(
        Uri.parse(
            "https://koji-app.starboardasiavn.com/Request/Schedule/requestDefault.php?KOJIGYOSYA_CD=${kojiGyoSyaCd}&YMD=${kojiGyoSyaCd}&YMD=${DateFormat(('yyyy-MM-dd')).format(dateTime)}"),
      );

      if (response.statusCode == 200) {
        final dynamic body = jsonDecode(response.body);
        onSuccess.call(body);
        return body;
      } else {
        throw Exception('Failed to getAnkenCuaMotPhongBan');
      }
    }
  }
}
