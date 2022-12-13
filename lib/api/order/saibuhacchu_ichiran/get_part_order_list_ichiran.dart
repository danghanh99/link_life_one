import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

import '../../../models/user.dart';

class GetPartOrderListIchiran {
  GetPartOrderListIchiran() : super();

  Future<List<dynamic>> getPartOrderListIchiran({
    required Function(List<dynamic>) onSuccess,
    required Function onFailed,
  }) async {
    final box = Hive.box<User>('userBox');
    final User user = box.values.last;
    String SYOZOKU_CD = user.SYOZOKU_CD;

    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/Request/Order/requestGetPartOrderList.php?SYOZOKU_CD=${SYOZOKU_CD}"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      onSuccess.call(body);
      return body;
    } else {
      onFailed.call();
      return [];
      // throw Exception('Failed to GetPartOrderList');
    }
  }
}
