import "package:http/http.dart" as http;
import 'dart:convert';

import '../../constants/constant.dart';

class GetPartOrderList {
  GetPartOrderList() : super();

  Future<List<dynamic>> getPartOrderList({
    required String SYOZOKU_CD,
    required Function onStart,
    required Function(List<dynamic>) onSuccess,
    required Function onFailed,
  }) async {

    onStart();

    final response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Order/requestGetPartOrderList.php?SYOZOKU_CD=${SYOZOKU_CD}"),
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
