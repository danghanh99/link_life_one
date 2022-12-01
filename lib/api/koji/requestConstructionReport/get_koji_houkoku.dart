import 'package:hive_flutter/hive_flutter.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:link_life_one/models/koji.dart';
import 'dart:convert';

class GetKojiHoukoku {
  GetKojiHoukoku() : super();

  Future<dynamic> getKojiHoukoku({
    required String JYUCYU_ID,
    required String SINGLE_SUMMARIZE,
    required String KOJI_ST,
    String? SYUYAKU_JYUCYU_ID,
    required Function(dynamic) onSuccess,
    required Function onFailed,
  }) async {
    String? syuyakuJyucyuId =
        SINGLE_SUMMARIZE == "02" ? SYUYAKU_JYUCYU_ID : null;
    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/requestConstructionReport.php?JYUCYU_ID=${JYUCYU_ID}&KOJI_ST=${KOJI_ST}&SINGLE_SUMMARIZE=${SINGLE_SUMMARIZE}&SYUYAKU_JYUCYU_ID=${syuyakuJyucyuId}"),
    );

    if (response.statusCode == 200) {
      final dynamic body = jsonDecode(response.body);
      onSuccess.call(body);
      return body;
    } else {
      onFailed.call();
      throw Exception('Failed to GetShashinKakunin');
    }
  }
}
