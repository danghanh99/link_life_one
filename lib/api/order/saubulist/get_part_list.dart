import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:link_life_one/models/user.dart';

import '../../../constants/constant.dart';

class GetPartList {
  GetPartList() : super();

  Future<List<dynamic>> getPartList({
    String? bunrui = '',
    String? markerName = '',
    String? hinban = '',
    String? syohinName = '',
    required Function(List<dynamic>) onSuccess,
    required Function onFailed,
  }) async {
    final userBox = await Hive.openBox<User>('userBox');
    String SYOZOKU_CD = userBox.values.last.SYOZOKU_CD;

    final response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Order/requestGetPartList.php?SYOZOKU_CD=$SYOZOKU_CD&BUZAI_BUNRUI=$bunrui&HINBAN=$hinban&MAKER_NAME=$markerName&SYOHIN_NAME=$syohinName"),
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

  Future<List<dynamic>> getPartList2({
    String? bunrui,
    String? markerName,
    String? hinban,
    String? syohinName,
    String? jisyaCd,
    required Function(List<dynamic>) onSuccess,
    required Function onFailed,
  }) async {
    final userBox = await Hive.openBox<User>('userBox');
    String SYOZOKU_CD = userBox.values.last.SYOZOKU_CD;

    final response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Order/requestGetPartList2.php?SYOZOKU_CD=$SYOZOKU_CD&BUZAI_BUNRUI=${bunrui ?? ''}&MAKER_NAME=${markerName ?? ''}&HINBAN=${hinban ?? ''}&SYOHIN_NAME=${syohinName ?? ''}&JISYA_CD=${jisyaCd ?? ''}"),
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
