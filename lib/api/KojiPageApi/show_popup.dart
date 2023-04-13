import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:link_life_one/local_storage_services/local_storage_services.dart';
import 'dart:convert';

import '../../constants/constant.dart';

class ShowPopUp {
  ShowPopUp() : super();

  _isToday(DateTime date){
    return DateFormat('yyyyMMdd').format(date)==DateFormat('yyyyMMdd').format(DateTime.now());
  }

  Future<int> _notSuccess({required DateTime date, required setsakiAddress, required jyucyuId, required Function(int) onSuccess}) async {
    if(_isToday(date)){
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
        return _notSuccess(
            date: YMD,
            setsakiAddress: SETSAKI_ADDRESS,
            jyucyuId: JYUCYU_ID,
            onSuccess: onSuccess
        );
      }
    } catch(e) {
      return _notSuccess(
          date: YMD,
          setsakiAddress: SETSAKI_ADDRESS,
          jyucyuId: JYUCYU_ID,
          onSuccess: onSuccess
      );
    }

  }
}
