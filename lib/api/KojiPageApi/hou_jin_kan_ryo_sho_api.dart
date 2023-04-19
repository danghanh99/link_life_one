import "package:http/http.dart" as http;
import 'package:link_life_one/local_storage_services/local_storage_services.dart';
import 'dart:convert';

import '../../constants/constant.dart';

class HouJinKanRyoShoApi {
  HouJinKanRyoShoApi() : super();

  Future<dynamic> _notSuccess({
    required jyucyuId,
    required tenpoCd,
    required Function() onSuccess
  }) async {
    if(await LocalStorageServices.isTodayDataDownloaded()){
      var res = await LocalStorageServices().getCorporateCompletion(jyucyuId: jyucyuId, tenpoCd: tenpoCd);
      onSuccess.call();
      return res;
    }
    else{
      throw Exception('Failed to get list');
    }
  }

  Future<dynamic> getKojiHoukoku(
      {required String JYUCYU_ID,
      required String TENPO_CD,
      required Function() onSuccess}) async {
    try{
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
        return _notSuccess(
            jyucyuId: JYUCYU_ID,
            tenpoCd: TENPO_CD,
            onSuccess: onSuccess
        );
      }
    } catch(e){
      return _notSuccess(
          jyucyuId: JYUCYU_ID,
          tenpoCd: TENPO_CD,
          onSuccess: onSuccess
      );
    }
  }
}
