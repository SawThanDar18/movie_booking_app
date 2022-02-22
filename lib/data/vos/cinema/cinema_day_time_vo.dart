import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/cinema/day_time_slots_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

part 'cinema_day_time_vo.g.dart';

@HiveType(typeId: HIVE_TYPE_ID_CINEMA_DAY_TIME_VO, adapterName: "CinemaDayTimeVOAdapter")
class CinemaDayTimeVO {

  @HiveField(0)
  List<DayTimeSlotsVO>? cinemaDayTimeList;

  CinemaDayTimeVO(this.cinemaDayTimeList);

  @override
  String toString() {
    return 'CinemaDayTimeVO{cinemaDayTimeList: $cinemaDayTimeList}';
  }
}