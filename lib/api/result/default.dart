import "package:http/http.dart" as http;
import 'dart:convert';
import 'package:link_life_one/models/thanh_tich.dart';

class Default {
  Default() : super();

  Future<void> getDefault({
    required String TANT_CD,
    required String JISEKI_YMD,
    required Function(List<ThanhTich> list) onSuccess,
    required Function onFailed,
  }) async {
    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/Request/Result/requestDefault.php?TANT_CD=$TANT_CD&JISEKI_YMD=$JISEKI_YMD"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      final List<ThanhTich> list = body.map((e) {
        return ThanhTich.fromJson(e);
      }).toList();
      onSuccess.call(list);
    } else {}
  }
}
