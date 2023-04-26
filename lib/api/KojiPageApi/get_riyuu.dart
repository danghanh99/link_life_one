import "package:http/http.dart" as http;
import 'package:link_life_one/local_storage_services/local_storage_services.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';
import 'dart:convert';

import '../../constants/constant.dart';

class GetRiyuu {
  GetRiyuu() : super();

  Future<dynamic> _notSuccess({
    required jyucyuId,
    required Function() onSuccess
  }) async {
    if(await LocalStorageServices.isTodayDataDownloaded()){
      var res = await LocalStorageServices().getReason(jyucyuId: jyucyuId);
      onSuccess.call();
      return res;
    }
    else{
      throw Exception('Failed to get');
    }
  }

  Future<dynamic> getRiyuu({required String JYUCYU_ID, required Function() onSuccess}) async {

    bool isOnline = await LocalStorageNotifier.isOnline();

    if(!isOnline && LocalStorageNotifier.isTodayDownload()){
      return _notSuccess(jyucyuId: JYUCYU_ID, onSuccess: onSuccess);
    }

    try{
      final response = await http.get(
        Uri.parse(
            "${Constant.url}Request/Koji/requestEnterReason.php?JYUCYU_ID=$JYUCYU_ID"),
      );

      if (response.statusCode == 200) {
        final dynamic result = jsonDecode(response.body);
        onSuccess.call();
        return result;
      } else {
        throw Exception('Failed to get');
      }
    } catch(e){
      throw Exception('Failed to get');
    }
  }
}
