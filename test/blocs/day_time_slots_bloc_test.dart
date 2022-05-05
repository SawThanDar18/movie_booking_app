import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/blocs/day_time_slots_bloc.dart';

import '../data/model/cinema_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {

  group("Time Slots Bloc Test", () {

    DayTimeSlotsBloc? dayTimeSlotsBloc;

    setUp(() {
      dayTimeSlotsBloc = DayTimeSlotsBloc(1, CinemaModelImplMock());
    });

    test("Cinema Data Test",(){
      expect(
        dayTimeSlotsBloc?.dayTimeSlots?.contains(getMockCinemaVOList()?.first),
        true,
      );
    });

    test("Cinema Choose Time Test", () async{
      dayTimeSlotsBloc?.getCinemaDayTimeSlots(1, "2022-04-30");
      await Future.delayed(Duration(milliseconds: 600));
      expect(
        dayTimeSlotsBloc?.dayTimeSlots?.contains(getMockCinemaVOList()?.last),
        true,
      );
    });


  });
}