import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:movie_booking_app/blocs/day_time_slots_bloc.dart';
import 'package:movie_booking_app/data/vos/cinema/date_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/day_time_slots_vo.dart';
import 'package:movie_booking_app/pages/seating_chart_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/floating_button_view.dart';
import 'package:provider/provider.dart';

import '../config/config_value.dart';
import '../config/environment_config.dart';

class CinemaDayTimeSlotPage extends StatelessWidget {
  final int movieId;
  final String movieTitle;
  final String moviePoster;

  CinemaDayTimeSlotPage(
      {required this.movieId,
      required this.movieTitle,
      required this.moviePoster});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return ChangeNotifierProvider(
      create: (BuildContext context) => DayTimeSlotsBloc(movieId),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            Selector<DayTimeSlotsBloc, List<DateVO>?>(
              selector: (context, bloc) => bloc.datesList,
              shouldRebuild: (previous, next) => previous != next,
              builder: (BuildContext context, dateLists, Widget? child) {
                DayTimeSlotsBloc dayTimeSlotsBloc =
                    Provider.of<DayTimeSlotsBloc>(context, listen: false);
                return SliverAppBarView(
                  onTapView: () => Navigator.pop(context),
                  onTapDate: (index) =>
                      dayTimeSlotsBloc.selectedDate(movieId, index),
                  datesList: dateLists ?? [],
                );
              },
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Selector<DayTimeSlotsBloc, List<DayTimeSlotsVO>?>(
                  selector: (context, bloc) => bloc.dayTimeSlots,
                  shouldRebuild: (previous, next) => previous != next,
                  builder: (BuildContext context, dayTimeSlots, Widget? child) {
                    return TimeSlotsItemView(
                      key: Key("13"),
                      dayTimeSlots: dayTimeSlots ?? [],
                      onTapView: (int timeSlotId, String time,
                          String cinemaName, int cinemaId) {
                        DayTimeSlotsBloc dayTimeSlotsBloc =
                            Provider.of(context, listen: false);
                        dayTimeSlotsBloc.onTapTimeSlots(
                            timeSlotId, time, cinemaName, cinemaId);
                      },
                    );
                  },
                ),
              ]),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Selector<DayTimeSlotsBloc, List<DayTimeSlotsVO>?>(
          selector: (context, bloc) => bloc.dayTimeSlots,
          builder: (context, dayTimeSlots, child) => FloatingButtonView(
            onTapView: () {
              _navigateToSeatingChartPage(context);
            },
            text: 'Next',
          ),
        ),
      ),
    );
  }

  _navigateToSeatingChartPage(BuildContext context) {
    DayTimeSlotsBloc dayTimeSlotsBloc = Provider.of(context, listen: false);
    if (dayTimeSlotsBloc.getSelectedDate() != null &&
        dayTimeSlotsBloc.timeSlotId != null &&
        dayTimeSlotsBloc.time != null &&
        dayTimeSlotsBloc.cinemaId != null &&
        dayTimeSlotsBloc.cinemaName != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SeatingChartPage(
                  choosingDate: dayTimeSlotsBloc.getSelectedDate(),
                  timeSlotId: dayTimeSlotsBloc.timeSlotId ?? 0,
                  movieId: movieId,
                  movieTitle: movieTitle,
                  moviePoster: moviePoster,
                  time: dayTimeSlotsBloc.time ?? "",
                  cinemaId: dayTimeSlotsBloc.cinemaId ?? 0,
                  cinemaName: dayTimeSlotsBloc.cinemaName ?? "")));
    } else {
      print("null");
    }
  }
}

class TimeSlotsItemView extends StatefulWidget {
  final List<DayTimeSlotsVO>? dayTimeSlots;
  final Function(int timeSlotId, String time, String cinemaName, int cinemaId)
      onTapView;

  TimeSlotsItemView(
      {Key? key, required this.dayTimeSlots, required this.onTapView})
      : super(key: key);

  @override
  State<TimeSlotsItemView> createState() => _TimeSlotsItemViewState();
}

