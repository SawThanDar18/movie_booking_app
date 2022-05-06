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

  List<SeatsVO>? seatingList;

  List<String>? selectedSeat;
  double price = 0;
  Set<String>? selectedRow;

  List<String>? tempSelectedRowAsList;

  SeatingBloc(int timeSlotId, String choosingDate, [CinemaModel? mCinemaModel]) {
    if (mCinemaModel != null) {
      cinemaModel = mCinemaModel;
    }

    selectedSeat = [];
    price = 0;
    selectedRow = {};

    cinemaModel.getCinemaSeatingPlan(timeSlotId, choosingDate).then((value) {
      movieSeats = value?[0] as List<SeatsVO>;
      columnCountInRow = value?[1] as int;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });
  }

  void selectSeat(SeatsVO? seat) {
    SeatsVO? tempSelectedSeat = movieSeats?.firstWhere((seatFromList) => seatFromList.id == seat?.id && seatFromList.seatName == seat?.seatName);

    List<SeatsVO> tempSeatingList = movieSeats?.map((seat) => seat).toList() ?? [];
    List<String> tempSelectedSeatList = seats.map((seatName) => seatName).toList();
    List<String> tempSelectedRow = tempSelectedRowAsList ?? [];

    if (tempSelectedSeat?.isSelected == true) {
      tempSeatingList
          .firstWhere((seatFromList) => seatFromList == tempSelectedSeat)
          .isSelected = false;
      tempSelectedSeatList.remove(seat?.seatName);
      tempSelectedRow.remove(seat?.symbol);

      movieSeats = tempSeatingList;
      seats = tempSelectedSeatList;
      tempSelectedRowAsList = tempSelectedRow;

      totalPrice -= seat?.price ?? 0;
    } else {
      if (tempSelectedSeat?.type == SEAT_TYPE_AVAILABLE) {
        tempSeatingList
            .firstWhere((seatFromList) => seatFromList == tempSelectedSeat)
            .isSelected = true;

        tempSelectedSeatList.add(seat?.seatName ?? '');
        tempSelectedRow.add(seat?.symbol ?? '');

        movieSeats = tempSeatingList;
        seats = tempSelectedSeatList;
        tempSelectedRowAsList = tempSelectedRow;

        totalPrice += seat?.price ?? 0;
      }
    }
    notifyListeners();
  }

  int getSeatColumnCount() {
    String tempSymbol = seatingList?[0].symbol ?? 'A';
    int numberOfColumn = seatingList
        ?.where((seat) => seat.symbol == tempSymbol)
        .toList()
        .length ??
        1;
    return numberOfColumn;
  }

  String getSelectedRowAsFormattedString() {
    selectedRow = tempSelectedRowAsList?.toSet();
    return selectedRow?.toList().join(',') ?? '';
  }

  String getSelectedSeatAsFormattedString() {
    return selectedSeat?.toList().join(',') ?? '';
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
