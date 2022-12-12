import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:link_life_one/models/user.dart';

class PostPurchaseOrderApproval {
  PostPurchaseOrderApproval() : super();

  Future<void> postPurchaseOrderApproval({
    required List<dynamic> BUZAI_HACYU_ID_List,
    required Function onSuccess,
    required onFailed,
  }) async {
    try {
      String url =
          "https://koji-app.starboardasiavn.com/Request/Order/requestPostPurchaseOrderApproval.php";
      final response = await http.post(
        Uri.parse(url),
        body: {"BUZAI_HACYU_ID": BUZAI_HACYU_ID_List.toString()}.toString(),
      );
      if (response.statusCode == 200) {
        onSuccess.call();
        return;
      } else {
        onFailed.call();
      }
    } catch (e) {
      onFailed.call();
    }
  }
}
