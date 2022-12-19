import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:intl/intl.dart';

import '../../../../constants/constant.dart';
import '../../../../models/user.dart';

class UpdateLichTrinh {
  UpdateLichTrinh() : super();

  Future<dynamic> updateLichTrinh({
    required String JYUCYU_ID,
    required String TAG_KBN,
    required String KBN,
    required String JIKAN_START,
    required String JIKAN_END,
    required String JININ,
    required String KANSAN_POINT,
    required String ALL_DAY_FLG,
    required String MEMO,
    required String HOMON_SBT,
    required String KBN_CD,
    required String KBNMSAI_CD,
    required String JIKAN,
    required Function() onSuccess,
    required Function() onFailed,
  }) async {
    final box = Hive.box<User>('userBox');
    final User user = box.values.last;
    final response = await http.post(
        Uri.parse(
            "${Constant.url}Request/Schedule/requestNetConstructionNetPreviewContentsUpdate.php"),
        body: {
          "JYUCYU_ID": JYUCYU_ID,
          "TAG_KBN": TAG_KBN,
          "KBN": KBN, // appoint check
          "HOMONJIKAN": JIKAN_START, // kara
          "HOMONJIKAN_END": JIKAN_END, // made
          "JININ": JININ,
          "KANSAN_POINT":
              KANSAN_POINT == "1" || KANSAN_POINT == "01" ? "1" : "0", // k biet
          "ALL_DAY_FLG": ALL_DAY_FLG, // check all day
          "MEMO": MEMO,
          "HOMON_SBT": HOMON_SBT,
          // "KBN_CD": KBN_CD,
          "KBNMSAI_CD": KBNMSAI_CD,
          "JIKAN": JIKAN,
          "LOGIN_ID": user.TANT_CD,
        });

    if (response.statusCode == 200) {
      // final dynamic body = jsonDecode(response.body);
      onSuccess.call();
      // return body;
    } else {
      // throw Exception('Failed to getAnken');
      onFailed.call();
    }
  }
}