class _TimeSlotsItemViewState extends State<TimeSlotsItemView> {
  @override
  Widget build(BuildContext context) {
    List<DayTimeSlotsVO>? dayTimeLists = widget.dayTimeSlots ?? [];
    int? timeSlotId;
    String? time;
    String? cinemaName;
    int? cinemaId;

    return Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: dayTimeLists.length,
          itemBuilder: (BuildContext context, int dayTimeSlotsIndex) {
            return Container(
              margin: EdgeInsets.only(left: MARGIN_16, right: MARGIN_16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dayTimeLists[dayTimeSlotsIndex].cinemaName ?? "",
                    style: TextStyle(
                      color: SLIVER_LABEL_COLOR,
                      fontWeight: FontWeight.w700,
                      fontSize: FONT_SIZE_20,
                    ),
                  ),
                  SizedBox(
                    height: SIZED_BOX_HEIGHT_30,
                  ),
                  Container(
                      height: 60,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            dayTimeLists[dayTimeSlotsIndex].timeSlots.length,
                        gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.8,
                        ),
                        itemBuilder: (BuildContext context, int timeSlotIndex) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  dayTimeLists.forEach((each) {
                                    each.timeSlots.forEach((timeSlot) {
                                      timeSlot?.isSelected = false;
                                    });
                                  });
                                  dayTimeLists[dayTimeSlotsIndex]
                                      .timeSlots[timeSlotIndex]
                                      ?.isSelected = true;
                                  timeSlotId = dayTimeLists[dayTimeSlotsIndex]
                                      .timeSlots[timeSlotIndex]
                                      ?.dayTimeSlotsId;
                                  print(
                                      "timeSlotIIDDD>>>${dayTimeLists[dayTimeSlotsIndex].timeSlots[timeSlotIndex]?.dayTimeSlotsId}");
                                  time = dayTimeLists[dayTimeSlotsIndex]
                                      .timeSlots[timeSlotIndex]
                                      ?.startTime;
                                  cinemaName = dayTimeLists[dayTimeSlotsIndex]
                                      .cinemaName;
                                  cinemaId =
                                      dayTimeLists[dayTimeSlotsIndex].cinemaId;

                                  widget.onTapView(timeSlotId ?? 0, time ?? "",
                                      cinemaName ?? "", cinemaId ?? 0);
                                });
                              },
                              child: Container(
                                child: new Center(
                                  child: new Text(
                                      dayTimeLists[dayTimeSlotsIndex]
                                              .timeSlots[timeSlotIndex]
                                              ?.startTime ??
                                          "",
                                      style: new TextStyle(
                                          color: dayTimeLists[dayTimeSlotsIndex]
                                                      .timeSlots[timeSlotIndex]
                                                      ?.isSelected ==
                                                  true
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: FONT_SIZE_14)),
                                ),
                                decoration: new BoxDecoration(
                                  color: dayTimeLists[dayTimeSlotsIndex]
                                              .timeSlots[timeSlotIndex]
                                              ?.isSelected ==
                                          true
                                      ? THEME_COLOR[
                                          EnvironmentConfig.CONFIG_THEME_COLOR]
                                      : Colors.white,
                                  border: dayTimeLists[dayTimeSlotsIndex]
                                              .timeSlots[timeSlotIndex]
                                              ?.isSelected !=
                                          true
                                      ? Border.all(color: Colors.grey)
                                      : null,
                                  borderRadius: const BorderRadius.all(
                                      const Radius.circular(BORDER_RADIUS)),
                                ),
                              ),
                            ),
                          );
                        },
                      )),
                  SizedBox(
                    height: SIZED_BOX_HEIGHT_30,
                  ),
                ],
              ),
            );
          },
        ));
  }
}

class SliverAppBarView extends StatefulWidget {
  final Function onTapView;
  final Function(int index) onTapDate;
  final List<DateVO> datesList;

  SliverAppBarView(
      {required this.onTapView,
      required this.onTapDate,
      required this.datesList});

  @override
  State<SliverAppBarView> createState() => _SliverAppBarViewState();
}

