import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_week/calendar_week.dart';
import 'package:movie_booking_app/pages/seating_chart_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/floating_button_view.dart';

class ChoosingTimePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBarView(
            () => Navigator.pop(context),
            ""
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.only(left: MARGIN_16, right: MARGIN_16),
                  child: Column(
                    children: [
                      LabelView("Available In"),
                      SizedBox(
                        height: SIZED_BOX_HEIGHT_30,
                      ),
                      CustomRadio("2D", "3D", "IMAX"),
                      SizedBox(
                        height: SIZED_BOX_HEIGHT_30,
                      ),
                      LabelView("GC : Golden City"),
                      SizedBox(
                        height: SIZED_BOX_HEIGHT_30,
                      ),
                      CustomRadios("9:30 AM", "11:45 AM", "3:30 PM", "5:00 PM",
                          "7:00 PM", "9:30 PM"),
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
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => SeatingChartPage())
    // );
  }
}

class SliverAppBarView extends StatelessWidget {
  final Function onTapView;
  String date;

  SliverAppBarView(this.onTapView, this.date);

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
                  child: CalendarView(
                    choosingDate: date,
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

class CalendarView extends StatefulWidget {
  String choosingDate;

  CalendarView({required this.choosingDate});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {

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

class CustomRadio extends StatefulWidget {
  final String label_1, label_2, label_3;

  CustomRadio(this.label_1, this.label_2, this.label_3);

  @override
  createState() {
    return new CustomRadioState();
  }
}

class CustomRadioState extends State<CustomRadio> {
  List<RadioModel> sampleData = <RadioModel>[];

  @override
  void initState() {
    super.initState();
    sampleData.add(new RadioModel(false, widget.label_1));
    sampleData.add(new RadioModel(false, widget.label_2));
    sampleData.add(new RadioModel(false, widget.label_3));
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: GRID_VIEW_HEIGHT_50,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        children: new List<Widget>.generate(
          sampleData.length,
          (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  sampleData.forEach((element) => element.isSelected = false);
                  sampleData[index].isSelected = true;
                });
              },
              child: RadioItem(sampleData[index]),
            );
          },
        ),
      ),
    );
  }
}

class CustomRadios extends StatefulWidget {
  final String label_1, label_2, label_3, label_4, label_5, label_6;

  CustomRadios(this.label_1, this.label_2, this.label_3, this.label_4,
      this.label_5, this.label_6);

  @override
  createState() {
    return new CustomRadiosState();
  }
}

class CustomRadiosState extends State<CustomRadios> {
  List<RadioModel> sampleData = <RadioModel>[];

  @override
  void initState() {
    super.initState();
    sampleData.add(new RadioModel(false, widget.label_1));
    sampleData.add(new RadioModel(false, widget.label_2));
    sampleData.add(new RadioModel(false, widget.label_3));
    sampleData.add(new RadioModel(false, widget.label_4));
    sampleData.add(new RadioModel(false, widget.label_5));
    sampleData.add(new RadioModel(false, widget.label_6));
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: GRID_VIEW_HEIGHT_100,
      child: GridView.count(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        crossAxisCount: 3,
        childAspectRatio: 2.5,
        children: new List<Widget>.generate(
          sampleData.length,
          (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  sampleData.forEach((element) => element.isSelected = false);
                  sampleData[index].isSelected = true;
                });
              },
              child: RadioItem(sampleData[index]),
            );
          },
        ),
      ),
    );
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  RadioItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TimeView(_item),
      ],
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;

  RadioModel(this.isSelected, this.buttonText);
}

class TimeView extends StatelessWidget {
  final RadioModel _item;

  TimeView(this._item);

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: TIME_VIEW_CONTAINER_HEIGHT,
      width: TIME_VIEW_CONTAINER_WIDTH,
      child: new Center(
        child: new Text(_item.buttonText,
            style: new TextStyle(
                color: _item.isSelected ? Colors.white : Colors.black,
                fontSize: FONT_SIZE_14)),
      ),
      decoration: new BoxDecoration(
        color: _item.isSelected ? SPLASH_SCREEN_BACKGROUND_COLOR : Colors.white,
        border:
            _item.isSelected == false ? Border.all(color: Colors.grey) : null,
        borderRadius:
            const BorderRadius.all(const Radius.circular(BORDER_RADIUS)),
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
