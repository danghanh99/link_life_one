import "package:http/http.dart" as http;
import 'dart:convert';

import '../../../../constants/constant.dart';

class GetPullDownAnken {
  GetPullDownAnken() : super();

  Future<dynamic> getSalesConstructionSalesPreviewContents({
    required Function(dynamic) onSuccess,
    required Function() onFailed,
  }) async {
    final response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Schedule/requestSalesConstructionSalesPreviewContents.php?TAN_EIG_ID="),
    );

    if (response.statusCode == 200) {
      final dynamic body = jsonDecode(response.body);
      onSuccess.call(body);
      return body;
    } else {
      onFailed.call();
    }
  }
}
