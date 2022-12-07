import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class GetLichTrinhItemEditPage {
  GetLichTrinhItemEditPage() : super();

  Future<dynamic> getLichTrinhItemEditPage({
    required String JYUCYU_ID,
    required String HOMON_SBT, // vd: 02
    required Function(dynamic) onSuccess,
  }) async {
    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/Request/Schedule/requestNetConstructionNetPreviewContentsDetails.php?JYUCYU_ID=${JYUCYU_ID}&HOMON_SBT=${HOMON_SBT}"),
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
