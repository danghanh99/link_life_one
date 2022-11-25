import 'package:json_annotation/json_annotation.dart';
part 'koji.g.dart';

@JsonSerializable()
class Koji {
  final String? sitamiHomonJikan;
  final String? kojiHomonJikan;
  final String homonSbt;
  final String jyucyuId;
  final int shitamiJinin;
  final int? shitamiJikan;
  final String kojiItem;
  final String setsakiAddress;
  final String setsakiName;

  Koji({
    this.kojiHomonJikan,
    this.sitamiHomonJikan,
    required this.homonSbt,
    required this.jyucyuId,
    required this.shitamiJinin,
    this.shitamiJikan,
    required this.kojiItem,
    required this.setsakiAddress,
    required this.setsakiName,
  });

  factory Koji.fromJson(Map<String, dynamic> json) {
    return Koji(
      kojiHomonJikan: json["KOJIHOMONJIKAN"],
      sitamiHomonJikan: json["SITAMIHOMONJIKAN"],
      homonSbt: json["HOMON_SBT"],
      jyucyuId: json["JYUCYU_ID"],
      shitamiJinin: json["SITAMI_JININ"],
      shitamiJikan: json["SITAMI_JIKAN"],
      kojiItem: json["KOJI_ITEM"],
      setsakiAddress: json["SETSAKI_ADDRESS"],
      setsakiName: json["SETSAKI_NAME"],
    );
  }
}
