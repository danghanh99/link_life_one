import 'package:hive_flutter/hive_flutter.dart';
import "package:http/http.dart" as http;
import 'dart:convert';
import '../../constants/constant.dart';
import '../../models/user.dart';

class CheckShowPopupApi {
  CheckShowPopupApi() : super();

  Future<void> checkShowPopup({
    required Function(bool tt) onSuccess,
    required Function onFailed,
  }) async {
    final box = Hive.box<User>('userBox');
    final User user = box.values.last;
    dynamic response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Order/requestCheckInventorySaved.php?SYOZOKU_CD=${user.SYOZOKU_CD}&LOGIN_ID=${user.TANT_CD}"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      onSuccess.call(body.isEmpty);
    } else {
      onFailed.call();
    }
  }
}
