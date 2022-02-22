// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_day_time_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CinemaDayTimeVOAdapter extends TypeAdapter<CinemaDayTimeVO> {
  @override
  final int typeId = 14;

  @override
  CinemaDayTimeVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CinemaDayTimeVO(
      (fields[0] as List?)?.cast<DayTimeSlotsVO>(),
    );
  }

  @override
  void write(BinaryWriter writer, CinemaDayTimeVO obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.cinemaDayTimeList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CinemaDayTimeVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