class _SliverAppBarViewState extends State<SliverAppBarView> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: THEME_COLOR[EnvironmentConfig.CONFIG_THEME_COLOR],
      expandedHeight: CHOOSING_TIME_SLIVER_EXPENDED_HEIGHT,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            background: Stack(
              children: [
                Positioned.fill(
                  child: ListView.separated(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        width: 0,
                      );
                    },
                    itemCount: widget.datesList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: EdgeInsets.only(
                            right: MARGIN_16, top: MARGIN_50, left: MARGIN_16),
                        width: 40,
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  widget.onTapDate(index);
                                });
                              },
                              child: Text(
                                "${widget.datesList[index].weekOfDay?.substring(0, 3)}",
                                style: TextStyle(
                                  color: (widget.datesList[index].isSelected ==
                                          true)
                                      ? Colors.white
                                      : Colors.grey,
                                  fontSize: FONT_SIZE_18,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: SIZED_BOX_HEIGHT_10,
                            ),
                            Text(
                              "${widget.datesList[index].date?.substring(8, 10)}",
                              style: TextStyle(
                                color:
                                    (widget.datesList[index].isSelected == true)
                                        ? Colors.white
                                        : Colors.grey,
                                fontSize: FONT_SIZE_18,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: MARGIN_MEDIUM_3,
                      left: MARGIN_CARD_MEDIUM_2,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        this.widget.onTapView();
                      },
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                        size: BACK_ARROW_ICON_SIZE,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: ROUND_CORNER_HEIGHT,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(ROUND_CORNER_RADIUS),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class SliverAppBarView extends StatelessWidget {
//   final Function onTapView;
//   final Function(String choosingDate) onTapCalendar;
//
//   SliverAppBarView({required this.onTapView, required this.onTapCalendar});
//
//   @override
//   Widget build(BuildContext context) {
//     return SliverAppBar(
//       automaticallyImplyLeading: false,
//       backgroundColor: SPLASH_SCREEN_BACKGROUND_COLOR,
//       expandedHeight: CHOOSING_TIME_SLIVER_EXPENDED_HEIGHT,
//       flexibleSpace: Stack(
//         children: [
//           FlexibleSpaceBar(
//             background: Stack(
//               children: [
//                 Positioned.fill(
//                     child: CalendarView(onTapView: (String date) {
//                       this.onTapCalendar(date);
//                     })
//                 ),
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: Padding(
//                     padding: EdgeInsets.only(
//                       top: MARGIN_MEDIUM_3,
//                       left: MARGIN_CARD_MEDIUM_2,
//                     ),
//                     child: GestureDetector(
//                       onTap: () {
//                         this.onTapView();
//                       },
//                       child: Icon(
//                         Icons.arrow_back_ios_rounded,
//                         color: Colors.white,
//                         size: BACK_ARROW_ICON_SIZE,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               height: ROUND_CORNER_HEIGHT,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.vertical(
//                   top: Radius.circular(ROUND_CORNER_RADIUS),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CalendarView extends StatefulWidget {
  final Function(String choosingDate) onTapView;

  CalendarView({required this.onTapView});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  String? choosingDate;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MARGIN_50),
      child: CalendarWeek(
        height: CALENDAR_HEIGHT,
        minDate: DateTime.now().add(
          Duration(days: -365),
        ),
        maxDate: DateTime.now().add(
          Duration(days: 365),
        ),
        dayOfWeekStyle: TextStyle(color: Colors.grey),
        //dayOfWeekAlignment: FractionalOffset.bottomCenter,
        dateStyle: TextStyle(color: Colors.grey),
        //dateAlignment: FractionalOffset.topCenter,
        todayDateStyle: TextStyle(
            color: SPLASH_SCREEN_BACKGROUND_COLOR, fontWeight: FontWeight.bold),
        pressedDateBackgroundColor: Colors.white,
        pressedDateStyle: TextStyle(
            color: SPLASH_SCREEN_BACKGROUND_COLOR, fontWeight: FontWeight.bold),
        dateBackgroundColor: SPLASH_SCREEN_BACKGROUND_COLOR,
        backgroundColor: SPLASH_SCREEN_BACKGROUND_COLOR,
        onDatePressed: (DateTime date) {
          setState(() {
            choosingDate = "${date.year}-${date.month}-${date.day}";
            widget.onTapView(choosingDate!);
          });
        },
      ),
    );
  }
}

