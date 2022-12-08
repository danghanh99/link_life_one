import "package:http/http.dart" as http;
import 'dart:convert';

class GetPartOrderList {
  GetPartOrderList() : super();

  Future<List<dynamic>> getPartOrderList({
    required String SYOZOKU_CD,
    required Function(List<dynamic>) onSuccess,
    required Function onFailed,
  }) async {
    final response = await http.get(
      // Uri.parse(
      //     "https://koji-app.starboardasiavn.com/Request/Order/requestGetPartOrderList.php?SYOZOKU_CD=${SYOZOKU_CD}"),
      Uri.parse(
          "https://koji-app.starboardasiavn.com/Request/Order/requestGetPartOrderList.php?SYOZOKU_CD=80030"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      onSuccess.call(body);
      return body;
    } else {
      onFailed.call();
      return [];
      // throw Exception('Failed to GetPartOrderList');
    }
  }
}
