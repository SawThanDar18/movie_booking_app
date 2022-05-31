import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/blocs/ticket_bloc.dart';

import '../data/model/cinema_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){

  group("Ticket Bloc Test",(){

    TicketBloc? ticketBloc;

    ticketBloc = TicketBloc(getMockCheckOut(), CinemaModelImplMock());

    test("CheckOut Test", () async{
      ticketBloc?.checkOut(getMockCheckOut());
      await Future.delayed(Duration(milliseconds: 600));
      expect(
        ticketBloc?.userBookingVO,
        getMockCheckOut(),
      );
    });

  });

}
