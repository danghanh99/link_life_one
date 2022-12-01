import "package:http/http.dart" as http;
import 'package:link_life_one/models/koji.dart';
import 'dart:convert';

class GetListPdf {
  GetListPdf() : super();

  Future<List<dynamic>> getListPdf(
      {required Koji koji, required String SINGLE_SUMMARIZE}) async {
    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/requestRequestForm.php?JYUCYU_ID=${koji.jyucyuId}&SINGLE_SUMMARIZE=$SINGLE_SUMMARIZE&HOMON_SBT=${koji.homonSbt}"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> list = jsonDecode(response.body);
      return list;
    } else if(response.statusCode == 400) {
      return [];
    }
    else {
      throw Exception('Failed to get list koji');
    }
  }
}
