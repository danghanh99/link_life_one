import "package:http/http.dart" as http;
import 'package:link_life_one/models/people.dart';
import 'dart:convert';

import '../../constants/constant.dart';

class GetPullDownListPeople {
  GetPullDownListPeople() : super();

  Future<void> getPullDownListPeople({
    required Function(List<People> list) onSuccess,
  }) async {
    final response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Result/requestGetPullDownListPeople.php"),
    );

    if (response.statusCode == 200) {
      final List<dynamic> body = jsonDecode(response.body);
      final List<People> list = body.map((e) {
        return People.fromJson(e);
      }).toList();
      onSuccess.call(list);
    } else {}
  }
}
