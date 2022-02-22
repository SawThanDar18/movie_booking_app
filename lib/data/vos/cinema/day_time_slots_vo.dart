import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:movie_booking_app/data/vos/cinema/time_slots_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'day_time_slots_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_DAY_TIME_SLOT_VO, adapterName: "DayTimeSlotsVOAdapter")
class DayTimeSlotsVO {

  @JsonKey(name: "cinema_id")
  @HiveField(0)
  int? cinemaId;

  @JsonKey(name: "cinema")
  @HiveField(1)
  String? cinemaName;

  @JsonKey(name: "timeslots")
  @HiveField(2)
  List<TimeSlotsVO?> timeSlots;

  DayTimeSlotsVO(this.cinemaId, this.cinemaName, this.timeSlots);

  factory DayTimeSlotsVO.fromJson(Map<String, dynamic> json) => _$DayTimeSlotsVOFromJson(json);

  Map<String, dynamic> toJson() => _$DayTimeSlotsVOToJson(this);

}