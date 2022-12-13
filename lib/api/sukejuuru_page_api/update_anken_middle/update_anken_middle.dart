import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:intl/intl.dart';

import '../../../models/user.dart';

class UpdateAnkenMiddle {
  UpdateAnkenMiddle() : super();

  Future<dynamic> updateAnkenMiddle({
    required String YMD,
    required String JYOKEN_CD,
    required String JYOKEN_SYBET_FLG,
    required String TAG_KBN,
    required String START_TIME,
    required String END_TIME,
    required String JININ,
    required String JIKAN,
    required String GUEST_NAME,
    required String ATTEND_NAME1,
    required String ATTEND_NAME2,
    required String ATTEND_NAME3,
    required String ALL_DAY_FLG,
    required String TAN_EIG_ID,
    required String KBNMSAI_CD,
    required String KBN_CD,
    required Function() onSuccess,
    required Function() onFailed,
  }) async {
    final box = Hive.box<User>('userBox');
    final User user = box.values.last;
    final response = await http.post(
        Uri.parse(
            "https://koji-app.starboardasiavn.com/Request/Schedule/requestSalesConstructionSalesPreviewUpdate.php"),
        body: {
          "YMD": YMD,
          "JYOKEN_CD": JYOKEN_CD,
          "JYOKEN_SYBET_FLG": JYOKEN_SYBET_FLG,
          "TAG_KBN": TAG_KBN,
          "START_TIME": START_TIME,
          "END_TIME": END_TIME,
          "JININ": JININ,
          "JIKAN": JIKAN,
          "GUEST_NAME": GUEST_NAME,
          "ATTEND_NAME1": ATTEND_NAME1,
          "ATTEND_NAME2": ATTEND_NAME2,
          "ATTEND_NAME3": ATTEND_NAME3,
          "ALL_DAY_FLG": ALL_DAY_FLG,
          "TAN_EIG_ID": TAN_EIG_ID,
          "KBNMSAI_CD": KBNMSAI_CD,
          "KBN_CD": KBN_CD,
          "LOGIN_ID": user.TANT_CD,
        });

    if (response.statusCode == 200) {
      // final dynamic body = jsonDecode(response.body);
      onSuccess.call();
      // return body;
    } else {
      onFailed.call();
    }
  }
}
