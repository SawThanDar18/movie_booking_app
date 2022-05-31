
import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/cinema/cinema_day_time_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/day_time_slots_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

abstract class CinemaDayTimeDao {

  Stream<void> getCinemaDayTimeSlotsEventStream();

  Stream<CinemaDayTimeVO?> getCinemaDayTimeSlotsStream(String bookingDate);

  void saveAllCinemaDayTimeSlots(String bookingDate, CinemaDayTimeVO cinemaDayTimeSlotsList);

  CinemaDayTimeVO? getCinemaDayTimeSlots(String bookingDate);

}