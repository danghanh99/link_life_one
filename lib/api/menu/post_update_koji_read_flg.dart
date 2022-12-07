import "package:http/http.dart" as http;

class PostUpdateKojiReadFlg {
  PostUpdateKojiReadFlg() : super();

  Future<void> postUpdateKojiReadFlg(
      {required List<dynamic> listJYUCYU_ID,
      required Function() onSuccess}) async {
    final response = await http.post(
        Uri.parse(
            "https://koji-app.starboardasiavn.com/Request/Menu/requestPostUpdateKojiReadFlg.php"),
        body: {
          "JYUCYU_ID": listJYUCYU_ID.toString(),
        });

    if (response.statusCode == 200) {
      onSuccess.call();
    } else {
      throw Exception('Failed to getAnken');
    }
  }
}
