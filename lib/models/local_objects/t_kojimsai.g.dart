// GENERATED CODE - DO NOT MODIFY BY HAND

part of 't_kojimsai.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TKojimsaiAdapter extends TypeAdapter<TKojimsai> {
  @override
  final int typeId = 10;

  @override
  TKojimsai read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TKojimsai(
      jyucyuId: fields[0] as String,
      jyucyumsaiId: fields[1] as String,
      jyucyumsaiIdKikan: fields[2] as String,
      hinban: fields[3] as String,
      makerCd: fields[4] as String,
      ctgotyCd: fields[5] as String,
      suryo: fields[6] as int,
      hanbaiTanka: fields[7] as String,
      kingak: fields[8] as String,
      kisetuHinban: fields[9] as String,
      kisetuMaker: fields[10] as String,
      kensetuKeitai: fields[11] as String,
      befSekoPhotoFilePath: fields[12] as String,
      aftSekoPhotoFilePath: fields[13] as String,
      otherPhotoFolderPath: fields[14] as String,
      tuikaJisyaCd: fields[15] as String,
      tuikaSyohinName: fields[16] as String,
      kojijituikaFlg: fields[17] as String,
      delFlg: fields[18] as int,
      renkeiYMD: fields[19] as String,
      addPGID: fields[20] as String,
      addTantCd: fields[21] as String,
      addYMD: fields[22] as String,
      updPGID: fields[23] as String,
      updTantCd: fields[24] as String,
      updYMD: fields[25] as String,
    );
  }

  @override
  void write(BinaryWriter writer, TKojimsai obj) {
    writer
      ..writeByte(26)
      ..writeByte(0)
      ..write(obj.jyucyuId)
      ..writeByte(1)
      ..write(obj.jyucyumsaiId)
      ..writeByte(2)
      ..write(obj.jyucyumsaiIdKikan)
      ..writeByte(3)
      ..write(obj.hinban)
      ..writeByte(4)
      ..write(obj.makerCd)
      ..writeByte(5)
      ..write(obj.ctgotyCd)
      ..writeByte(6)
      ..write(obj.suryo)
      ..writeByte(7)
      ..write(obj.hanbaiTanka)
      ..writeByte(8)
      ..write(obj.kingak)
      ..writeByte(9)
      ..write(obj.kisetuHinban)
      ..writeByte(10)
      ..write(obj.kisetuMaker)
      ..writeByte(11)
      ..write(obj.kensetuKeitai)
      ..writeByte(12)
      ..write(obj.befSekoPhotoFilePath)
      ..writeByte(13)
      ..write(obj.aftSekoPhotoFilePath)
      ..writeByte(14)
      ..write(obj.otherPhotoFolderPath)
      ..writeByte(15)
      ..write(obj.tuikaJisyaCd)
      ..writeByte(16)
      ..write(obj.tuikaSyohinName)
      ..writeByte(17)
      ..write(obj.kojijituikaFlg)
      ..writeByte(18)
      ..write(obj.delFlg)
      ..writeByte(19)
      ..write(obj.renkeiYMD)
      ..writeByte(20)
      ..write(obj.addPGID)
      ..writeByte(21)
      ..write(obj.addTantCd)
      ..writeByte(22)
      ..write(obj.addYMD)
      ..writeByte(23)
      ..write(obj.updPGID)
      ..writeByte(24)
      ..write(obj.updTantCd)
      ..writeByte(25)
      ..write(obj.updYMD);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TKojimsaiAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TKojimsai _$TKojimsaiFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'JYUCYU_ID',
      'JYUCYUMSAI_ID',
      'JYUCYUMSAI_ID_KIKAN',
      'HINBAN',
      'MAKER_CD',
      'CTGORY_CD',
      'SURYO',
      'HANBAI_TANKA',
      'KINGAK',
      'KISETU_HINBAN',
      'KISETU_MAKER',
      'KENSETU_KEITAI',
      'BEF_SEKO_PHOTO_FILEPATH',
      'AFT_SEKO_PHOTO_FILEPATH',
      'OTHER_PHOTO_FOLDERPATH',
      'TUIKA_JISYA_CD',
      'TUIKA_SYOHIN_NAME',
      'KOJIJITUIKA_FLG',
      'DEL_FLG',
      'RENKEI_YMD',
      'ADD_PGID',
      'ADD_TANTCD',
      'ADD_YMD',
      'UPD_PGID',
      'UPD_TANTCD',
      'UPD_YMD'
    ],
  );
  return TKojimsai(
    jyucyuId: json['JYUCYU_ID'] as String,
    jyucyumsaiId: json['JYUCYUMSAI_ID'] as String,
    jyucyumsaiIdKikan: json['JYUCYUMSAI_ID_KIKAN'] as String,
    hinban: json['HINBAN'] as String,
    makerCd: json['MAKER_CD'] as String,
    ctgotyCd: json['CTGORY_CD'] as String,
    suryo: json['SURYO'] as int,
    hanbaiTanka: json['HANBAI_TANKA'] as String,
    kingak: json['KINGAK'] as String,
    kisetuHinban: json['KISETU_HINBAN'] as String,
    kisetuMaker: json['KISETU_MAKER'] as String,
    kensetuKeitai: json['KENSETU_KEITAI'] as String,
    befSekoPhotoFilePath: json['BEF_SEKO_PHOTO_FILEPATH'] as String,
    aftSekoPhotoFilePath: json['AFT_SEKO_PHOTO_FILEPATH'] as String,
    otherPhotoFolderPath: json['OTHER_PHOTO_FOLDERPATH'] as String,
    tuikaJisyaCd: json['TUIKA_JISYA_CD'] as String,
    tuikaSyohinName: json['TUIKA_SYOHIN_NAME'] as String,
    kojijituikaFlg: json['KOJIJITUIKA_FLG'] as String,
    delFlg: json['DEL_FLG'] as int,
    renkeiYMD: json['RENKEI_YMD'] as String,
    addPGID: json['ADD_PGID'] as String,
    addTantCd: json['ADD_TANTCD'] as String,
    addYMD: json['ADD_YMD'] as String,
    updPGID: json['UPD_PGID'] as String,
    updTantCd: json['UPD_TANTCD'] as String,
    updYMD: json['UPD_YMD'] as String,
  );
}

