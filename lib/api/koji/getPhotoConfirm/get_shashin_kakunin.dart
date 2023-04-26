import "package:http/http.dart" as http;
import 'package:link_life_one/local_storage_services/local_storage_services.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';
import 'dart:convert';

import '../../../constants/constant.dart';

class GetShashinKakunin {

  Future<List<dynamic>> _notSuccess({
    required jyucyuId,
    required Function(List<dynamic>) onSuccess,
    required Function onFailed
  })async{
    if(await LocalStorageServices.isTodayDataDownloaded()){
      var res = await LocalStorageServices().getPhotoConfirm(jyucyuId: jyucyuId);
      onSuccess.call(res);
      return res;
    }
    else{
      onFailed.call();
      throw Exception('Failed to GetShashinKakunin');
    }
  }

  GetShashinKakunin() : super();

  Future<List<dynamic>> getShashinKakunin({
    required String JYUCYU_ID,
    required String SINGLE_SUMMARIZE,
    required Function(List<dynamic>) onSuccess,
    required Function onFailed,
  }) async {

    bool isOnline = await LocalStorageNotifier.isOnline();

    if(!isOnline && LocalStorageNotifier.isTodayDownload()){
      return _notSuccess(
          jyucyuId: JYUCYU_ID,
          onSuccess: onSuccess,
          onFailed: onFailed
      );
    }

    try{

      final response = await http.get(
        Uri.parse(
            "${Constant.url}Request/Koji/requestGetPhotoConfirm.php?JYUCYU_ID=${JYUCYU_ID}&SINGLE_SUMMARIZE=${SINGLE_SUMMARIZE}"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> body = jsonDecode(response.body);
        onSuccess.call(body);
        return body;
      } else {
        onFailed.call();
        throw Exception('Failed to GetShashinKakunin');
      }

    } catch(e){
      onFailed.call();
      throw Exception('Failed to GetShashinKakunin');
    }

  }
}
