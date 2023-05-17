import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:link_life_one/models/user.dart';

import '../../constants/constant.dart';

class CheckOrderSave {
  CheckOrderSave() : super();

  Future<List<dynamic>> checkOrderSave({
    required Function(bool) onSuccess,
    required Function onFailed,
  }) async {
    final userBox = await Hive.openBox<User>('userBox');
    String SYOZOKU_CD = userBox.values.last.SYOZOKU_CD;
    final response = await http.get(
      Uri.parse(
          "${Constant.url}/Request/Order/requestGetCheckBuzaihacyumsaiSave.php?SYOZOKU_CD=$SYOZOKU_CD"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      print('m: '+body[0]['message']);
      onSuccess.call((body[0]['message'] as String)!='Data not found');
      return body;
    } else {
      onFailed.call();
      return [];
    }
  }
}
