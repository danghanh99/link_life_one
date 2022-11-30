import "package:http/http.dart" as http;
import 'package:link_life_one/models/koji.dart';
import 'dart:convert';

class GetListPdf {
  GetListPdf() : super();

  Future<List<dynamic>> getListPdf(
      {required Koji koji, required String SINGLE_SUMMARIZE}) async {
    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/requestRequestForm.php?JYUCYU_ID=0301416579&SINGLE_SUMMARIZE=01&HOMON_SBT=02"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> list = jsonDecode(response.body);
      return list;
    } else {
      throw Exception('Failed to get list koji');
    }
  }
}
