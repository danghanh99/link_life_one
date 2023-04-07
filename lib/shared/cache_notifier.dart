import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tuple/tuple.dart';

import '../models/koji_houkoku_model.dart';

class CacheNotifier extends ChangeNotifier {
  Map<String, List<KojiHoukokuModel>> cacheKojiHoukoku =
      {}; // key: JyucyuId - value: list KojiHoukou
  Map<String, List<Map<String, String>>> cacheNewTableShoudakuShoukisai = {};
  Map<String, String> cacheRemarks = {};

  Map<String, List<bool>> cacheSelectedCheckBoxs = {}; // 7 check box in ShoudakuSho screen

  Map<String, List<XFile>> cacheShashinTeishuutsuGamenImages = {};

  Map<String, Tuple2<String, DateTime>> cacheRiyuu = {};

  void cacheKojiHoukokuList(String jyucyuId, List<KojiHoukokuModel> list) {
    cacheKojiHoukoku[jyucyuId] = list;
    notifyListeners();
  }

  void cacheNewTableShoudakuShoukisaiList(
      String jyucyuId, List<Map<String, String>> list) {
    cacheNewTableShoudakuShoukisai[jyucyuId] = list;
    notifyListeners();
  }

  void cacheRemark(String jyucyuId, String remark) {
    cacheRemarks[jyucyuId] = remark;
    notifyListeners();
  }
  
  void cacheListCheckBox(String jyucyuId, List<bool> values) {
    cacheSelectedCheckBoxs[jyucyuId] = values;
    notifyListeners();
  }

  void cacheListShashinTeishuutsuImages(String jyucyuId, List<XFile> images) {
    cacheShashinTeishuutsuGamenImages[jyucyuId] = images;
    notifyListeners();
  }

  void cacheRiyuuData(String jyucyuId, Tuple2<String, DateTime> data) {
    cacheRiyuu[jyucyuId] = data;
    notifyListeners();
  }

  void clearCache(String jyucyuId) {
    cacheKojiHoukoku[jyucyuId] = [];
    cacheNewTableShoudakuShoukisai[jyucyuId] = [];
    cacheRemarks[jyucyuId] = '';
    cacheSelectedCheckBoxs[jyucyuId] = [];
    cacheShashinTeishuutsuGamenImages[jyucyuId] = [];
    notifyListeners();
  }

  void clearShitami() {
    cacheShashinTeishuutsuGamenImages = {};
    cacheRiyuu = {};
    notifyListeners();
  }
}
