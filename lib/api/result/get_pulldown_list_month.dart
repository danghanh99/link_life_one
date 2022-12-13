import "package:http/http.dart" as http;
import 'package:link_life_one/models/month.dart';
import 'dart:convert';

import '../../constants/constant.dart';

class GetPullDownListMonth {
  GetPullDownListMonth() : super();

  Future<void> getPullDownListMonth({
    required String TANT_CD,
    required Function(List<Month> list) onSuccess,
    required Function onFailed,
  }) async {
    final response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Result/requestGetPullDownListMoth.php?TANT_CD=$TANT_CD"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      final List<Month> list = body.map((e) {
        return Month.fromJson(e);
      }).toList();
      onSuccess.call(list);
    } else {}
  }
}
