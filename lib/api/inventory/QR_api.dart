import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'package:link_life_one/models/inventory.dart';
import 'dart:convert';

import '../../constants/constant.dart';
import '../../models/user.dart';

class QRApi {
  QRApi() : super();

  Future<void> getQRApi({
    required String hinban,
    required Function(List<Inventory> list) onSuccess,
    required Function onFailed,
  }) async {
    final box = Hive.box<User>('userBox');
    final User user = box.values.last;
    final dynamic response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Order/requestGetQRInventoryList.php?SYOZOKU_CD=${user.SYOZOKU_CD}&HINBAN=$hinban"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      // final dynamic body = jsonDecode(response.body);
      onSuccess.call(body.map((e) => Inventory.fromJson(e)).toList());
    } else {
      onFailed.call();
    }
  }
}
