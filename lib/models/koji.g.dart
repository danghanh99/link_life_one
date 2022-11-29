// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'koji.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Koji _$KojiFromJson(Map<String, dynamic> json) => Koji(
      kojiHomonJikan: json['kojiHomonJikan'] as String?,
      sitamiHomonJikan: json['sitamiHomonJikan'] as String?,
      homonSbt: json['homonSbt'] as String,
      jyucyuId: json['jyucyuId'] as String,
      shitamiJinin: json['shitamiJinin'] as int,
      shitamiJikan: json['shitamiJikan'] as int?,
      kojiItem: json['kojiItem'] as String,
      setsakiAddress: json['setsakiAddress'] as String,
      setsakiName: json['setsakiName'] as String,
      kojiSt: json['kojiSt'] as String,
    );

Map<String, dynamic> _$KojiToJson(Koji instance) => <String, dynamic>{
      'sitamiHomonJikan': instance.sitamiHomonJikan,
      'kojiHomonJikan': instance.kojiHomonJikan,
      'homonSbt': instance.homonSbt,
      'jyucyuId': instance.jyucyuId,
      'shitamiJinin': instance.shitamiJinin,
      'shitamiJikan': instance.shitamiJikan,
      'kojiItem': instance.kojiItem,
      'setsakiAddress': instance.setsakiAddress,
      'setsakiName': instance.setsakiName,
      'kojiSt': instance.kojiSt,
    };
