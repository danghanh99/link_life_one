import "package:http/http.dart" as http;
import 'dart:convert';

class GetAnkenDetail {
  GetAnkenDetail() : super();

  Future<dynamic> getAnkenDetail({
    required Function(dynamic) onSuccess,
    required String TAN_EIG_ID,
  }) async {
    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/Request/Schedule/requestSalesConstructionSalesPreviewContents.php?TAN_EIG_ID=${TAN_EIG_ID}"),
    );

    if (response.statusCode == 200) {
      final dynamic body = jsonDecode(response.body);
      onSuccess.call(body);
      return body;
    } else {
      throw Exception('Failed to getAnken');
    }
  }
}
