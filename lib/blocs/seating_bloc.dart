import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/models/cinema_model.dart';
import 'package:movie_booking_app/data/models/cinema_model_impl.dart';
import 'package:movie_booking_app/data/vos/cinema/seats_vo.dart';
import 'package:movie_booking_app/utils/constants.dart';

class SeatingBloc extends ChangeNotifier {
  CinemaModel cinemaModel = CinemaModelImpl();

  List<SeatsVO>? movieSeats;
  SeatsVO? seatsVO;
  List<String> seats = [];
  int? columnCountInRow;
  int tickets = 0;
  double totalPrice = 0;

  String chooseSeatRow = "";
  String chooseSeatName = "";

  SeatingBloc(int timeSlotId, String choosingDate) {
    cinemaModel.getCinemaSeatingPlan(timeSlotId, choosingDate).then((value) {
      movieSeats = value?[0] as List<SeatsVO>;
      columnCountInRow = value?[1] as int;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void onTapSeat(SeatsVO? seat) {
    if (seat?.type == SEAT_TYPE_AVAILABLE) {
      List<SeatsVO>? seatsList = movieSeats;
      seatsList?.map((each) {
        if (each.id == seat?.id && each.symbol == seat?.symbol) {
          each.isSelected = (seat?.isSelected == false) ? true : false;
        }
      }).toList();

      if (seat?.isSelected == true) {
        seats.add(seat?.seatName ?? "");
        totalPrice += seat?.price ?? 0;
        tickets += 1;
      } else {
        seats.remove(seat?.seatName ?? "");
        totalPrice -= seat?.price ?? 0;
        tickets -= 1;
      }

      movieSeats = seatsList;

      var mapList = Map.fromIterable(seats,
          key: (e) => e[0], value: (e) => e.toString().substring(2, 3));

      chooseSeatRow = mapList.keys.join(",");
      chooseSeatName = seats.join(",");

      notifyListeners();
    }
  }
}
