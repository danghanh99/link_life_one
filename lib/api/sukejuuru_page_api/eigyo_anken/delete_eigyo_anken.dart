import "package:http/http.dart" as http;
import 'dart:convert';

import '../../../../constants/constant.dart';

class DeleteEigyoAnken {
  DeleteEigyoAnken() : super();

  Future<void> deleteEigyoAnken({
    required Function() onSuccess,
    required Function() onFailed,
    required String TAN_EIG_ID,
  }) async {
    try {
      final response = await http.post(
          Uri.parse(
              "${Constant.url}Request/Schedule/requestPostSalesConstructionSalesPreviewDelete.php"),
          body: {
            "TAN_EIG_ID": TAN_EIG_ID,
          });

      if (response.statusCode == 200) {
        onSuccess.call();
      } else {
        onFailed.call();
      }
    } catch (e) {
      onFailed.call();
    }
  }
}
