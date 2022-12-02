import 'package:hive_flutter/hive_flutter.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:link_life_one/models/koji.dart';
import 'dart:convert';

class GetShoudakusho {
  GetShoudakusho() : super();

  Future<List<dynamic>> getShoudakusho({
    required String JYUCYU_ID,
    required String KOJI_ST,
    required Function(dynamic) onSuccess,
    required Function onFailed,
  }) async {
    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/requestGetWrittenConsent.php?JYUCYU_ID=0301416579&KOJI_ST=03"),
      // Uri.parse(
      //     "https://koji-app.starboardasiavn.com/requestGetWrittenConsent.php?JYUCYU_ID=${JYUCYU_ID}&KOJI_ST=${KOJI_ST}"),
    );

    if (response.statusCode == 200) {
      final dynamic body = jsonDecode(response.body);
      onSuccess.call(body);
      return body;
    } else {
      onFailed.call();
      throw Exception('Failed to GetShoudakusho');
    }
  }
}
