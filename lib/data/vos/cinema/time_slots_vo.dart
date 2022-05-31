import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'time_slots_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_TIME_SLOT_VO, adapterName: "TimeSlotsVOAdapter")
class TimeSlotsVO {

  @JsonKey(name: "cinema_day_timeslot_id")
  @HiveField(0)
  int? dayTimeSlotsId;

  @JsonKey(name: "start_time")
  @HiveField(1)
  String? startTime;

  @HiveField(2)
  bool? isSelected;

  TimeSlotsVO(this.dayTimeSlotsId, this.startTime);

  factory TimeSlotsVO.fromJson(Map<String, dynamic> json) => _$TimeSlotsVOFromJson(json);

  Map<String, dynamic> toJson() => _$TimeSlotsVOToJson(this);

  @override
  String toString() {
    return 'TimeSlotsVO{dayTimeSlotsId: $dayTimeSlotsId, startTime: $startTime, isSelected: $isSelected}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeSlotsVO &&
          runtimeType == other.runtimeType &&
          dayTimeSlotsId == other.dayTimeSlotsId &&
          startTime == other.startTime &&
          isSelected == other.isSelected;

  @override
  int get hashCode =>
      dayTimeSlotsId.hashCode ^ startTime.hashCode ^ isSelected.hashCode;
}