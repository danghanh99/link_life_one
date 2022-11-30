import 'package:hive_flutter/hive_flutter.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:link_life_one/models/koji.dart';
import 'dart:convert';

class GetShashinKakunin {
  GetShashinKakunin() : super();

  Future<List<dynamic>> getShashinKakunin({
    required String JYUCYU_ID,
    required String SINGLE_SUMMARIZE,
    required Function(List<dynamic>) onSuccess,
    required Function onFailed,
  }) async {
    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/requestGetPhotoConfirm.php?JYUCYU_ID=0301416579&SINGLE_SUMMARIZE=02"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      onSuccess.call(body);
      return body;
    } else {
      onFailed.call();
      throw Exception('Failed to GetShashinKakunin');
    }
  }
}
