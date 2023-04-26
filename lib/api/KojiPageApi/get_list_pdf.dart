import "package:http/http.dart" as http;
import 'package:intl/intl.dart';
import 'package:link_life_one/local_storage_services/local_storage_services.dart';
import 'package:link_life_one/models/koji.dart';
import 'package:link_life_one/models/local_storage/local_storage_notifier/local_storage_notifier.dart';
import 'package:link_life_one/models/pdf_file.dart';
import 'dart:convert';

import '../../constants/constant.dart';

class GetListPdf {
  GetListPdf() : super();

  Future<List<PdfFile>> _notSuccess({
    required jyucyuId,
    required homonSbt
  }
  ) async {
    if(await LocalStorageServices.isTodayDataDownloaded()){
      return await LocalStorageServices().getFiles(jyucyuId: jyucyuId, homonSbt: homonSbt);
    }
    else{
      throw Exception('Failed to get list pdf');
    }
  }

  Future<List<PdfFile>> getListPdf(
      {required Koji koji, required String SINGLE_SUMMARIZE}) async {

    bool isOnline = await LocalStorageNotifier.isOnline();

    if(!isOnline && LocalStorageNotifier.isTodayDownload()){
      return _notSuccess(
          jyucyuId: koji.jyucyuId,
          homonSbt: koji.homonSbt
      );
    }

    try{
      final response = await http.get(
        Uri.parse(
            "${Constant.url}Request/Koji/requestGetRequestForm.php?JYUCYU_ID=${koji.jyucyuId}&SINGLE_SUMMARIZE=$SINGLE_SUMMARIZE&HOMON_SBT=${koji.homonSbt}"),
      );

      if (response.statusCode == 200) {
        final List<dynamic> list = jsonDecode(response.body);
        return list.map((e) => PdfFile.fromJson(e)).toList();
      } else if (response.statusCode == 400) {
        return [];
      } else {
        throw Exception('Failed to get list pdf');
      }
    } catch(e){
      throw Exception('Failed to get list pdf');
    }
  }
}
