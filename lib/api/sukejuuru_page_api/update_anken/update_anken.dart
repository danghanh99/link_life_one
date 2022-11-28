import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class UpdateAnken {
  UpdateAnken() : super();

  Future<dynamic> updateAnken(
      {required String JYUCYU_ID,
      required String TAG_KBN,
      required String KBN,
      required String JIKAN,
      required String JIKAN_END,
      required String JININ,
      required String KANSAN_POINT,
      required String ALL_DAY_FLG,
      required String MEMO,
      required Function() onSuccess}) async {
    final response = await http.post(
        Uri.parse(
            "https://koji-app.starboardasiavn.com/requestNetConstructionNetPreviewContentsUpdate.php"),
        body: {
          "JYUCYU_ID": JYUCYU_ID,
          "TAG_KBN": TAG_KBN,
          "KBN": KBN, // appoint check
          "JIKAN": JIKAN, // kara
          "JIKAN_END": JIKAN_END, // made
          "JININ": JININ,
          "KANSAN_POINT": KANSAN_POINT, // k biet
          "ALL_DAY_FLG": ALL_DAY_FLG, // check all day
          "MEMO": MEMO,
        });

    if (response.statusCode == 200) {
      // final dynamic body = jsonDecode(response.body);
      onSuccess.call();
      // return body;
    } else {
      throw Exception('Failed to getAnken');
    }
  }
}
