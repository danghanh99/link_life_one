import "package:http/http.dart" as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class PostUpdateKojiReadFlg {
  PostUpdateKojiReadFlg() : super();

  Future<void> postUpdateKojiReadFlg(
      {required List<dynamic> listJYUCYU_ID,
      required Function() onSuccess}) async {
    final response = await http.post(
        Uri.parse(
            "https://koji-app.starboardasiavn.com/requestPostUpdateKojiReadFlg.php"),
        body: {
          "JYUCYU_ID": listJYUCYU_ID.toString(),
        });

    if (response.statusCode == 200) {
      onSuccess.call();
    } else {
      throw Exception('Failed to getAnken');
    }
  }
}
