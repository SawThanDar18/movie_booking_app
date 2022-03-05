
import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/cinema/cinema_day_time_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/day_time_slots_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

class CinemaDayTimeDao {

  static final CinemaDayTimeDao _singleton = CinemaDayTimeDao._internal();

  factory CinemaDayTimeDao() {
    return _singleton;
  }

  CinemaDayTimeDao._internal();

  List<DayTimeSlotsVO> cinemaDayTimeSlotsList = [];

  Stream<void> getCinemaDayTimeSlotsEventStream() {
    return getCinemaDayTimeSlotsBox().watch();
  }

  Stream<CinemaDayTimeVO?> getCinemaDayTimeSlotsStream(String bookingDate) {
    return Stream.value(getCinemaDayTimeSlots(bookingDate));
  }

  void saveAllCinemaDayTimeSlots(String bookingDate, CinemaDayTimeVO cinemaDayTimeSlotsList) async {
    await getCinemaDayTimeSlotsBox().put(bookingDate, cinemaDayTimeSlotsList);
  }

  CinemaDayTimeVO? getCinemaDayTimeSlots(String bookingDate) {
    return getCinemaDayTimeSlotsBox().get(bookingDate);
  }

  Box<CinemaDayTimeVO> getCinemaDayTimeSlotsBox() {
    return Hive.box<CinemaDayTimeVO>(BOX_NAME_CINEMA_DAY_TIME_VO);
  }
}