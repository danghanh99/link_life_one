
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:link_life_one/local_storage_services/local_storage_services.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';
import 'dart:convert';

import '../../constants/constant.dart';

class ShowPopUp {
  ShowPopUp() : super();

  Future<int> _notSuccess({required DateTime date, required setsakiAddress, required jyucyuId, required Function(int) onSuccess}) async {
    if(await LocalStorageServices.isTodayDataDownloaded()){
      int count = await LocalStorageServices().checkCount(
          YMD: date,
          setsakiAddress: setsakiAddress,
          jyucyuId: jyucyuId
      );
      onSuccess.call(count);
      return count;
    }
    else{
      throw Exception('Failed to get count');
    }
  }

  Future<int> isShowPopup(
      {required DateTime YMD,
      required String SETSAKI_ADDRESS,
      required String JYUCYU_ID,
      required Function(int count) onSuccess}) async {

    if(LocalStorageNotifier.isOfflineMode && LocalStorageNotifier.isChoosenToday){
      print('offline mode');
      return _notSuccess(
          date: YMD,
          setsakiAddress: SETSAKI_ADDRESS,
          jyucyuId: JYUCYU_ID,
          onSuccess: onSuccess
      );
    }

    try{
      final response = await http.get(
        Uri.parse(
            "${Constant.url}Request/Koji/requestCheckCount.php?YMD=${DateFormat(('yyyy-MM-dd')).format(YMD)}&SETSAKI_ADDRESS=${SETSAKI_ADDRESS}&JYUCYU_ID=${JYUCYU_ID}"),
      );

      if (response.statusCode == 200) {
        final int count = jsonDecode(response.body);
        onSuccess.call(count);
        return count;
      } else {
        throw Exception('Failed to get count');
        // return _notSuccess(
        //     date: YMD,
        //     setsakiAddress: SETSAKI_ADDRESS,
        //     jyucyuId: JYUCYU_ID,
        //     onSuccess: onSuccess
        // );
      }
    } catch(e) {
      throw Exception('Failed to get count');
      // return _notSuccess(
      //     date: YMD,
      //     setsakiAddress: SETSAKI_ADDRESS,
      //     jyucyuId: JYUCYU_ID,
      //     onSuccess: onSuccess
      // );
    }

  }
}
