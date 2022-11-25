import 'package:hive_flutter/hive_flutter.dart';
import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:link_life_one/models/koji.dart';
import 'dart:convert';

class GetListKojiApi {
  GetListKojiApi() : super();

  Future<List<Koji>> getListKojiApi({DateTime? date}) async {
    DateTime date2 = date ?? DateTime.now();
    final box = Hive.box<String>('user');
    final id = box.values.first;

    final response = await http.get(
      Uri.parse(
          "https://koji-app.starboardasiavn.com/requestConstructionList.php?YMD=${DateFormat(('yyyy-MM-dd')).format(date2)}&LOGIN_ID=${id}"),
    );

    if (response.statusCode == 200) {
      response.statusCode;
      final List<dynamic> body = jsonDecode(response.body);
      final List<Koji> list = body
          .map(
            (e) => Koji(
              sitamiHomonJikan: e["SITAMIHOMONJIKAN"],
              kojiHomonJikan: e["KOJIHOMONJIKAN"],
              homonSbt: e["HOMON_SBT"],
              jyucyuId: e["JYUCYU_ID"],
              shitamiJinin: 1,
              shitamiJikan: e["SITAMI_JIKAN"],
              kojiItem: e["KOJI_ITEM"],
              setsakiAddress: e["SETSAKI_ADDRESS"],
              setsakiName: e["SETSAKI_NAME"],
            ),
          )
          .toList();
      return list;
    } else {
      throw Exception('Failed to get list koji');
    }
  }
}
