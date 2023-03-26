import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';

import '../../../constants/constant.dart';
import '../../../models/user.dart';

class CreateMemo {
  CreateMemo() : super();

  Future<dynamic> createMemo(
      {required String JYOKEN_CD,
      required String JYOKEN_SYBET_FLG,
      required DateTime YMD,
      required String KBNMSAI_CD,
      String? TAG_KBN,
      String? NAIYO,
      String? START_TIME,
      String? END_TIME,
      String? ALL_DAY_FLG,
      String? MEMO_CD,
      String? TAN_CAL_ID,
      required Function() onSuccess,
      required Function onFailed}) async {
    try {
      final box = Hive.box<User>('userBox');
      final User user = box.values.last;
      Map<String, dynamic> body = {
          'JYOKEN_CD': JYOKEN_CD,
          'JYOKEN_SYBET_FLG': JYOKEN_SYBET_FLG,
          'YMD': DateFormat(('yyyy-MM-dd')).format(YMD).toString(),
          'TAG_KBN': TAG_KBN,
          'NAIYO': NAIYO ?? '',
          'START_TIME': START_TIME ?? '',
          'END_TIME': END_TIME ?? '',
          'ALL_DAY_FLG': ALL_DAY_FLG,
          'MEMO_CD': MEMO_CD,
          'COMMENT': '',
          'KBNMSAI_CD': KBNMSAI_CD,
          'LOGIN_ID': user.TANT_CD,
          'TANT_CAL_ID': TAN_CAL_ID ?? ''
        };
      final response = await http.post(
        Uri.parse("${Constant.url}Request/Schedule/requestPostMemoUpdate.php"),
        body: body,
      );

      if (response.statusCode == 200) {
        final dynamic body = jsonDecode(response.body);
        onSuccess.call();
        return body;
      } else {
        onFailed.call();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> pullDownMemo({
    required String TAN_CAL_ID,
    required Function() onSuccess,
    required Function() onFailed,
  }) async {
    try {
      String url =
          "${Constant.url}Request/Schedule/requestGetMemoRegistration.php?TAN_CAL_ID=$TAN_CAL_ID";
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final dynamic body = jsonDecode(response.body);
        onSuccess.call();
        return body;
      } else {
        onFailed.call();
        // throw Exception('Failed to get list phong ban');
      }
    } catch (e) {
      print(e);
    }
  }
}
