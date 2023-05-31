import 'package:hive/hive.dart';
import "package:http/http.dart" as http;
import 'package:link_life_one/models/user.dart';
import 'dart:convert';

import '../../../constants/constant.dart';

class MaterialOrderingList {
  MaterialOrderingList() : super();

  Future<List<dynamic>> getMaterialOrderingList({
    String? jisyaCd,
    required Function onStart,
    required Function(List<dynamic>) onSuccess,
    required Function onFailed,
  }) async {

    onStart();

    final box = Hive.box<User>('userBox');
    final User user = box.values.last;

    final response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Order/requestGetMaterialOrderingList.php?SYOZOKU_CD=${user.TANT_CD}${jisyaCd == null ? '' : '&JISYA_CD=$jisyaCd'}"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      onSuccess.call(body);
      return body;
    } else {
      onFailed.call();
      return [];
    }
  }

}
