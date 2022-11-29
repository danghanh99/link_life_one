import 'dart:convert';

import "package:http/http.dart" as http;
import 'package:intl/intl.dart';

class DeleteMemo {
  DeleteMemo() : super();

  Future<dynamic> deleteMemo(
      {required String JYOKEN_CD,
      required String JYOKEN_SYBET_FLG,
      required DateTime YMD,
      required Function() onSuccess}) async {
    try {
      final response = await http.post(
        Uri.parse("https://koji-app.starboardasiavn.com/requestMemoDelete.php"),
        body: {
          'JYOKEN_CD': JYOKEN_CD,
          'JYOKEN_SYBET_FLG': JYOKEN_SYBET_FLG,
          'YMD': DateFormat(('yyyy-MM-dd')).format(YMD).toString(),
        },
      );

      if (response.statusCode == 200) {
        final dynamic body = jsonDecode(response.body);
        onSuccess.call();
        return body;
      } else {
        throw Exception('Failed to delete list phong ban');
      }
    } catch (e) {
      print(e);
    }
  }
}
