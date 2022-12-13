import "package:http/http.dart" as http;
import 'dart:convert';

import '../../constants/constant.dart';

class GetQR {
  GetQR() : super();

  Future<List<dynamic>> getQrApi({
    required Function(List<dynamic>) onSuccess,
    required Function onFailed,
  }) async {
    final response = await http.get(
      Uri.parse("${Constant.url}Request/Order/requestGetQR.php"),
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
