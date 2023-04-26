import "package:http/http.dart" as http;
import 'package:link_life_one/local_storage_services/local_storage_services.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';
import 'dart:convert';

import '../../../constants/constant.dart';

class GetKojiHoukoku {
  GetKojiHoukoku() : super();

  Future<dynamic> _notSuccess({
    required String jyucyuId,
    required String singleSummarize,
    required String kojiSt,
    String? syuyakuJyucyuId,
    required Function(dynamic) onSuccess,
    required Function onFailed
  }) async {
    if(await LocalStorageServices.isTodayDataDownloaded()){
      var res = await LocalStorageServices().getConstructionReport(
          jyucyuId: jyucyuId,
          kojiSt: kojiSt,
          singleSummarize: singleSummarize,
          syuyakuJyucyuId: syuyakuJyucyuId
      );
      onSuccess.call(res);
      return res;
    }
    else{
      onFailed.call();
    }
  }

  Future<dynamic> getKojiHoukoku({
    required String JYUCYU_ID,
    required String SINGLE_SUMMARIZE,
    required String KOJI_ST,
    String? SYUYAKU_JYUCYU_ID,
    required Function(dynamic) onSuccess,
    required Function onFailed,
  }) async {

    bool isOnline = await LocalStorageNotifier.isOnline();

    if(!isOnline && LocalStorageNotifier.isTodayDownload()){
      return _notSuccess(
          jyucyuId: JYUCYU_ID,
          singleSummarize: SINGLE_SUMMARIZE,
          kojiSt: KOJI_ST,
          onSuccess: onSuccess,
          onFailed: onFailed
      );
    }

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

    try{

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

    } catch(e){
      onFailed.call();
    }



  }
}
