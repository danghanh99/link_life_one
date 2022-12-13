import "package:http/http.dart" as http;
import 'dart:convert';

import '../../constants/constant.dart';

class GetShoudakusho {
  GetShoudakusho() : super();

  Future<dynamic> getShoudakusho({
    required String JYUCYU_ID,
    required String KOJI_ST,
    required Function(dynamic) onSuccess,
    required Function onFailed,
  }) async {
    final response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Koji/requestGetWrittenConsent.php?JYUCYU_ID=0301416579&KOJI_ST=03"),
      // Uri.parse(
      //     "${Constant.url}requestGetWrittenConsent.php?JYUCYU_ID=${JYUCYU_ID}&KOJI_ST=${KOJI_ST}"),
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
