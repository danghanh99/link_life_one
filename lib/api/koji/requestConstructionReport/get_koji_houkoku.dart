import "package:http/http.dart" as http;
import 'dart:convert';

import '../../../constants/constant.dart';

class GetKojiHoukoku {
  GetKojiHoukoku() : super();

  Future<dynamic> getKojiHoukoku({
    required String JYUCYU_ID,
    required String SINGLE_SUMMARIZE,
    required String KOJI_ST,
    String? SYUYAKU_JYUCYU_ID,
    required Function(dynamic) onSuccess,
    required Function onFailed,
  }) async {
    String url = '';

    if (KOJI_ST == "01" || KOJI_ST == "02") {
      if (SINGLE_SUMMARIZE == "01") {
        url =
            "${Constant.url}Request/Koji/requestConstructionReport.php?JYUCYU_ID=${JYUCYU_ID}&KOJI_ST=${KOJI_ST}&SINGLE_SUMMARIZE=${SINGLE_SUMMARIZE}";
        // url =
        // "${Constant.url}requestConstructionReport.php?JYUCYU_ID=0301416579&KOJI_ST=1&SINGLE_SUMMARIZE=1";
      } else {
        url =
            "${Constant.url}Request/Koji/requestConstructionReport.php?JYUCYU_ID=${JYUCYU_ID}&KOJI_ST=${KOJI_ST}&SINGLE_SUMMARIZE=${SINGLE_SUMMARIZE}&SYUYAKU_JYUCYU_ID=${SYUYAKU_JYUCYU_ID}";
        //   url =
        // "${Constant.url}requestConstructionReport.php?JYUCYU_ID=0301416579&KOJI_ST=1&SINGLE_SUMMARIZE=2&SYUYAKU_JYUCYU_ID=0301416580";
      }
    } else {
      if (SINGLE_SUMMARIZE == "01") {
        url =
            "${Constant.url}Request/Koji/requestConstructionReport.php?JYUCYU_ID=${JYUCYU_ID}&KOJI_ST=${KOJI_ST}&SINGLE_SUMMARIZE=${SINGLE_SUMMARIZE}";
        //  url =
        // "${Constant.url}requestConstructionReport.php?JYUCYU_ID=0301416579&KOJI_ST=3&SINGLE_SUMMARIZE=1";
      } else {
        url =
            "${Constant.url}Request/Koji/requestConstructionReport.php?JYUCYU_ID=${JYUCYU_ID}&KOJI_ST=${KOJI_ST}&SINGLE_SUMMARIZE=${SINGLE_SUMMARIZE}&SYUYAKU_JYUCYU_ID=${SYUYAKU_JYUCYU_ID}";
        //    url =
        // "${Constant.url}requestConstructionReport.php?JYUCYU_ID=0301416579&KOJI_ST=3&SINGLE_SUMMARIZE=2&SYUYAKU_JYUCYU_ID=0301416580";
      }
    }

    final response = await http.get(
      Uri.parse(url),
    );

    if (response.statusCode == 200) {
      final dynamic body = jsonDecode(response.body);
      onSuccess.call(body);
      return body;
    } else {
      onFailed.call();
    }
  }
}
