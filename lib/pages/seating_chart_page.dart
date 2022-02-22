import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/models/cinema_model.dart';
import 'package:movie_booking_app/data/models/cinema_model_impl.dart';
import 'package:movie_booking_app/data/vos/cinema/seats_vo.dart';
import 'package:movie_booking_app/data/vos/movie_seat_vo.dart';
import 'package:movie_booking_app/dummy/dummy_data.dart';
import 'package:movie_booking_app/pages/check_out_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/utils/constants.dart';
import 'package:movie_booking_app/widgets/dash_view.dart';
import 'package:movie_booking_app/widgets/floating_button_view.dart';
import 'package:movie_booking_app/widgets/text_row_view.dart';
import 'package:movie_booking_app/widgets/text_view.dart';
import 'package:movie_booking_app/widgets/title_and_label_text_view.dart';

class SeatingChartPage extends StatefulWidget {
  final String choosingDate;
  final int timeSlotId;
  final int movieId;
  final String movieTitle;
  final String moviePoster;
  final String time;
  final int cinemaId;
  final String cinemaName;

  SeatingChartPage({required this.choosingDate, required this.timeSlotId, required this.movieId, required this.movieTitle, required this.moviePoster, required this.time, required this.cinemaId, required this.cinemaName});

  @override
  State<SeatingChartPage> createState() => _SeatingChartPageState();
}

class _SeatingChartPageState extends State<SeatingChartPage> {
  List<MovieSeatVO> _movieSeats = dummyMovieSeats;

  List<SeatsVO>? movieSeats;
  List<String> seats = [];
  int? columnCountInRow;
  int tickets = 0;
  double totalPrice = 0;

  String chooseSeatRow = "";
  String chooseSeatName = "";

  CinemaModel cinemaModel = CinemaModelImpl();

  @override
  void initState() {

    cinemaModel.getCinemaSeatingPlan(widget.timeSlotId, widget.choosingDate)
    .then((response) {
      setState(() {
        movieSeats = response?[0] as List<SeatsVO>;
        columnCountInRow = response?[1] as int;
      });
    }).catchError((error) {
      debugPrint(error.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.only(top: MARGIN_16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TitleAndLabelTextView(
                widget.movieTitle,
                "Galaxy Cinema - ${widget.cinemaName}",
                label_3: "${widget.choosingDate}, ${widget.time}",
                isVisible: true,
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_40,
              ),
              MovieSeatsSectionView(seats: movieSeats, columnCountInRow: columnCountInRow, onTapView: (seat) {
                if (seat?.type == SEAT_TYPE_AVAILABLE) {
                  List<SeatsVO>? seatsList = movieSeats;
                  seatsList?.forEach((each) {
                    if (each.id == seat?.id && each.symbol == seat?.symbol) {
                      each.isSelected = (seat?.isSelected == false) ? true : false;
                    }
                  });

                  if (seat?.isSelected == true) {
                    seats.add(seat?.seatName ?? "");
                    totalPrice += seat?.price ?? 0;
                    tickets += 1;
                  } else {
                    seats.remove(seat?.seatName ?? "");
                    totalPrice -= seat?.price ?? 0;
                    tickets -= 1;
                  }

                  setState(() {
                    movieSeats = seatsList;

                    print(seats);

                    var mapList = Map.fromIterable(seats, key: (e) => e[0], value: (e) => e.toString().substring(2,3));

                    chooseSeatRow = mapList.keys.join(",");
                    chooseSeatName = seats.join(",");
                  });
                }
              }),
              SizedBox(
                height: SIZED_BOX_HEIGHT_30,
              ),
              MovieSeatGlossarySectionView(),
              SizedBox(
                height: SIZED_BOX_HEIGHT_40,
              ),
              DashView(),
              SizedBox(
                height: SIZED_BOX_HEIGHT_25,
              ),
              TicketAndSeatView(ticket: tickets.toString(), seatRow: "$chooseSeatRow Row/ $chooseSeatName"),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingButtonView(
          onTapView: () => (chooseSeatRow.isNotEmpty) ? _navigateToCheckOutPage(context, totalPrice, chooseSeatRow, chooseSeatName) : _showToast("Please choose Seat!"),
        text: "Buy Ticket for \$$totalPrice.00",),
    );
  }

  _showToast(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(text),
    ));
  }

  _navigateToCheckOutPage(BuildContext context, double? subTotal, String? seatRow, String? seatName) {
    if (subTotal != null && seatRow != null && seatName != null) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckOutPage(bookingDate: widget.choosingDate, timeSlotId: widget.timeSlotId, timeSlot: widget.time, cinemaId: widget.cinemaId, cinemaName: widget.cinemaName, movieId: widget.movieId, movieName: widget.movieTitle, moviePoster: widget.moviePoster, subTotal: subTotal, seatRow: seatRow, seatName: seatName)));
    }
  }
}

class MovieSeatGlossarySectionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_16),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: MovieSeatGlossaryView(
              MOVIE_SEAT_AVAILABLE_COLOR,
              "Available",
            ),
          ),
          Expanded(
            flex: 1,
            child: MovieSeatGlossaryView(
              MOVIE_SEAT_TAKEN_COLOR,
              "Reserved",
            ),
          ),
          Expanded(
            flex: 1,
            child: MovieSeatGlossaryView(
              SPLASH_SCREEN_BACKGROUND_COLOR,
              "Your Selection",
            ),
          ),
        ],
      ),
    );
  }
}

class MovieSeatGlossaryView extends StatelessWidget {
  final Color color;
  final String label;

  MovieSeatGlossaryView(this.color, this.label);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: MOVIE_SEAT_GLOSSARY_CONTAINER_HEIGHT,
          width: MOVIE_SEAT_GLOSSARY_CONTAINER_WIDTH,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(
              color: color,
            ),
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(
          width: SIZED_BOX_HEIGHT_10,
        ),
        TextView(label, color, FONT_SIZE_14)
      ],
    );
  }
}

class MovieSeatsSectionView extends StatelessWidget {
  //final List<MovieSeatVO> _movieSeats;

  final List<SeatsVO>? seats;
  final int? columnCountInRow;
  final Function(SeatsVO?) onTapView;

  MovieSeatsSectionView({required this.seats, required this.columnCountInRow, required this.onTapView});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: seats?.length ?? 0,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: PADDING_4),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columnCountInRow ?? 1,
        childAspectRatio: 0.9,
      ),
      itemBuilder: (context, index) {
        return MovieSeatsItemView(seatsVO: seats?[index], onTapView: (SeatsVO seatsVO) {
          this.onTapView(seatsVO);
        },);
        //return MovieSeatsItemView(seatsVO: seats![index] ?? [], onTapView: onTapView);
      },
    );
  }
}

class MovieSeatsItemView extends StatefulWidget {
  final SeatsVO? seatsVO;
  final Function(SeatsVO seatsVO) onTapView;

  MovieSeatsItemView({required this.seatsVO, required this.onTapView});

  @override
  State<MovieSeatsItemView> createState() => _MovieSeatsItemViewState();
}

class _MovieSeatsItemViewState extends State<MovieSeatsItemView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          this.widget.onTapView(widget.seatsVO!);
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: MARGIN_3, vertical: MARGIN_5),
        decoration: BoxDecoration(
          color: (widget.seatsVO?.isSelected == true) ? SPLASH_SCREEN_BACKGROUND_COLOR : _getSeatColor(widget.seatsVO),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(BORDER_RADIUS),
            topRight: Radius.circular(BORDER_RADIUS),
          ),
        ),
        child: Center(
          child: TextView((widget.seatsVO?.type == SEAT_TYPE_TEXT) ? widget.seatsVO?.symbol ?? "" : (widget.seatsVO?.isSelected == true) ? widget.seatsVO?.seatName?.substring(2) ?? "" : "", Colors.black, FONT_SIZE_14),
        ),
      ),
    );
  }

  Color _getSeatColor(SeatsVO? seatsVO) {
    if (seatsVO?.type == SEAT_TYPE_TAKEN) {
      return MOVIE_SEAT_TAKEN_COLOR;
    } else if (seatsVO?.type == SEAT_TYPE_AVAILABLE) {
      return MOVIE_SEAT_AVAILABLE_COLOR;
    } else {
      return Colors.white;
    }
  }
}

class TicketAndSeatView extends StatelessWidget {
  final String ticket;
  final String seatRow;

  TicketAndSeatView({required this.ticket, required this.seatRow});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextRowView("Tickets", ticket),
        SizedBox(
          height: SIZED_BOX_HEIGHT_10,
        ),
        TextRowView("Seat", seatRow),
        SizedBox(height: SIZED_BOX_HEIGHT,),
      ],
    );
  }
}
