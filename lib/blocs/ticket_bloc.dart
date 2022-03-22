import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/vos/cinema/user_booking_vo.dart';

class TicketBloc extends ChangeNotifier {

  UserBookingVO? userBookingVO;

  TicketBloc(UserBookingVO? userBookingVO) {
    this.userBookingVO = userBookingVO;
  }

}