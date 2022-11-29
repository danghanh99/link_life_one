import "package:http/http.dart" as http;
import 'dart:convert';

class GetPullDownAnken {
  GetPullDownAnken() : super();

  Future<dynamic> getPullDownAnken(
      {required Function(dynamic) onSuccess}) async {
    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/requestSalesConstructionSalesPreviewContents.php?TAN_EIG_ID="),
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
