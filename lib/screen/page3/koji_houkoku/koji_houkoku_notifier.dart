import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:link_life_one/api/koji/requestConstructionReport/get_koji_houkoku.dart';
import 'package:link_life_one/shared/cache_notifier.dart';
import 'package:provider/provider.dart';

import '../../../models/koji_houkoku_model.dart';

class KojiHoukokuNotifier extends ChangeNotifier {
  final String _dbKey = 'kojiHoukokuCache';

  List<KojiHoukokuModel> originListKojiHoukoku = [];
  List<KojiHoukokuModel> listKojiHoukoku = [];
  List<dynamic> listPullDown = [];
  XFile? imageFile;
  XFile? befImage;
  XFile? aftImage;
  List<XFile> otherImages = [];

  String tenpoId = '';

  Future<void> getData(BuildContext context, String jyucyuId,
      String singleSummarize, String kojiSt, String syuyakuJyucyuId) async {
    final dynamic result = await GetKojiHoukoku().getKojiHoukoku(
        JYUCYU_ID: jyucyuId,
        SINGLE_SUMMARIZE: singleSummarize,
        KOJI_ST: kojiSt,
        SYUYAKU_JYUCYU_ID: syuyakuJyucyuId,
        onSuccess: (res) {
          if (res['DATA'] != null) {
            List<dynamic> kojiListJson = res['DATA'];
            originListKojiHoukoku =
                kojiListJson.map((e) => KojiHoukokuModel.fromJson(e)).toList();
            listKojiHoukoku =
                kojiListJson.map((e) => KojiHoukokuModel.fromJson(e)).toList();
            readCache(context, jyucyuId);
          }
          if (listKojiHoukoku.isNotEmpty) {
            KojiHoukokuModel firstItem = listKojiHoukoku.first;
            tenpoId = firstItem.tenpoCd ?? '';
          } else {
            originListKojiHoukoku = [KojiHoukokuModel.empty()];
            listKojiHoukoku = [KojiHoukokuModel.empty()];
          }
          if (res["TENPO_CD"] != null) {
            tenpoId = res['TENPO_CD'];
          }

          List pulldownList = res['PULLDOWN'];
          print('res pulldown: ${res['PULLDOWN']}');

          if (pulldownList.isNotEmpty) {
            for (var i = 0; i < listKojiHoukoku.length; i++) {
              KojiHoukokuModel koji = listKojiHoukoku[i];
              for (var j = 0; j < pulldownList.length; j++) {
                Map<String, dynamic> pulldownItem = pulldownList[j];
                if (koji.kensetuKeitai == pulldownItem['KBNMSAI_CD']) {
                  // listStateIndexDropdown[i] = j;
                }
              }
            }
            listPullDown = pulldownList;
          }
        },
        onFailed: () {
          originListKojiHoukoku = [KojiHoukokuModel.empty()];
          listKojiHoukoku = [KojiHoukokuModel.empty()];
        });
    notifyListeners();
  }

  void readCache(BuildContext context, String jyucyuId) {
    Map<String, List<KojiHoukokuModel>> cacheList =
        context.read<CacheNotifier>().cacheKojiHoukoku;
    if (cacheList[jyucyuId] != null && cacheList[jyucyuId]!.isNotEmpty) {
      List<KojiHoukokuModel> listItemCache = cacheList[jyucyuId]!;

      for (var item in listKojiHoukoku) {
        int index = listItemCache.indexWhere(
            (cacheItem) => cacheItem.jyucyuMsaiId == item.jyucyuMsaiId);
        if (index != -1) {
          listKojiHoukoku.replaceRange(listKojiHoukoku.indexOf(item),
              listKojiHoukoku.indexOf(item) + 1, [listItemCache[index]]);
        }
      }
    }
  }

  String getKbnmsaiName(String kbnmsaiCode) {
    String name = '';
    if (kbnmsaiCode.isNotEmpty) {
      Map<String, dynamic>? selectedElement = listPullDown.firstWhere(
          (element) => element['KBNMSAI_CD'] == kbnmsaiCode,
          orElse: () => null);
      if (selectedElement != null) {
        name = selectedElement['KBNMSAI_NAME'];
      }
    }
    return name;
  }

