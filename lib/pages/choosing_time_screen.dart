import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_week/calendar_week.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';

class ChoosingTimeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: SPLASH_SCREEN_BACKGROUND_COLOR,
        elevation: 0.0,
        leading: Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
          size: BACK_ARROW_ICON_SIZE,
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CalendarView(),
              Container(
                padding: EdgeInsets.only(
                  top: MARGIN_16,
                  left: MARGIN_16,
                  right: MARGIN_16,
                ),
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridLayoutView(),
                    GridLayoutView(),
                    GridLayoutView(),
                  ],
                ),
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(
                    top: MARGIN_16, left: MARGIN_16, right: MARGIN_16),
                decoration: BoxDecoration(
                  color: SPLASH_SCREEN_BACKGROUND_COLOR,
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      BORDER_RADIUS,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    "Next",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LabelView extends StatelessWidget {
  final String label;

  LabelView(this.label);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        label,
        style: TextStyle(
          color: SLIVER_LABEL_COLOR,
          fontWeight: FontWeight.w700,
          fontSize: FONT_SIZE_20,
        ),
      ),
    );
  }
}

class GridLayoutView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelView("Available In"),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            childAspectRatio: 2.5,
          ),
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                  top: MARGIN_16, left: MARGIN_16, right: MARGIN_16),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(
                  Radius.circular(BORDER_RADIUS),
                ),
                border: Border.all(color: Colors.grey),
              ),
              child: Center(
                child: Text("2D"),
              ),
            );
          },
        ),
      ],
    );
  }
}

class CalendarView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: CALENDAR_HEIGHT,
      child: CalendarWeek(
        height: CALENDAR_HEIGHT,
        minDate: DateTime.now().add(
          Duration(days: -365),
        ),
        maxDate: DateTime.now().add(
          Duration(days: 365),
        ),
        dayOfWeekStyle: TextStyle(color: Colors.grey),
        dayOfWeekAlignment: FractionalOffset.bottomCenter,
        dateStyle: TextStyle(color: Colors.grey),
        dateAlignment: FractionalOffset.topCenter,
        todayDateStyle: TextStyle(
            color: SPLASH_SCREEN_BACKGROUND_COLOR, fontWeight: FontWeight.bold),
        todayBackgroundColor: Colors.white,
        pressedDateBackgroundColor: Colors.white,
        pressedDateStyle: TextStyle(
            color: SPLASH_SCREEN_BACKGROUND_COLOR, fontWeight: FontWeight.bold),
        dateBackgroundColor: SPLASH_SCREEN_BACKGROUND_COLOR,
        backgroundColor: SPLASH_SCREEN_BACKGROUND_COLOR,
      ),
    );
  }
}
