import 'dart:convert';
import "package:http/http.dart" as http;

class DeleteMemo {
  DeleteMemo() : super();

  Future<dynamic> deleteMemo(
      {required String TAN_CAL_ID,
      required Function() onSuccess,
      required Function onFailed}) async {
    try {
      final response = await http.post(
          Uri.parse(
              "https://koji-app.starboardasiavn.com/Request/Schedule/requestPostMemoDelete.php"),
          body: {'TAN_CAL_ID': TAN_CAL_ID});

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
}
