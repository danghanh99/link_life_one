import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'dart:convert';

import '../../../constants/constant.dart';
import '../../../models/user.dart';

class GetPurchaseOrderApproval {
  GetPurchaseOrderApproval() : super();

  Future<List<dynamic>> getPurchaseOrderApproval({
    required String BUZAI_HACYU_ID,
    required Function(List<dynamic>) onSuccess,
    required Function onFailed,
  }) async {
    try {
      final response = await http.get(
        Uri.parse(
            "${Constant.url}Request/Order/requestGetPurchaseOrderApproval.php?BUZAI_HACYU_ID=${BUZAI_HACYU_ID}"),
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
    } catch (e) {
      onFailed.call();
      return [];
    }
  }
}
