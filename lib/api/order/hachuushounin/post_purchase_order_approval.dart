import 'dart:convert';

import 'package:hive_flutter/adapters.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:link_life_one/models/user.dart';

import '../../../constants/constant.dart';

class PostPurchaseOrderApproval {
  PostPurchaseOrderApproval() : super();

  Future<void> postPurchaseOrderApproval({
    required List<dynamic> BUZAI_HACYU_ID_List,
    required String note,
    required Function onSuccess,
    required onFailed,
  }) async {
    try {

      final box = Hive.box<User>('userBox');
      final User user = box.values.last;

      String url =
          "${Constant.url}Request/Order/requestPostPurchaseOrderApproval.php";

      List<dynamic> buzaiHacyu = [];
      for(var item in BUZAI_HACYU_ID_List){
        buzaiHacyu.add({
          "BUZAI_HACYU_ID": item,
          "HACNG_RIYU": note
        });
      }

      Map<String, dynamic> body = {
        "LOGIN_ID": user.TANT_CD,
        "BUZAI_HACYU": buzaiHacyu
      };

      final response = await http.post(
        Uri.parse(url),
        body: json.encode(body),
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
