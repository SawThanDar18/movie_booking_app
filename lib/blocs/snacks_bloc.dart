import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/cinema_model.dart';
import 'package:movie_booking_app/data/models/cinema_model_impl.dart';
import 'package:movie_booking_app/data/vos/cinema/payment_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';

class SnacksBloc extends ChangeNotifier {

  CinemaModel cinemaModel = CinemaModelImpl();

  List<SnacksVO>? snacks;
  List<PaymentVO>? paymentMethods;

  double subTotal = 0;
  double payTotalPrice = 0;
  int? quantity;
  int? selectPaymentId;

  List<SnacksVO> boughtSnacks = [];

  SnacksBloc(double subTotal) {
    cinemaModel.getSnacksFromDatabase().listen((snacksList) {
        snacks = snacksList;
        this.subTotal = subTotal;
        payTotalPrice = this.subTotal;
        notifyListeners();
    });

    cinemaModel.getPaymentMethodsFromDatabase().listen((paymentMethods) {
        this.paymentMethods = paymentMethods;
        notifyListeners();
    }).onError((error) => debugPrint(error.toString()));
  }

  void onTapPaymentMethod(int cardId) {

    paymentMethods?.map((paymentMethod) {
      if (paymentMethod.id == cardId) {
        paymentMethod.isSelected = true;
        selectPaymentId = cardId;
      } else {
        paymentMethod.isSelected = false;
      }
    }).toList();
    notifyListeners();
  }

  void onTapIncrease (SnacksVO? snacksVO) {
    snacks?.map((each) {
      if (each.id == snacksVO?.id) {
        each.quantity = (each.quantity ?? 0) + 1;
      }
    }).toList();

    subTotal += snacksVO?.snackPrice ?? 0;
    payTotalPrice = subTotal;
    notifyListeners();
  }

  void onTapDecrease (SnacksVO? snacksVO) {

    if ((snacksVO?.quantity ?? 0) > 0) {
      subTotal -= snacksVO?.snackPrice ?? 0;
      payTotalPrice = subTotal;
    }

    snacks?.map((each) {
      if (each.id == snacksVO?.id) {
        if ((each.quantity ?? 0) > 0) {
          each.quantity = (each.quantity ?? 0) - 1;
        }
      }
    }).toList();

    notifyListeners();
  }

  void savedSelectedSnacks() {
    var length = snacks?.length ?? 0;
    for (int i=0; i<length; i++) {
      var amount = snacks?[i].quantity ?? 0;
      if (amount > 0) {
          boughtSnacks.add(snacks![i]);
          notifyListeners();
      }
    }
  }

}