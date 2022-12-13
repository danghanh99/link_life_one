import 'package:hive_flutter/hive_flutter.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

import '../../constants/constant.dart';

class GetThongBaoMenuApi {
  GetThongBaoMenuApi() : super();

  Future<dynamic> getThongBaoMenuApi({
    required Function(dynamic) onSuccess,
  }) async {
    final box = Hive.box<String>('user');
    final id = box.values.last;

    final response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Menu/requestGetMenu.php?LOGIN_ID=${id}"),
    );

    if (response.statusCode == 200) {
      final dynamic body = jsonDecode(response.body);
      onSuccess.call(body);
      return body;
    } else {
      throw Exception('Failed to get list koji');
    }
  }
}
