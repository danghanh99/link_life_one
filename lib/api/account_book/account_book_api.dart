import "package:http/http.dart" as http;
import 'dart:convert';
import '../../constants/constant.dart';
import '../../models/account_book.dart';

class AccountBookApi {
  AccountBookApi() : super();

  Future<void> getAccountBook({
    required String TANT_CD,
    required Function(AccountBook list) onSuccess,
    required Function onFailed,
  }) async {
    final response = await http.get(
      Uri.parse(
          "${Constant.url}Request/AccountBook/requestAccountBook.php?TANT_CD=$TANT_CD"),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = jsonDecode(response.body);
      onSuccess.call(AccountBook.fromJson(body));
    } else {}
  }
}
