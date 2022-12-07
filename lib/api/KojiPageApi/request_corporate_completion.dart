import "package:http/http.dart" as http;

class RequestCorporateCompletion {
  RequestCorporateCompletion() : super();

  Future<void> requestCorporateCompletion(
      {required String JYUCYU_ID, required Function onSuccess, required Function onFailed}) async {
    final response = await http.post(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/Request/Koji/requestCorporateCompletion.php"),
          body: {
            'JYUCYU_ID': JYUCYU_ID
          }
    );

    if (response.statusCode == 200) {
      onSuccess.call();
    } else {
      onFailed.call();
    }
  }
}
