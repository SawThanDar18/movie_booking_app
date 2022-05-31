import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/cinema_model.dart';
import 'package:movie_booking_app/data/models/cinema_model_impl.dart';

class AddNewCardBloc extends ChangeNotifier {
  CinemaModel cinemaModel = CinemaModelImpl();

  AddNewCardBloc([CinemaModel? mCinemaModel]) {
    if (mCinemaModel != null) {
      cinemaModel = mCinemaModel;
    }
  }

  Future<void> addCard(String cardNumber, String cardHolderName,
      String expirationDate, String cvc) {
    return cinemaModel
        .addCard(cardNumber, cardHolderName, expirationDate, cvc)
        .then((value) {
      cinemaModel.getProfile();
    }).catchError((error) => debugPrint(error.toString()));
    // return cinemaModel.addCard(cardNumber, cardHolderName, expirationDate, cvc);
  }

  Future<void> getUserProfile() {
    return cinemaModel.getProfile();
  }
}
