import "package:http/http.dart" as http;

import '../../constants/constant.dart';

class PostUpdateKojiReadFlg {
  PostUpdateKojiReadFlg() : super();

  Future<void> postUpdateKojiReadFlg({
    required List<dynamic> listJYUCYU_ID,
    required Function() onSuccess,
    required Function() onFailed,
  }) async {
    try {
      final response = await http.post(
          Uri.parse(
              "${Constant.url}Request/Menu/requestPostUpdateKojiReadFlg.php"),
          body: {
            "JYUCYU_ID": listJYUCYU_ID.toString(),
          });

      if (response.statusCode == 200) {
        onSuccess.call();
      } else {
        onFailed.call();
      }
    } catch (e) {
      onFailed.call();
    }
  }
}
