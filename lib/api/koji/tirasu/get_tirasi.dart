import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import '../../../models/user.dart';

class GetTirasi {
  GetTirasi() : super();

  Future<void> getTirasi({
    required DateTime YMD,
    required Function(dynamic) onSuccess,
    required Function onFailed,
  }) async {
    final userBox = await Hive.openBox<User>('userBox');
    String LOGIN_ID = userBox.values.last.TANT_CD;

    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/Request/Koji/requestGetTirasi.php?YMD=${DateFormat(('yyyy-MM-dd')).format(YMD)}&LOGIN_ID=${LOGIN_ID}"),
    );

    if (response.statusCode == 200) {
      final dynamic body = jsonDecode(response.body);
      onSuccess.call(body);
    } else {
      onFailed.call();
    }
  }
}
