import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:intl/intl.dart';

import '../../../../constants/constant.dart';

class GetLichTrinhItem {
  GetLichTrinhItem() : super();

  Future<dynamic> getLichTrinhItem({
    required String JYUCYU_ID,
    required String HOMON_SBT, // vd: 02
    required Function(dynamic) onSuccess,
  }) async {
    final response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Schedule/requestGetNetPreviewContents.php?JYUCYU_ID=${JYUCYU_ID}&HOMON_SBT=${HOMON_SBT}"),
    );

    if (response.statusCode == 200) {
      final dynamic body = jsonDecode(response.body);
      onSuccess.call(body);
      return body;
    } else {
      throw Exception('Failed to getLichTrinhItem');
    }
  }
}
