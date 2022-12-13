import "package:http/http.dart" as http;
import 'dart:convert';

import '../../constants/constant.dart';

class GetImage {
  GetImage() : super();

  Future<dynamic> getImage(
      {required String JYUCYU_ID,
      required String KOJI_ST,
      required String SHITAMI_MENU,
      required Function() onSuccess}) async {
    final response = await http.get(
      Uri.parse(
          "${Constant.url}Request/Koji/requestPhotoSubmissionPreview.php?KOJI_ST=$KOJI_ST&SHITAMI_MENU=$SHITAMI_MENU&JYUCYU_ID=$JYUCYU_ID"),
    );
    // oke

    if (response.statusCode == 200) {
      final dynamic result = jsonDecode(response.body);
      onSuccess.call();
      return result;
    } else {
      throw Exception('Failed to get list koji');
    }
  }
}
