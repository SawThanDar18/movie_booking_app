import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/cinema_model.dart';
import 'package:movie_booking_app/data/models/cinema_model_impl.dart';

class AddNewCardBloc extends ChangeNotifier {

  CinemaModel cinemaModel = CinemaModelImpl();

  AddNewCardBloc();

  Future<String?> addCard(String cardNumber, String cardHolderName, String expirationDate, String cvc) {
    return cinemaModel.addCard(cardNumber, cardHolderName, expirationDate, cvc)
        .then((value) {
      cinemaModel.getProfile();
    }).catchError((error) => debugPrint(error.toString()));
  }

}