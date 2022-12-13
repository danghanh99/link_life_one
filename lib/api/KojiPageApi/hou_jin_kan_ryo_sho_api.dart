import "package:http/http.dart" as http;
import 'dart:convert';

import '../../constants/constant.dart';

class HouJinKanRyoShoApi {
  HouJinKanRyoShoApi() : super();

  Future<dynamic> getKojiHoukoku(
      {required String JYUCYU_ID,
      required String TENPO_CD,
      required Function() onSuccess}) async {
    final response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Koji/requestGetCorporateCompletionForm.php?TENPO_CD=$TENPO_CD&JYUCYU_ID=$JYUCYU_ID"),
    );

    if (response.statusCode == 200) {
      final dynamic result = jsonDecode(response.body);
      onSuccess.call();
      return result;
    } else if (response.statusCode == 400) {
      return {'KBN': [], 'FILE': []};
    } else {
      throw Exception('Failed to get list koji');
    }
  }
}
