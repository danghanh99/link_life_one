import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:intl/intl.dart';

import '../../constants/constant.dart';

class GetAnkenCuaMotPhongBan {
  GetAnkenCuaMotPhongBan() : super();

  Future<dynamic> getAnkenCuaMotPhongBan(
    String kojiGyoSyaCd,
    DateTime dateTime,
    Function(dynamic) onSuccess,
    Function() onFailed,
  ) async {
    if (kojiGyoSyaCd == "") {
      return null;
    } else {
      final response = await http.get(
        Uri.parse(
            "${Constant.url}Request/Schedule/requestDefault.php?KOJIGYOSYA_CD=${kojiGyoSyaCd}&YMD=${kojiGyoSyaCd}&YMD=${DateFormat(('yyyy-MM-dd')).format(dateTime)}"),
      );

      if (response.statusCode == 200) {
        final dynamic body = jsonDecode(response.body);
        onSuccess.call(body);
        return body;
      } else {
        onFailed.call();
        return '';
      }
    }
  }
}
