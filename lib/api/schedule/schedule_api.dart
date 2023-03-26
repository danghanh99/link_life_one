import 'package:dio/dio.dart';
import 'package:link_life_one/api/base/rest_api.dart';
import 'package:link_life_one/constants/constant.dart';
import 'package:link_life_one/models/person_model.dart';

class ScheduleAPI {
  static final ScheduleAPI _instance = ScheduleAPI._internal();
  static ScheduleAPI get shared => _instance;
  ScheduleAPI._internal();

  Future<List<PersonModel>> getListPerson(String kojigyosyaCode,
      Function(List<PersonModel>) onSuccess, Function() onFailure) async {
    String urlEndpoint =
        '${Constant.getListPersonSchedule}KOJIGYOSYA_CD=$kojigyosyaCode';

    final Response response = await RestAPI.shared.getData(urlEndpoint);

    if (response.statusCode == 200) {
      List<dynamic> data = response.data;
      if (data.isNotEmpty) {
        List<PersonModel> peopleList =
            data.map((e) => PersonModel.fromJson(e)).toList();
        onSuccess(peopleList);
        return peopleList;
      }
    } else {
      onFailure();
    }
    return [];
  }
}
