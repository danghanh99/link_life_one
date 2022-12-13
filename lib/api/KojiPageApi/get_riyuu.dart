import "package:http/http.dart" as http;
import 'dart:convert';

import '../../constants/constant.dart';

class GetRiyuu {
  GetRiyuu() : super();

  Future<dynamic> getRiyuu(
      {required String JYUCYU_ID, required Function() onSuccess}) async {
    final response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Koji/requestEnterReason.php?JYUCYU_ID=$JYUCYU_ID"),
    );

    if (response.statusCode == 200) {
      final dynamic result = jsonDecode(response.body);
      onSuccess.call();
      return result;
    } else {
      throw Exception('Failed to get list koji');
    }
  }
}
