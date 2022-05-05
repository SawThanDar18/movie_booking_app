import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/blocs/seating_bloc.dart';

import '../data/model/cinema_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){

  group("Seating Bloc Test",(){

    SeatingBloc? seatingBloc;

    setUp((){
      seatingBloc = SeatingBloc(1, "2022-04-30", CinemaModelImplMock());
    });


    test('Seats Data Test', () {
      expect(seatingBloc?.movieSeats, getMockMovieSeatingList());
    });

    test('Select And Unselect Seat', () {
      seatingBloc?.onTapSeat(getMockMovieSeatList()?.first.first);
      expect(seatingBloc?.movieSeats?.first.isSelected, true);
      expect(seatingBloc?.seats.first, [seatingBloc?.movieSeats?.first.seatName]);
      expect(seatingBloc?.chooseSeatRow, seatingBloc?.movieSeats?.first.seatName);
      expect(seatingBloc?.totalPrice, 6);

      seatingBloc?.onTapSeat(getMockMovieSeatList()?.first.last);
      seatingBloc?.onTapSeat(getMockMovieSeatList()?.first.first);
      expect(seatingBloc?.movieSeats?.first.isSelected, false);
      expect(seatingBloc?.seats, [seatingBloc?.movieSeats?.last.seatName]);
      expect(seatingBloc?.chooseSeatRow, seatingBloc?.movieSeats?.last.symbol);
      expect(seatingBloc?.totalPrice, 6);
    });

  });

}