import "package:http/http.dart" as http;
import 'dart:convert';

class GetImage {
  GetImage() : super();

  Future<dynamic> getImage(
      {required String JYUCYU_ID,
      required String KOJI_ST,
      required String SHITAMI_MENU,
      required Function() onSuccess}) async {
    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/requestPhotoSubmissionPreview.php?KOJI_ST=$KOJI_ST&SHITAMI_MENU=$SHITAMI_MENU&JYUCYU_ID=$JYUCYU_ID"),
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
