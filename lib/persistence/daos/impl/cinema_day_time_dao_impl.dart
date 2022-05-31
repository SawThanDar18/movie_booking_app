import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/cinema/cinema_day_time_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/day_time_slots_vo.dart';
import 'package:movie_booking_app/persistence/daos/cinema_day_time_dao.dart';

import '../../hive_constants.dart';

class CinemaDayTimeDaoImpl extends CinemaDayTimeDao {

  static final CinemaDayTimeDaoImpl _singleton = CinemaDayTimeDaoImpl._internal();

  factory CinemaDayTimeDaoImpl() {
    return _singleton;
  }

  CinemaDayTimeDaoImpl._internal();

  List<DayTimeSlotsVO> cinemaDayTimeSlotsList = [];

  @override
  Stream<void> getCinemaDayTimeSlotsEventStream() {
    return getCinemaDayTimeSlotsBox().watch();
  }

  @override
  Stream<CinemaDayTimeVO?> getCinemaDayTimeSlotsStream(String bookingDate) {
    return Stream.value(getCinemaDayTimeSlots(bookingDate));
  }

  @override
  void saveAllCinemaDayTimeSlots(String bookingDate, CinemaDayTimeVO cinemaDayTimeSlotsList) async {
    await getCinemaDayTimeSlotsBox().put(bookingDate, cinemaDayTimeSlotsList);
  }

  @override
  CinemaDayTimeVO? getCinemaDayTimeSlots(String bookingDate) {
    return getCinemaDayTimeSlotsBox().get(bookingDate);
  }

  Box<CinemaDayTimeVO> getCinemaDayTimeSlotsBox() {
    return Hive.box<CinemaDayTimeVO>(BOX_NAME_CINEMA_DAY_TIME_VO);
  }

}