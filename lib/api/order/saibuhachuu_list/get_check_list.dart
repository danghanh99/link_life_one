import "package:http/http.dart" as http;
import 'dart:convert';

import '../../../constants/constant.dart';

class GetCheckList {
  GetCheckList() : super();

  Future<List<dynamic>> getCheckList({
    required String BUZAI_HACYU_ID,
    required Function onStart,
    required Function(List<dynamic>) onSuccess,
    required Function onFailed,
  }) async {

    onStart();

    final response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Order/requestGetCheckList.php?BUZAI_HACYU_ID=$BUZAI_HACYU_ID"),
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
