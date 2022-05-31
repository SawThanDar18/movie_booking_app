import 'package:movie_booking_app/data/vos/cinema/cinema_day_time_vo.dart';
import 'package:movie_booking_app/persistence/daos/cinema_day_time_dao.dart';

import '../mock_data/mock_data.dart';

class CinemaDayTimeDaoImplMock extends CinemaDayTimeDao {
  Map<String, CinemaDayTimeVO> cinemaListFromDataBaseMock = {};

  @override
  CinemaDayTimeVO? getCinemaDayTimeSlots(String bookingDate) {
    return getMockCinemaListVO();
  }

  @override
  Stream<void> getCinemaDayTimeSlotsEventStream() {
    return Stream.value(null);
  }

  @override
  Stream<CinemaDayTimeVO?> getCinemaDayTimeSlotsStream(String bookingDate) {
    return Stream.value(getMockCinemaListVO());
  }

  @override
  void saveAllCinemaDayTimeSlots(String bookingDate, CinemaDayTimeVO cinemaDayTimeSlotsList) {
    cinemaListFromDataBaseMock[bookingDate] = cinemaDayTimeSlotsList;
  }

}