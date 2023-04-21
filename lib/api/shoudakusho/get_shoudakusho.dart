
import "package:http/http.dart" as http;
import 'package:link_life_one/local_storage_services/local_storage_services.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';
import 'dart:convert';

import '../../constants/constant.dart';

class GetShoudakusho {
  GetShoudakusho() : super();

  Future<dynamic> _notSuccess({
    required String jyucyuId,
    required String kojiSt,
    required Function(dynamic) onSuccess,
    required Function onFailed
  }) async {
    if(await LocalStorageServices.isTodayDataDownloaded()){
      var res = await LocalStorageServices().getWrittenConsent(
          jyucyuId: jyucyuId,
          kojiSt: kojiSt
      );
      onSuccess.call(res);
      return res;
    }
    else{
      onFailed.call();
      throw Exception('Failed to GetShoudakusho');
    }
  }

  Future<dynamic> getShoudakusho({
    required String JYUCYU_ID,
    required String KOJI_ST,
    required Function(dynamic) onSuccess,
    required Function onFailed,
  }) async {

    if(LocalStorageNotifier.isOfflineMode && LocalStorageNotifier.isChoosenToday){
      return _notSuccess(
          jyucyuId: JYUCYU_ID,
          kojiSt: KOJI_ST,
          onSuccess: onSuccess,
          onFailed: onFailed
      );
    }

    try{
      final response = await http.get(Uri.parse(
          "${Constant.url}Request/Koji/requestGetWrittenConsent.php?JYUCYU_ID=$JYUCYU_ID&KOJI_ST=$KOJI_ST"));

      if (response.statusCode == 200) {
        final dynamic body = jsonDecode(response.body);
        onSuccess.call(body);
        return body;
      } else {
        onFailed.call();
        throw Exception('Failed to GetShoudakusho');
      }
    } catch(e){
      onFailed.call();
      throw Exception('Failed to GetShoudakusho');
    }
  }
}
