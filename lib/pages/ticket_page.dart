import 'package:barcode_widget/barcode_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/vos/cinema/user_booking_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/pages/home_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/dash_view.dart';
import 'package:movie_booking_app/widgets/text_row_view.dart';
import 'package:movie_booking_app/widgets/text_view.dart';
import 'package:movie_booking_app/widgets/title_and_label_text_view.dart';

class TicketPage extends StatefulWidget {
  final String movieName;
  final String moviePoster;
  final String cinemaName;
  final UserBookingVO userBooking;

  TicketPage({required this.movieName, required this.moviePoster, required this.cinemaName, required this.userBooking});

  @override
  State<TicketPage> createState() => _TicketPageState();
}

class _TicketPageState extends State<TicketPage> {
  UserBookingVO? userBookingVO;

  @override
  void initState() {

    userBookingVO = widget.userBooking;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TICKET_PAGE_BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: TICKET_PAGE_BACKGROUND_COLOR,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          child: Container(
            margin: EdgeInsets.only(top: MARGIN_20, left: MARGIN_20),
            child: Icon(
              Icons.clear,
              color: Colors.black,
              size: CLEAR_ICON_SIZE,
            ),
          ),
        ),
      ),
      body: Container(
        color: TICKET_PAGE_BACKGROUND_COLOR,
        margin: EdgeInsets.only(top: MARGIN_10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleAndLabelTextView("Awesome!", "This is your ticket."),
              ImageAndTitleContainerView(movieTitle: widget.movieName, moviePoster: widget.moviePoster,),
              DashLineView(),
              TicketInfoView(userBookingVO: userBookingVO, cinemaName: widget.cinemaName),
              DashLineView(),
              BarCodeView(),
              SizedBox(
                height: SIZED_BOX_HEIGHT_50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BarCodeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: MARGIN_30, right: MARGIN_30),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(CHIP_BORDER_RADIUS),
            topRight: Radius.circular(CHIP_BORDER_RADIUS),
            bottomLeft: Radius.circular(BORDER_RADIUS_10),
            bottomRight: Radius.circular(BORDER_RADIUS_10)),
      ),
      width: MediaQuery.of(context).size.width,
      height: TICKET_PAGE_CONTAINER_HEIGHT_3,
      child: Container(
        margin: EdgeInsets.only(left: MARGIN_30, right: MARGIN_30),
        alignment: Alignment.center,
        child: BarcodeWidget(
          barcode: Barcode.code128(),
          data: "Movie Booking App",
          width: MediaQuery.of(context).size.width,
          height: BAR_CODE_HEIGHT,
        ),
      ),
    );
  }
}

class TicketInfoView extends StatelessWidget {
  final UserBookingVO? userBookingVO;
  final String? cinemaName;

  TicketInfoView({required this.userBookingVO, required this.cinemaName});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: MARGIN_30, right: MARGIN_30),
      width: MediaQuery.of(context).size.width,
      height: TICKET_PAGE_CONTAINER_HEIGHT_2,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(CHIP_BORDER_RADIUS)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: SIZED_BOX_HEIGHT_30,
          ),
          TextRowView(
            "Booking no",
            userBookingVO?.bookingNo ?? "",
            textSize: FONT_SIZE_16,
          ),
          SizedBox(
            height: SIZED_BOX_HEIGHT_20,
          ),
          TextRowView(
            "Show time - Date",
            "${userBookingVO?.timeSlotsVO?.startTime} - ${userBookingVO?.bookingDate}",
            textSize: FONT_SIZE_16,
          ),
          SizedBox(
            height: SIZED_BOX_HEIGHT_20,
          ),
          TextRowView(
            "Theater",
            "Galaxy Cinema - $cinemaName",
            textSize: FONT_SIZE_16,
          ),
          SizedBox(
            height: SIZED_BOX_HEIGHT_20,
          ),
          TextRowView(
            "Screen",
            "2",
            textSize: FONT_SIZE_16,
          ),
          SizedBox(
            height: SIZED_BOX_HEIGHT_20,
          ),
          TextRowView(
            "Row",
            userBookingVO?.row ?? "",
            textSize: FONT_SIZE_16,
          ),
          SizedBox(
            height: SIZED_BOX_HEIGHT_20,
          ),
          TextRowView(
            "Seat",
            userBookingVO?.seat ?? "",
            textSize: FONT_SIZE_16,
          ),
          SizedBox(
            height: SIZED_BOX_HEIGHT_20,
          ),
          TextRowView(
            "Price",
            "${userBookingVO?.total}.00",
            textSize: FONT_SIZE_16,
          ),
          SizedBox(
            height: SIZED_BOX_HEIGHT_30,
          ),
        ],
      ),
    );
  }
}

class DashLineView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(left: MARGIN_45, right: MARGIN_45),
      child: DashView(),
    );
  }
}

class ImageAndTitleContainerView extends StatelessWidget {
  final String movieTitle;
  final String moviePoster;

  ImageAndTitleContainerView({required this.movieTitle, required this.moviePoster});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MARGIN_20,
        left: MARGIN_30,
        right: MARGIN_30,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(CHIP_BORDER_RADIUS),
          bottomRight: Radius.circular(CHIP_BORDER_RADIUS),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: TICKET_PAGE_CONTAINER_HEIGHT,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(BORDER_RADIUS_10),
              topRight: Radius.circular(BORDER_RADIUS_10),
            ),
            child: Image.network("$IMAGE_BASE_URL$moviePoster", width: MediaQuery.of(context).size.width,
              height: TICKET_PAGE_IMAGE_HEIGHT,
              fit: BoxFit.cover,),
            // child:  CachedNetworkImage(
            //   imageUrl: '$IMAGE_BASE_URL$moviePoster',
            //       width: MediaQuery.of(context).size.width,
            //       height: TICKET_PAGE_IMAGE_HEIGHT,
            //       fit: BoxFit.cover,
            //   placeholder: (context, url) => Image.asset(
            //     "assets/images/movie_loading.jpg",
            //     fit: BoxFit.cover,
            //   ),
            //   errorWidget: (context, url, error) => Icon(Icons.error_outlined, color: SPLASH_SCREEN_BACKGROUND_COLOR,),
            // ),
          ),
          Container(
            margin: EdgeInsets.only(left: MARGIN_16, top: MARGIN_5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextView(
                  this.movieTitle,
                  TICKET_PAGE_TITLE_COLOR,
                  FONT_SIZE_20,
                ),
                SizedBox(
                  height: SIZED_BOX_HEIGHT_5,
                ),
                TextView(
                  "105m - IMAX",
                  TICKET_PAGE_LABEL_COLOR,
                  FONT_SIZE_18,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
