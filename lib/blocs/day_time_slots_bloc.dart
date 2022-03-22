import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:movie_booking_app/data/models/cinema_model.dart';
import 'package:movie_booking_app/data/models/cinema_model_impl.dart';
import 'package:movie_booking_app/data/vos/cinema/date_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/day_time_slots_vo.dart';

class DayTimeSlotsBloc extends ChangeNotifier{

  CinemaModel cinemaModel = CinemaModelImpl();

  List<DayTimeSlotsVO>? dayTimeSlots;

  int? timeSlotId;
  String? time;
  String? cinemaName;
  int? cinemaId;
  String? token;
  String? choosingDate;

  List<DateVO> datesList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14].map((numberOfDays) {
    return DateTime.now().add(Duration(days: numberOfDays));
  }).map((dateTime) {
    return DateVO(DateFormat('yyyy-MM-dd').format(dateTime), DateFormat('EEEE').format(dateTime), false);
  }).toList();

  DayTimeSlotsBloc(int movieId) {

    datesList.first.isSelected = true;
    _getCinemaDayTimeSlots(movieId, getSelectedDate());
  }

  String getSelectedDate() {

      String selectedDate = datesList
          .where((date) => date.isSelected == true)
          .toList()
          .first
          .date
          .toString();
      return selectedDate;
  }

  void selectedDate(int movieId, int index) {

    datesList.map((date) {
        date.isSelected = false;
      }).toList();

    datesList[index].isSelected = true;
    _getCinemaDayTimeSlots(movieId, getSelectedDate());
  }

  void onTapTimeSlots(int timeSlotId, String time, String cinemaName, int cinemaId) {

    this.timeSlotId = timeSlotId;
    this.time = time;
    this.cinemaName = cinemaName;
    this.cinemaId = cinemaId;
    var dayTimeList =  dayTimeSlots?.map((cinema) {
      cinema.timeSlots.map((element) {
        if (element?.dayTimeSlotsId == timeSlotId) {
          dayTimeSlots = cinema as List<DayTimeSlotsVO>?;
          cinemaId = cinema.cinemaId ?? 0;
        }
      });
    }).toList();
    notifyListeners();
  }

  _getCinemaDayTimeSlots(int movieId, String date) {

    cinemaModel.getCinemaDayTimeSlotsFromDatabase(movieId, date).listen((cinemaDayTimeSlots) {
        dayTimeSlots = cinemaDayTimeSlots;
        notifyListeners();
    }).onError((error) => error.toString());
  }



}