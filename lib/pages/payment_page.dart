import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/blocs/payment_bloc.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';
import 'package:movie_booking_app/data/vos/users/card_vo.dart';
import 'package:movie_booking_app/pages/add_card_page.dart';
import 'package:movie_booking_app/pages/ticket_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/floating_button_view.dart';
import 'package:movie_booking_app/widgets/text_view.dart';
import 'package:provider/provider.dart';

class PaymentPage extends StatelessWidget {
  final String bookingDate;
  final int timeSlotId;
  final String timeSlot;
  final int cinemaId;
  final String cinemaName;
  final int movieId;
  final String movieName;
  final String moviePoster;
  final double totalPrice;
  final String seatRow;
  final String seatName;
  final int cardId;
  final List<SnacksVO> boughtSnacks;

  PaymentPage(
      {
      required this.bookingDate,
      required this.timeSlotId,
      required this.timeSlot,
      required this.cinemaId,
      required this.cinemaName,
      required this.movieId,
      required this.movieName,
      required this.moviePoster,
      required this.totalPrice,
      required this.seatRow,
      required this.seatName,
      required this.cardId,
      required this.boughtSnacks});


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PaymentBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.only(top: MARGIN_20),
              child: Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: BACK_ARROW_ICON_SIZE_40,
              ),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: MARGIN_20, left: MARGIN_20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView("Payment amount", TICKET_PAGE_LABEL_COLOR, FONT_SIZE_20),
              SizedBox(
                height: SIZED_BOX_HEIGHT_10,
              ),
              TextView(
                "\$ $totalPrice",
                Colors.black,
                FONT_SIZE_25,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_20,
              ),
              Selector<PaymentBloc, List<CardVO>?>(
                selector: (context, bloc) => bloc.cards,
                builder:
                    (BuildContext context, cards,
                    Widget? child) {
                  return CarouselSliderView(
                      cards: cards ?? [],
                      onTapView: (index) {
                        PaymentBloc paymentBloc = Provider.of(context, listen: false);
                        paymentBloc.carouselSliderChange(index);
                      });
                },
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_20,
              ),
              AddCardRowView(
                () => _navigateToAddCardPage(context),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:  Builder(
          builder: (context) => FloatingButtonView(
            onTapView: () {
              PaymentBloc paymentBloc = Provider.of(context, listen: false);
              print("t $timeSlotId");
              print("t $seatRow");
              print("t $seatName");
              print("t $bookingDate");
              print("t $totalPrice");
              print("t $movieId");
              print("t $cardId");
              print("t $cinemaId");
              print("t $boughtSnacks");
              paymentBloc.checkout(timeSlotId, seatRow, seatName, bookingDate, totalPrice, movieId, cardId, cinemaId, boughtSnacks).then((value) {
                _navigateToTicketPage(context);
              }).catchError((error) {
                debugPrint(error.toString());
              });
            },
            text: 'Purchase',
          ),
        ),

        /*Selector<PaymentBloc, UserBookingVO?>(
          selector: (context, bloc) => bloc.userBooking,
          builder: (context, userBooking, child) => FloatingButtonView(
            onTapView: () {
              print("seat $seatName");
              PaymentBloc paymentBloc = Provider.of(context, listen: false);
              paymentBloc.checkout(timeSlotId, seatRow, seatName, bookingDate, totalPrice, movieId, cardId, cinemaId, boughtSnacks).then((value) {
                _navigateToTicketPage(context);
              }).catchError((error) {
                debugPrint(error.toString());
              });
            },
            text: 'Purchase',
          ),
        ),*/
      ),
    );
  }

  _navigateToTicketPage(BuildContext context) {
    PaymentBloc paymentBloc = Provider.of(context, listen: false);
    if (paymentBloc.userBooking != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TicketPage(
                  movieName: movieName,
                  moviePoster: moviePoster,
                  cinemaName: cinemaName,
                  userBooking: paymentBloc.userBooking!)));
    }
  }

  Future<dynamic> _navigateToAddCardPage(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCardPage(),
      ),
    );

  }
}

class CarouselSliderView extends StatelessWidget {
  final List<CardVO> cards;
  final Function(int index) onTapView;

  CarouselSliderView({required this.cards, required this.onTapView});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: cards.length,
      options: CarouselOptions(
        height: CAROUSEL_SLIDER_HEIGHT,
        enlargeCenterPage: true,
        initialPage: 1,
        reverse: false,
        enableInfiniteScroll: false,
        scrollDirection: Axis.horizontal,
        onPageChanged: (index, _) {
          onTapView(index);
        },
      ),
      itemBuilder: (context, index, pageIndex) {
        return CarouselItemView(
          cards: cards[index],
        );
      },
    );
  }
}

class AddCardRowView extends StatelessWidget {
  final Function onTapView;

