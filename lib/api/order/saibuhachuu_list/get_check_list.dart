import "package:http/http.dart" as http;
import 'dart:convert';

class GetCheckList {
  GetCheckList() : super();

  Future<List<dynamic>> getCheckList({
    required String BUZAI_HACYU_ID,
    required Function(List<dynamic>) onSuccess,
    required Function onFailed,
  }) async {
    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/Request/Order/requestGetCheckList.php?BUZAI_HACYU_ID=0000000001"),
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
