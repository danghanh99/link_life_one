import 'package:flutter/cupertino.dart';

import '../models/koji_houkoku_model.dart';

class CacheNotifier extends ChangeNotifier {
  Map<String, List<KojiHoukokuModel>> cacheKojiHoukoku =
      {}; // key: JyucyuId - value: list KojiHoukou
  Map<String, List<Map<String, String>>> cacheNewTableShoudakuShoukisai = {};
  Map<String, String> cacheRemarks = {};

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

  void clearCache(String jyucyuId) {
    cacheKojiHoukoku[jyucyuId] = [];
    cacheNewTableShoudakuShoukisai[jyucyuId] = [];
    cacheRemarks[jyucyuId] = '';
    notifyListeners();
  }
}
