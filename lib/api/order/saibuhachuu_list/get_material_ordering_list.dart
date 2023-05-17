import "package:http/http.dart" as http;
import 'dart:convert';

import '../../../constants/constant.dart';

class GetMaterialOrderingList {
  GetMaterialOrderingList() : super();

  Future<List<dynamic>> getMaterialOrderingList({
    required String SYOZOKU_CD,
    required String? JISYA_CD,
    required Function(List<dynamic>) onSuccess,
    required Function onFailed,
  }) async {
    final response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Order/requestGetMaterialOrderingList.php?SYOZOKU_CD=$SYOZOKU_CD${JISYA_CD==null ? '' : '&JISYA_CD=$JISYA_CD'}"),
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