  AddCardRowView(this.onTapView);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTapView();
      },
      child: Container(
        child: Row(
          children: [
            Icon(
              Icons.add_circle,
              color: Colors.green,
              size: ICON_SIZE_20,
            ),
            SizedBox(
              width: SIZED_BOX_HEIGHT_5,
            ),
            TextView("Add new card", Colors.green, FONT_SIZE_14),
          ],
        ),
      ),
    );
  }
}

class CarouselItemView extends StatelessWidget {
  final CardVO cards;

  CarouselItemView({required this.cards});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [CAROUSEL_ITEM_START_COLOR, CAROUSEL_ITEM_END_COLOR],
        ),
        borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS_10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: MARGIN_16, top: MARGIN_10),
                child: TextView(
                  cards.cardType ?? "",
                  Colors.white,
                  FONT_SIZE_20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(right: MARGIN_16),
                child: TextView(
                  "...",
                  Colors.white,
                  FONT_SIZE_30,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: MARGIN_16, top: MARGIN_5),
                child: TextView(
                  cards.cardNumber ?? "* * * *   * * * *   * * * *",
                  Colors.white,
                  FONT_SIZE_20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Container(
                margin: EdgeInsets.only(right: MARGIN_16),
                child: TextView(
                  "",
                  Colors.white,
                  FONT_SIZE_20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: MARGIN_16),
                    child: TextView(
                      "CARD HOLDER",
                      Colors.white70,
                      FONT_SIZE_16,
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: MARGIN_16),
                    child: TextView(
                      "EXPIRES",
                      Colors.white70,
                      FONT_SIZE_16,
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: MARGIN_16),
                    child: TextView(
                      cards.cardHolderName ?? "Lily Johnson",
                      Colors.white,
                      FONT_SIZE_18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(right: MARGIN_16),
                    child: TextView(
                      cards.cardExpirationDate ?? "08/21",
                      Colors.white,
                      FONT_SIZE_18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}


/*

class PaymentPage extends StatefulWidget {
  final String bookingDate;
  final int timeSlotId;
  final String timeSlot;
  final int cinemaId;
  final String cinemaName;
  final int movieId;
  final String movieName;
  final String moviePoster;
  final double totalPrice;
  final String seatRow;
  final String seatName;
  final int cardId;
  final List<SnacksVO> boughtSnacks;

  PaymentPage(
      {
        required this.bookingDate,
        required this.timeSlotId,
        required this.timeSlot,
        required this.cinemaId,
        required this.cinemaName,
        required this.movieId,
        required this.movieName,
        required this.moviePoster,
        required this.totalPrice,
        required this.seatRow,
        required this.seatName,
        required this.cardId,
        required this.boughtSnacks});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  List<CardVO>? cards;
  CardVO? chooseCard;

  UserBookingVO? userBooking;

  CinemaModel cinemaModel = CinemaModelImpl();

  _getCards() {

    cinemaModel.getCardsFromDatabase().listen((event) {
      setState(() {
        cards = event;
        //chooseCard = cards?[0];
      });
    }).onError((error) => debugPrint(error.toString()));
  }

  @override
  void initState() {
    _getCards();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PaymentBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              margin: EdgeInsets.only(top: MARGIN_20),
              child: Icon(
                Icons.chevron_left,
                color: Colors.black,
                size: BACK_ARROW_ICON_SIZE_40,
              ),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(top: MARGIN_20, left: MARGIN_20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextView("Payment amount", TICKET_PAGE_LABEL_COLOR, FONT_SIZE_20),
              SizedBox(
                height: SIZED_BOX_HEIGHT_10,
              ),
              TextView(
                "\$ ${widget.totalPrice}",
                Colors.black,
                FONT_SIZE_25,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_20,
              ),
              Selector<PaymentBloc, List<CardVO>?>(
                selector: (context, bloc) => bloc.cards,
                builder:
                    (BuildContext context, cards,
                    Widget? child) {
                  return CarouselSliderView(
                      cards: cards ?? [],
                      onTapView: (index) {
                        PaymentBloc paymentBloc = Provider.of(context, listen: false);
                        paymentBloc.carouselSliderChange(index);
                      });
                },
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_20,
              ),
              AddCardRowView(
                    () => _navigateToAddCardPage(context),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Builder(
          builder: (context) => FloatingButtonView(
            onTapView: () {
              PaymentBloc paymentBloc = Provider.of(context, listen: false);
              paymentBloc.checkout(timeSlotId, seatRow, seatName, bookingDate, totalPrice, movieId, cardId, cinemaId, boughtSnacks).then((value) {
                _navigateToTicketPage(context, value);
              }).catchError((error) {
                debugPrint(error.toString());
              });
            },
            text: 'Purchase',
          ),
        ),
      ),
    );
  }

  _navigateToTicketPage(BuildContext context, UserBookingVO? userBookingVO) {
    if (userBooking != null) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TicketPage(
                  movieName: widget.movieName,
                  moviePoster: widget.moviePoster,
                  cinemaName: widget.cinemaName,
                  userBooking: userBooking!)));
    }
  }

  Future<dynamic> _navigateToAddCardPage(BuildContext context) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddCardPage(),
      ),
    );

  }
}*/
