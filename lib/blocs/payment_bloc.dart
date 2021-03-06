import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/cinema_model.dart';
import 'package:movie_booking_app/data/models/cinema_model_impl.dart';
import 'package:movie_booking_app/data/vos/cinema/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/user_booking_vo.dart';
import 'package:movie_booking_app/data/vos/users/card_vo.dart';
import 'package:movie_booking_app/data/vos/users/user_vo.dart';

class PaymentBloc extends ChangeNotifier {

  CinemaModel cinemaModel = CinemaModelImpl();

  List<CardVO>? cards;
  CardVO? chooseCard;
  UserVO? profile;

  int cardIndex = 0;

  UserBookingVO? userBooking;

  PaymentBloc([CinemaModel? mCinemaModel]) {
    if (mCinemaModel != null) {
      cinemaModel = mCinemaModel;
    }

    cinemaModel.getProfile();

    cinemaModel.getUsersFromDatabase().listen((profileList) {
      profile = profileList.first;
      notifyListeners();
    }).onError((error) => print(error));

    getCards();
  }

  void getCards() {
    cinemaModel.getCardsFromDatabase().listen((event) {
        cards = event;
        notifyListeners();
    }).onError((error) => debugPrint(error.toString()));
  }

  void carouselSliderChange(int cardIndex) async {
      chooseCard = cards?[cardIndex];
      notifyListeners();
  }
  
  Future<UserBookingVO> checkout(
      int timeSlotId,
      String seatRow,
      String seatName,
      String bookingDate,
      double totalPrice,
      int movieId,
      int cardId,
      int cinemaId,
      List<SnacksVO> boughtSnacks
      ) {

    CheckOutVO checkOutVO = CheckOutVO(
        timeSlotId,
        seatRow,
        seatName,
        bookingDate,
        totalPrice,
        movieId,
        chooseCard?.id,
        cinemaId,
        boughtSnacks);

    return cinemaModel.checkOut(checkOutVO).then((value) {
      userBooking = value;
      notifyListeners();
      return Future.value(value);
    });
  }

}