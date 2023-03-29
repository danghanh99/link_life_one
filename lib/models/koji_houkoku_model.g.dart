// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'koji_houkoku_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class KojiHoukokuModelAdapter extends TypeAdapter<KojiHoukokuModel> {
  @override
  final int typeId = 5;

  @override
  KojiHoukokuModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return KojiHoukokuModel(
      jyucyuMsaiId: fields[0] as String?,
      jyucyuMsaiIdKikan: fields[1] as String?,
      hinban: fields[2] as String?,
      makerCd: fields[3] as String?,
      ctgoryCd: fields[4] as String?,
      suryo: fields[5] as String?,
      kingak: fields[6] as String?,
      kisetuHinban: fields[7] as String?,
      kisetuMaker: fields[8] as String?,
      kisetuMakerCd: fields[9] as String?,
      kensetuKeitai: fields[10] as String?,
      befSekiPhotoFilePath: fields[11] as String?,
      aftSekoPhotoFilePath: fields[12] as String?,
      otherPhotoFolderPath: (fields[13] as List?)?.cast<String>(),
      tuikaJisyaCd: fields[14] as String?,
      tuikaSyohinName: fields[15] as String?,
      kojijiTuikaFlg: fields[16] as String?,
      kojiSt: fields[17] as String?,
      hojinFlg: fields[18] as String?,
      tenpoCd: fields[19] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, KojiHoukokuModel obj) {
    writer
      ..writeByte(20)
      ..writeByte(0)
      ..write(obj.jyucyuMsaiId)
      ..writeByte(1)
      ..write(obj.jyucyuMsaiIdKikan)
      ..writeByte(2)
      ..write(obj.hinban)
      ..writeByte(3)
      ..write(obj.makerCd)
      ..writeByte(4)
      ..write(obj.ctgoryCd)
      ..writeByte(5)
      ..write(obj.suryo)
      ..writeByte(6)
      ..write(obj.kingak)
      ..writeByte(7)
      ..write(obj.kisetuHinban)
      ..writeByte(8)
      ..write(obj.kisetuMaker)
      ..writeByte(9)
      ..write(obj.kisetuMakerCd)
      ..writeByte(10)
      ..write(obj.kensetuKeitai)
      ..writeByte(11)
      ..write(obj.befSekiPhotoFilePath)
      ..writeByte(12)
      ..write(obj.aftSekoPhotoFilePath)
      ..writeByte(13)
      ..write(obj.otherPhotoFolderPath)
      ..writeByte(14)
      ..write(obj.tuikaJisyaCd)
      ..writeByte(15)
      ..write(obj.tuikaSyohinName)
      ..writeByte(16)
      ..write(obj.kojijiTuikaFlg)
      ..writeByte(17)
      ..write(obj.kojiSt)
      ..writeByte(18)
      ..write(obj.hojinFlg)
      ..writeByte(19)
      ..write(obj.tenpoCd);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is KojiHoukokuModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
