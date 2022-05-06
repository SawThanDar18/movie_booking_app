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

    test('Select and Remove Seat Test', () {
      seatingBloc?.selectSeat(getMockMovieSeatList()?.first.first);
      expect(seatingBloc?.movieSeats?.first.isSelected, true);
      expect(seatingBloc?.seats, [seatingBloc?.movieSeats?.first.seatName]);
      expect(seatingBloc?.getSelectedRowAsFormattedString(), seatingBloc?.movieSeats?.first.symbol);
      expect(seatingBloc?.totalPrice, 5);

      seatingBloc?.selectSeat(getMockMovieSeatList()?.first.last);
      seatingBloc?.selectSeat(getMockMovieSeatList()?.first.first);
      expect(seatingBloc?.movieSeats?.first.isSelected, false);
      expect(seatingBloc?.seats, [seatingBloc?.movieSeats?.last.seatName]);
      expect(seatingBloc?.getSelectedRowAsFormattedString(), seatingBloc?.movieSeats?.last.symbol);
      expect(seatingBloc?.price, 0);
    });

  });

}



/*test('Tap Seat', () {
      seatingBloc?.onTapSeat(SeatsVO(1, SEAT_TYPE_AVAILABLE, 'A1', 'A', 5, false),);
      expect(seatingBloc?.movieSeats?.first.isSelected, true);
      expect(seatingBloc?.tickets, 1);
      expect(seatingBloc?.chooseSeatName, 'A');
      expect(seatingBloc?.totalPrice, 5);
    });

    test('Remove Seat', () {
      seatingBloc?.onTapSeat(SeatsVO(1, SEAT_TYPE_AVAILABLE, 'A1', 'A', 5, false),);
      expect(seatingBloc?.movieSeats?.first.isSelected, false);
      expect(seatingBloc?.tickets, 0);
      expect(seatingBloc?.seats, []);
      expect(seatingBloc?.totalPrice, 0);
    });*/