Map<String, dynamic> _$TKojimsaiToJson(TKojimsai instance) => <String, dynamic>{
      'JYUCYU_ID': instance.jyucyuId,
      'JYUCYUMSAI_ID': instance.jyucyumsaiId,
      'JYUCYUMSAI_ID_KIKAN': instance.jyucyumsaiIdKikan,
      'HINBAN': instance.hinban,
      'MAKER_CD': instance.makerCd,
      'CTGORY_CD': instance.ctgotyCd,
      'SURYO': instance.suryo,
      'HANBAI_TANKA': instance.hanbaiTanka,
      'KINGAK': instance.kingak,
      'KISETU_HINBAN': instance.kisetuHinban,
      'KISETU_MAKER': instance.kisetuMaker,
      'KENSETU_KEITAI': instance.kensetuKeitai,
      'BEF_SEKO_PHOTO_FILEPATH': instance.befSekoPhotoFilePath,
      'AFT_SEKO_PHOTO_FILEPATH': instance.aftSekoPhotoFilePath,
      'OTHER_PHOTO_FOLDERPATH': instance.otherPhotoFolderPath,
      'TUIKA_JISYA_CD': instance.tuikaJisyaCd,
      'TUIKA_SYOHIN_NAME': instance.tuikaSyohinName,
      'KOJIJITUIKA_FLG': instance.kojijituikaFlg,
      'DEL_FLG': instance.delFlg,
      'RENKEI_YMD': instance.renkeiYMD,
      'ADD_PGID': instance.addPGID,
      'ADD_TANTCD': instance.addTantCd,
      'ADD_YMD': instance.addYMD,
      'UPD_PGID': instance.updPGID,
      'UPD_TANTCD': instance.updTantCd,
      'UPD_YMD': instance.updYMD,
    };
