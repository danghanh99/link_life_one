import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'dart:convert';

class ShowPopUp {
  ShowPopUp() : super();

  Future<int> isShowPopup(
      {required DateTime YMD,
      required String SETSAKI_ADDRESS,
      required String JYUCYU_ID,
      required Function(int count) onSuccess}) async {
    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/requestCheckCount.php?YMD=${DateFormat(('yyyy-MM-dd')).format(YMD)}&SETSAKI_ADDRESS=${SETSAKI_ADDRESS}&JYUCYU_ID=${JYUCYU_ID}"),
    );

    if (response.statusCode == 200) {
      final int count = jsonDecode(response.body);
      onSuccess.call(count);
      return count;
    } else {
      throw Exception('Failed to get list koji');
    }
  }
}
