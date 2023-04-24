import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'package:link_life_one/components/toast.dart';
import 'dart:convert';

import '../../constants/constant.dart';
import '../../models/user.dart';

class GetListPhongBan {
  GetListPhongBan() : super();

  Future<List<dynamic>> getListPhongBan({
    required Function(List<dynamic>) onSuccess,
    required Function onFailed,
  }) async {
    final box = Hive.box<User>('userBox');
    final User user = box.values.last;
    String SYOZOKU_CD = user.SYOZOKU_CD;
    String TANT_KBN_CD = user.TANT_KBN_CD;
    final response = await http.get(
      Uri.parse(
          "${Constant.url}/Request/Schedule/requestGetListOffice.php?SYOZOKU_CD=${SYOZOKU_CD}&TANT_KBN_CD=${TANT_KBN_CD}"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      onSuccess.call(body);
      return body;
    } else {
      onFailed.call();
      return [];
      // throw Exception('Failed to get list phong ban');
    }
  }
}
