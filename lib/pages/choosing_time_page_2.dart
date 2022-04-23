import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_week/flutter_calendar_week.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/floating_button_view.dart';

class ChoosingTimePage_2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBarView(
            () => Navigator.pop(context),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.only(left: MARGIN_16, right: MARGIN_16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TimeAndCinemaChoosingView(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingButtonView(
        onTapView: () => _navigateToSeatingChartPage(context),
        text: 'Next',
      ),
    );
  }

  _navigateToSeatingChartPage(BuildContext context) {
    //Navigator.push(context, MaterialPageRoute(builder: (context) => ChoosingTime()));
  }
}

class TimeAndCinemaChoosingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LabelView("Available In"),
        SizedBox(
          height: SIZED_BOX_HEIGHT_30,
        ),
        Container(
          margin: EdgeInsets.only(
            left: MARGIN_16,
            right: MARGIN_16,
          ),
          child: TimeChoosingRowView(
            "2D",
            "3D",
            "IMAX",
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: SIZED_BOX_HEIGHT_30,
        ),
        LabelView("GC : Golden City"),
        SizedBox(
          height: SIZED_BOX_HEIGHT_30,
        ),
        Container(
          margin: EdgeInsets.only(
            left: MARGIN_16,
            right: MARGIN_16,
          ),
          child: TimeChoosingRowView(
            "9:30 AM",
            "11:45 AM",
            "3:30 PM",
          ),
        ),
        SizedBox(
          height: SIZED_BOX_HEIGHT_20,
        ),
        Container(
          margin: EdgeInsets.only(
            left: MARGIN_16,
            right: MARGIN_16,
          ),
          child: TimeChoosingRowView(
            "5:00 PM",
            "7:00 PM",
            "9:30 PM",
          ),
        ),
        SizedBox(
          height: SIZED_BOX_HEIGHT_30,
        ),
        LabelView("GC : West Point"),
        SizedBox(
          height: SIZED_BOX_HEIGHT_30,
        ),
        Container(
          margin: EdgeInsets.only(
            left: MARGIN_16,
            right: MARGIN_16,
          ),
          child: TimeChoosingRowView(
            "9:30 AM",
            "10:30 AM",
            "1:30 PM",
          ),
        ),
        SizedBox(
          height: SIZED_BOX_HEIGHT_20,
        ),
        Container(
          margin: EdgeInsets.only(
            left: MARGIN_16,
            right: MARGIN_16,
          ),
          child: TimeChoosingRowView(
            "3:30 PM",
            "5:00 PM",
            "8:30 PM",
          ),
        ),
      ],
    );
  }
}

class TimeChoosingRowView extends StatelessWidget {
  final label_1, label_2, label_3;
  final FontWeight fontWeight;

  TimeChoosingRowView(
    this.label_1,
    this.label_2,
    this.label_3, {
    this.fontWeight = FontWeight.normal,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TimeView(
          label_1,
        ),
        TimeView(
          label_2,
        ),
        TimeView(
          label_3,
          fontWeight: fontWeight,
        ),
      ],
    );
  }
}

class SliverAppBarView extends StatelessWidget {
  final Function onTapView;

  SliverAppBarView(this.onTapView);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: SPLASH_SCREEN_BACKGROUND_COLOR,
      expandedHeight: CHOOSING_TIME_SLIVER_EXPENDED_HEIGHT,
      flexibleSpace: Stack(
        children: [
          FlexibleSpaceBar(
            background: Stack(
              children: [
                Positioned.fill(
                  child: Container(
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
                          color: SPLASH_SCREEN_BACKGROUND_COLOR,
                          fontWeight: FontWeight.bold),
                      todayBackgroundColor: Colors.white,
                      pressedDateBackgroundColor: Colors.white,
                      pressedDateStyle: TextStyle(
                          color: SPLASH_SCREEN_BACKGROUND_COLOR,
                          fontWeight: FontWeight.bold),
                      dateBackgroundColor: SPLASH_SCREEN_BACKGROUND_COLOR,
                      backgroundColor: SPLASH_SCREEN_BACKGROUND_COLOR,
                    ),
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
                        this.onTapView();
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

class TimeView extends StatefulWidget {
  final String text;
  final FontWeight fontWeight;

  TimeView(this.text, {this.fontWeight = FontWeight.normal});

  @override
  _TimeViewState createState() => _TimeViewState();
}

class _TimeViewState extends State<TimeView> {
  bool isTouching = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isTouching = !isTouching;
        });
      },
      child: Container(
        height: TIME_VIEW_CONTAINER_HEIGHT,
        width: TIME_VIEW_CONTAINER_WIDTH,
        decoration: BoxDecoration(
          color: isTouching == true
              ? SPLASH_SCREEN_BACKGROUND_COLOR
              : Colors.white,
          border: isTouching == false
              ? Border.all(
                  color: Colors.grey,
                )
              : null,
          borderRadius: BorderRadius.all(
            Radius.circular(BORDER_RADIUS),
          ),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: isTouching == true ? Colors.white : Colors.black,
              fontSize: FONT_SIZE_14,
              fontWeight: widget.fontWeight,
            ),
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