  void selectOthersImage(context, int? index) async {
    final ImagePicker picker = ImagePicker();
    showCupertinoModalPopup(
        context: context,
        builder: (context){
          return CupertinoActionSheet(
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                child: const Text('ライブラリから画像選択'),
                onPressed: () async {
                  try {
                    List<XFile> files = await picker.pickMultiImage();
                    if (files.isNotEmpty) {
                      if (index != null) {
                        listKojiHoukoku[index].isAddOthers = true;
                        listKojiHoukoku
                            .elementAt(index)
                            .otherPhotoFolderPath
                            ?.addAll(files.map((e) => e.path).toList());
                      } else {
                        otherImages = files;
                      }
                    }
                  } catch (e) {}
                  notifyListeners();
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('カメラ起動'),
                onPressed: () async {
                  try {
                    XFile? file = await picker.pickImage(source: ImageSource.camera);
                    if (file!=null) {
                      if (index != null) {
                        listKojiHoukoku[index].isAddOthers = true;
                        listKojiHoukoku
                            .elementAt(index)
                            .otherPhotoFolderPath
                            ?.add(file.path);
                      } else {
                        otherImages = [file];
                      }
                    }
                  } catch (e) {}
                  notifyListeners();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
    );
  }

  void selectBeforeImage(context, int? index) async {
    final ImagePicker picker = ImagePicker();
    showCupertinoModalPopup(
        context: context,
        builder: (context){
          return CupertinoActionSheet(
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                child: const Text('ライブラリから画像選択'),
                onPressed: () async {
                  try {
                    XFile? file = await picker.pickImage(source: ImageSource.gallery);
                    if (file != null) {
                      if (index != null) {
                        listKojiHoukoku[index].isChangeBefore = true;
                        listKojiHoukoku.elementAt(index).befSekiPhotoFilePath = file.path;
                      } else {
                        befImage = file;
                      }
                    }
                  } catch (e) {}
                  notifyListeners();
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('カメラ起動'),
                onPressed: () async {
                  try {
                    XFile? file = await picker.pickImage(source: ImageSource.camera);
                    if (file != null) {
                      if (index != null) {
                        listKojiHoukoku[index].isChangeBefore = true;
                        listKojiHoukoku.elementAt(index).befSekiPhotoFilePath = file.path;
                      } else {
                        befImage = file;
                      }
                    }
                  } catch (e) {}
                  notifyListeners();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
    );
  }

  void selectafterImage(context, int? index) async {
    final ImagePicker picker = ImagePicker();
    showCupertinoModalPopup(
        context: context,
        builder: (context){
          return CupertinoActionSheet(
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                child: const Text('ライブラリから画像選択'),
                onPressed: () async {
                  try {
                    XFile? file = await picker.pickImage(source: ImageSource.gallery);
                    if (file != null) {
                      if (index != null) {
                        listKojiHoukoku[index].isChangeAfter = true;
                        listKojiHoukoku.elementAt(index).aftSekoPhotoFilePath = file.path;
                      } else {
                        aftImage = file;
                      }
                    }
                  } catch (e) {}
                  notifyListeners();
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('カメラ起動'),
                onPressed: () async {
                  try {
                    XFile? file = await picker.pickImage(source: ImageSource.camera);
                    if (file != null) {
                      if (index != null) {
                        listKojiHoukoku[index].isChangeAfter = true;
                        listKojiHoukoku.elementAt(index).aftSekoPhotoFilePath = file.path;
                      } else {
                        aftImage = file;
                      }
                    }
                  } catch (e) {}
                  notifyListeners();
                  Navigator.pop(context);
                },
              ),
            ],
          );
        }
    );
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

  void selectedPulldown(String kbnmsaiCode, int index) {
    listKojiHoukoku[index].kensetuKeitai = kbnmsaiCode;
    notifyListeners();
  }

  void onPop(BuildContext context, String jyucyuId) {
    List<KojiHoukokuModel> cacheList = [];
    for (var i = 0; i < originListKojiHoukoku.length; i++) {
      KojiHoukokuModel origin = originListKojiHoukoku.elementAt(i);
      KojiHoukokuModel item = listKojiHoukoku.elementAt(i);

      if (jsonEncode(origin) != jsonEncode(item)) {
        cacheList.add(item);
      }
    }
    if (cacheList.isNotEmpty) {
      context.read<CacheNotifier>().cacheKojiHoukokuList(jyucyuId, cacheList);
    }
    Navigator.of(context).pop();
  }
}
