// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'day_time_slots_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DayTimeSlotsVOAdapter extends TypeAdapter<DayTimeSlotsVO> {
  @override
  final int typeId = 15;

  @override
  DayTimeSlotsVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DayTimeSlotsVO(
      fields[0] as int?,
      fields[1] as String?,
      (fields[2] as List).cast<TimeSlotsVO?>(),
    );
  }

  @override
  void write(BinaryWriter writer, DayTimeSlotsVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.cinemaId)
      ..writeByte(1)
      ..write(obj.cinemaName)
      ..writeByte(2)
      ..write(obj.timeSlots);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DayTimeSlotsVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DayTimeSlotsVO _$DayTimeSlotsVOFromJson(Map<String, dynamic> json) =>
    DayTimeSlotsVO(
      json['cinema_id'] as int?,
      json['cinema'] as String?,
      (json['timeslots'] as List<dynamic>)
          .map((e) => e == null
              ? null
              : TimeSlotsVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DayTimeSlotsVOToJson(DayTimeSlotsVO instance) =>
    <String, dynamic>{
      'cinema_id': instance.cinemaId,
      'cinema': instance.cinemaName,
      'timeslots': instance.timeSlots,
    };