/*
class CinemaDayTimeSlotPage extends StatefulWidget {
  final int movieId;
  final String movieTitle;
  final String moviePoster;

  CinemaDayTimeSlotPage(
      {required this.movieId,
        required this.movieTitle,
        required this.moviePoster});

  @override
  State<CinemaDayTimeSlotPage> createState() => _CinemaDayTimeSlotPageState();
}

class _CinemaDayTimeSlotPageState extends State<CinemaDayTimeSlotPage> {
  List<DayTimeSlotsVO>? dayTimeSlots;

  int? timeSlotId;
  String? time;
  String? cinemaName;
  int? cinemaId;
  String? token;
  String? choosingDate;

  CinemaModel cinemaModel = CinemaModelImpl();

  var datesList = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14].map((numberOfDays) {
    return DateTime.now().add(Duration(days: numberOfDays));
  }).map((dateTime) {
    return DateVO(DateFormat('yyyy-MM-dd').format(dateTime), DateFormat('EEEE').format(dateTime), false);
  }).toList();

  String getSelectedDate() {
    String selectedDate = datesList
        .where((date) => date.isSelected == true)
        .toList()
        .first
        .date.toString();
    return selectedDate;
  }

  @override
  void initState() {
    datesList.first.isSelected = true;
    _getCinemaDayTimeSlots(widget.movieId, getSelectedDate());

    super.initState();
  }

  _selectedDate(int index) {
    setState(() {
      datesList.forEach((date) {
        date.isSelected = false;
      });
      datesList[index].isSelected = true;
      _getCinemaDayTimeSlots(widget.movieId, getSelectedDate());
    });
  }

  _getCinemaDayTimeSlots(int movieId, String date) {
    // cinemaModel.getCinemaDayTimeSlots(movieId, date).then((data) {
    //   setState(() {
    //     dayTimeSlots = data;
    //   });
    // }).catchError((error) => debugPrint(error.toString()));

    print("Dateeee>>>> $date");
    cinemaModel.getCinemaDayTimeSlotsFromDatabase(movieId, date).listen((cinemaDayTimeSlots) {
      setState(() {
        dayTimeSlots = cinemaDayTimeSlots;
      });
    }).onError((error) => error.toString());
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return ChangeNotifierProvider(
      create: (BuildContext context) => DayTimeSlotsBloc(widget.movieId) ,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            Selector <DayTimeSlotsBloc, List<DateVO>?>(
              selector: (context, bloc) => bloc.dateLists,
              builder: (BuildContext context, dateLists, Widget? child) {
                DayTimeSlotsBloc dayTimeSlotsBloc = Provider.of<DayTimeSlotsBloc>(context,listen: false);
                return  SliverAppBarView(
                  onTapView: () => Navigator.pop(context),
                  onTapDate: (index) => dayTimeSlotsBloc.selectedDate(widget.movieId, index),
                  datesList: dateLists ?? [],
                );
              },
            ),
            // SliverAppBarView(
            //   onTapView: () => Navigator.pop(context),
            //   onTapDate: (index) => _selectedDate(index),
            //   datesList: datesList,
            // ),
            SliverList(
              delegate: SliverChildListDelegate([
                Selector <DayTimeSlotsBloc, List<DayTimeSlotsVO>?>(
                  selector: (context, bloc) => bloc.dayTimeSlots,
                  builder: (BuildContext context, dayTimeSlots, Widget? child) {
                    return  TimeSlotsItemView(
                      dayTimeSlots: dayTimeSlots ?? [],
                      onTapView: (int timeSlotId, String time, String cinemaName,
                          int cinemaId) {
                        DayTimeSlotsBloc dayTimeSlotsBloc = Provider.of(context, listen: false);
                        dayTimeSlotsBloc.timeSlotId = timeSlotId;
                        dayTimeSlotsBloc.time = time;
                        dayTimeSlotsBloc.cinemaName = cinemaName;
                        dayTimeSlotsBloc.cinemaId = cinemaId;
                      },
                    );
                  },
                ),
                // TimeSlotsItemView(
                //   dayTimeSlots: dayTimeSlots ?? [],
                //   onTapView: (int timeSlotId, String time, String cinemaName,
                //       int cinemaId) {
                //     this.timeSlotId = timeSlotId;
                //     this.time = time;
                //     this.cinemaName = cinemaName;
                //     this.cinemaId = cinemaId;
                //   },
                // ),
              ]),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingButtonView(
          onTapView: () {
            DayTimeSlotsBloc dayTimeSlotsBloc = Provider.of(context, listen: false);
            _navigateToSeatingChartPage(context, getSelectedDate(), dayTimeSlotsBloc.timeSlotId, dayTimeSlotsBloc.time, dayTimeSlotsBloc.cinemaId, dayTimeSlotsBloc.cinemaName);
          },
          text: 'Next',
        ),
      ),
    );
  }

  _navigateToSeatingChartPage(
      BuildContext context,
      String? choosingDate,
      int? timeSlotId,
      String? time,
      int? cinemaId,
      String? cinemaName) {
    if (choosingDate != null &&
        timeSlotId != null &&
        time != null &&
        cinemaId != null &&
        cinemaName != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SeatingChartPage(
                  choosingDate: choosingDate,
                  timeSlotId: timeSlotId,
                  movieId: widget.movieId,
                  movieTitle: widget.movieTitle,
                  moviePoster: widget.moviePoster,
                  time: time,
                  cinemaId: cinemaId,
                  cinemaName: cinemaName)));
    }
  }
}*/
