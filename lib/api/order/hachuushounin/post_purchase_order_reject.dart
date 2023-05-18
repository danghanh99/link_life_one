import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:link_life_one/models/user.dart';

import '../../../constants/constant.dart';

class PostPurchaseOrderReject {
  PostPurchaseOrderReject() : super();

  Future<void> postPurchaseOrderReject({
    required List<dynamic> BUZAI_HACYU_ID_List,
    required Function onSuccess,
    required onFailed,
  }) async {
    try {
      String url =
          "${Constant.url}Request/Order/requestPostPurchaseOrderReject.php";
      final response = await http.post(
        Uri.parse(url),
        body: json.encode({"BUZAI_HACYU_ID": BUZAI_HACYU_ID_List}),
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
