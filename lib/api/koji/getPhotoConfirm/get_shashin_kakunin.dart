import "package:http/http.dart" as http;
import 'dart:convert';

class GetShashinKakunin {
  GetShashinKakunin() : super();

  Future<List<dynamic>> getShashinKakunin({
    required String JYUCYU_ID,
    required String SINGLE_SUMMARIZE,
    required Function(List<dynamic>) onSuccess,
    required Function onFailed,
  }) async {
    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/Request/Koji/requestGetPhotoConfirm.php?JYUCYU_ID=${JYUCYU_ID}&SINGLE_SUMMARIZE=${SINGLE_SUMMARIZE}"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      onSuccess.call(body);
      return body;
    } else {
      onFailed.call();
      throw Exception('Failed to GetShashinKakunin');
    }
  }
}
