import 'package:hive_flutter/hive_flutter.dart';
import "package:http/http.dart" as http;
import 'package:link_life_one/models/inventory.dart';
import 'dart:convert';
import '../../constants/constant.dart';
import '../../models/user.dart';

class GetInventoriesApi {
  GetInventoriesApi() : super();

  Future<void> getInventories({
    required bool isContinue,
    required Function(List<Inventory> list) onSuccess,
    required Function onFailed,
  }) async {
    final box = Hive.box<User>('userBox');
    final User user = box.values.last;
    String SYOZOKU_CD = user.SYOZOKU_CD;
    dynamic response;
    if (isContinue) {
      response = await http.get(
        Uri.parse(
            "${Constant.url}Request/Order/requestGetInventoryListWithSaved.php?SYOZOKU_CD=${user.SYOZOKU_CD}&LOGIN_ID=${user.TANT_CD}"),
      );
    } else {
      response = await http.get(
        Uri.parse(
            "${Constant.url}Request/Order/requesGetInventoryListWithoutSaved.php?SYOZOKU_CD=${user.SYOZOKU_CD}"),
      );
    }

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      final List<Inventory> list = body.map((e) {
        return Inventory.fromJson(e);
      }).toList();
      onSuccess.call(list);
    } else {
      onFailed.call();
    }
  }
}
