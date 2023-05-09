import 'package:json_annotation/json_annotation.dart';
part 'koji.g.dart';

@JsonSerializable()
class Koji {
  final String? sitamiHomonJikan;
  final String? sitamiHomonJikanEnd;
  final String? kojiHomonJikan;
  final String? kojiHomonJikanEnd;
  final String homonSbt;
  final String jyucyuId;
  final int? shitamiJinin;
  final int? shitamiJikan;
  final int? kojiJinin;
  final int? kojiJikan;
  final String? kojiItem;
  final String setsakiAddress;
  final String? setsakiName;
  final String kojiSt;
  final String hojinFlag;
  final String? kbnmsaiName;
  final String? yobikomoku1;
  final String? yobikomoku2;

  Koji(
      {this.sitamiHomonJikan,
      this.sitamiHomonJikanEnd,
      this.kojiHomonJikan,
      this.kojiHomonJikanEnd,
      required this.homonSbt,
      required this.jyucyuId,
      this.shitamiJinin,
      this.shitamiJikan,
      this.kojiJinin,
      this.kojiJikan,
      this.kojiItem,
      required this.setsakiAddress,
      this.setsakiName,
      required this.kojiSt,
      required this.hojinFlag,
      this.kbnmsaiName,
      this.yobikomoku1,
      this.yobikomoku2});

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
        kojiSt: json['KOJI_ST'],
        hojinFlag: json['HOJIN_FLG'],
        kbnmsaiName: json['KBNMSAI_NAME'],
        yobikomoku1: json['YOBIKOMOKU1_KBN2'],
        yobikomoku2: json['YOBIKOMOKU2_KBN2']
    );
  }
}
