import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_life_one/api/koji/requestConstructionReport/get_koji_houkoku.dart';

import '../../../models/koji_houkoku_model.dart';

class KojiHoukokuNotifier extends ChangeNotifier {
  final String _dbKey = 'kojiHoukokuCache';

  List<KojiHoukokuModel> originListKojiHoukoku = [];
  List<KojiHoukokuModel> listKojiHoukoku = [];
  List<dynamic> listPullDown = [];
  Map<int, int> listStateIndexDropdown = {};
  XFile? imageFile;
  XFile? befImage;
  XFile? aftImage;
  List<XFile> otherImages = [];

  String tenpoId = '';

  Future<void> getData(String jyucyuId, String singleSummarize, String kojiSt,
      String syuyakuJyucyuId) async {
    final dynamic result = await GetKojiHoukoku().getKojiHoukoku(
        JYUCYU_ID: jyucyuId,
        SINGLE_SUMMARIZE: singleSummarize,
        KOJI_ST: kojiSt,
        SYUYAKU_JYUCYU_ID: syuyakuJyucyuId,
        onSuccess: (res) {
          if (res['DATA'] != null) {
            List<dynamic> kojiListJson = res['DATA'];
            listKojiHoukoku =
                kojiListJson.map((e) => KojiHoukokuModel.fromJson(e)).toList();
          }
          if (listKojiHoukoku.isNotEmpty) {
            KojiHoukokuModel firstItem = listKojiHoukoku.first;
            tenpoId = firstItem.tenpoCd ?? '';
          } else {
            listKojiHoukoku = [KojiHoukokuModel.empty()];
            originListKojiHoukoku = listKojiHoukoku;
          }
          if (res["TENPO_CD"] != null) {
            tenpoId = res['TENPO_CD'];
          }

          List pulldownList = res['PULLDOWN'];

          if (pulldownList.isNotEmpty) {
            for (var i = 0; i < listKojiHoukoku.length; i++) {
              KojiHoukokuModel koji = listKojiHoukoku[i];
              for (var j = 0; j < pulldownList.length; j++) {
                Map<String, dynamic> pulldownItem = pulldownList[j];
                if (koji.kensetuKeitai == pulldownItem['KBNMSAI_CD']) {
                  listStateIndexDropdown[i] = j;
                }
              }
            }
            listPullDown = pulldownList;
          }
        },
        onFailed: () {
          listKojiHoukoku = [KojiHoukokuModel.empty()];
          originListKojiHoukoku = listKojiHoukoku;
        });
    notifyListeners();
  }

  void selectOthersImage(int? index) async {
    final ImagePicker picker = ImagePicker();
    try {
      List<XFile> files = await picker.pickMultiImage();
      if (files.isNotEmpty) {
        if (index != null) {
          listKojiHoukoku
              .elementAt(index)
              .otherPhotoFolderPath
              ?.addAll(files.map((e) => e.path).toList());
        } else {
          otherImages = files;
        }
      }
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }

  void selectBeforeImage(int? index) async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        if (index != null) {
          listKojiHoukoku.elementAt(index).befSekiPhotoFilePath = file.path;
        } else {
          befImage = file;
        }
      }
    } catch (e) {}
    notifyListeners();
  }

  void selectafterImage(int? index) async {
    final ImagePicker picker = ImagePicker();
    try {
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        if (index != null) {
          listKojiHoukoku.elementAt(index).aftSekoPhotoFilePath = file.path;
        } else {
          aftImage = file;
        }
      }
    } catch (e) {}
    notifyListeners();
  }

  void updateMakerCd(String value, int index) {
    listKojiHoukoku[index].makerCd = value;
    notifyListeners();
  }

  void updateHinban(String value, int index) {
    listKojiHoukoku[index].hinban = value;
    notifyListeners();
  }

  void updateKisetuMaker(String value, int index) {
    listKojiHoukoku[index].kisetuMaker = value;
    notifyListeners();
  }

  void updateKisetuHinban(String value, int index) {
    listKojiHoukoku[index].kisetuHinban = value;
    notifyListeners();
  }

  void updateDropdownIndex(int kojiIndex, int selectedIndex) {
    listStateIndexDropdown[kojiIndex] = selectedIndex;
    notifyListeners();
  }

  void onPop(BuildContext context) {
    Navigator.of(context).pop();
  }

  
}
