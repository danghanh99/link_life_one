import 'package:flutter/cupertino.dart';

import '../models/koji_houkoku_model.dart';

class CacheNotifier extends ChangeNotifier {
  Map<String, List<KojiHoukokuModel>> cacheKojiHoukoku = {}; // key: JyucyuId - value: list KojiHoukou

  void cacheKojiHoukokuList(String jyucyuId, List<KojiHoukokuModel> list) {
    cacheKojiHoukoku[jyucyuId] = list;
    notifyListeners();
  }

  void clearCache(String jyucyuId) {
    cacheKojiHoukoku[jyucyuId] = [];
    notifyListeners();
  }

}