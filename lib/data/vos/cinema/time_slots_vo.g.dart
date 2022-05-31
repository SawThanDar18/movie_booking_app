// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_slots_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TimeSlotsVOAdapter extends TypeAdapter<TimeSlotsVO> {
  @override
  final int typeId = 16;

  @override
  TimeSlotsVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TimeSlotsVO(
      fields[0] as int?,
      fields[1] as String?,
    )..isSelected = fields[2] as bool?;
  }

  @override
  void write(BinaryWriter writer, TimeSlotsVO obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.dayTimeSlotsId)
      ..writeByte(1)
      ..write(obj.startTime)
      ..writeByte(2)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeSlotsVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeSlotsVO _$TimeSlotsVOFromJson(Map<String, dynamic> json) => TimeSlotsVO(
      json['cinema_day_timeslot_id'] as int?,
      json['start_time'] as String?,
    )..isSelected = json['isSelected'] as bool?;

Map<String, dynamic> _$TimeSlotsVOToJson(TimeSlotsVO instance) =>
    <String, dynamic>{
      'cinema_day_timeslot_id': instance.dayTimeSlotsId,
      'start_time': instance.startTime,
      'isSelected': instance.isSelected,
    };
