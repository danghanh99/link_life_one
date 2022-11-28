import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class GetAnken {
  GetAnken() : super();

  Future<dynamic> getAnken(
      {required String JYUCYU_ID, required Function(dynamic) onSuccess}) async {
    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/requestNetConstructionNetPreviewContentsDetails.php?JYUCYU_ID=${JYUCYU_ID}"),
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
