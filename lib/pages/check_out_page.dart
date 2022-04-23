import 'package:flutter/material.dart';
import 'package:movie_booking_app/blocs/snacks_bloc.dart';
import 'package:movie_booking_app/data/vos/cinema/payment_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';
import 'package:movie_booking_app/pages/payment_page.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/floating_button_view.dart';
import 'package:provider/provider.dart';

class CheckOutPage extends StatelessWidget {
  final String bookingDate;
  final int timeSlotId;
  final String timeSlot;
  final int cinemaId;
  final String cinemaName;
  final int movieId;
  final String movieName;
  final String moviePoster;
  final double subTotal;
  final String seatRow;
  final String seatName;

  CheckOutPage(
      {
      required this.bookingDate,
      required this.timeSlotId,
      required this.timeSlot,
      required this.cinemaId,
      required this.cinemaName,
      required this.movieId,
      required this.movieName,
      required this.moviePoster,
      required this.subTotal,
      required this.seatRow,
      required this.seatName});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SnacksBloc(subTotal),
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
                size: CHEVRON_LEFT_ICON_SIZE,
              ),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(MARGIN_20),
          child: SingleChildScrollView(
            key: Key("SCROLL_PAYMENT_KEY"),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Selector<SnacksBloc, List<SnacksVO>?>(
                  selector: (context, bloc) => bloc.snacks,
                  shouldRebuild: (previous, next) => previous != next,
                  builder:
                      (BuildContext context, snacks,
                      Widget? child) {
                    return  SelectComboSetView(
                      snacks: snacks,
                      onTapIncrease: (snack) {
                        Key("Snacks ${snack.id}");
                        SnacksBloc snacksBloc = Provider.of(context, listen: false);
                        snacksBloc.onTapIncrease(snack);
                      },
                      onTapDecrease: (snack) {
                        Key("${snack.id}");
                        SnacksBloc snacksBloc = Provider.of(context, listen: false);
                        snacksBloc.onTapDecrease(snack);
                      },
                    );
                  },
                ),
                SizedBox(
                  height: SIZED_BOX_HEIGHT_10,
                ),
                PromoCodeView(),
                SizedBox(
                  height: SIZED_BOX_HEIGHT_20,
                ),
                Text(
                  "Sub total : $subTotal\$",
                  style: TextStyle(color: Colors.green, fontSize: FONT_SIZE_18),
                ),
                SizedBox(
                  height: SIZED_BOX_HEIGHT_40,
                ),
                Text(
                  "Payment method",
                  style: TextStyle(
                    color: CHECK_OUT_PAGE_TITLE_COLOR,
                    fontWeight: FontWeight.bold,
                    fontSize: FONT_SIZE_20,
                  ),
                ),
                SizedBox(
                  height: SIZED_BOX_HEIGHT_20,
                ),
                Selector<SnacksBloc, List<PaymentVO>?>(
                  selector: (context, bloc) => bloc.paymentMethods,
                  shouldRebuild: (previous, next) => previous != next,
                  builder:
                      (BuildContext context, paymentMethods,
                      Widget? child) {
                    return Selector <SnacksBloc, int?>(
                      selector: (context, bloc) => bloc.selectPaymentId,
                      shouldRebuild: (previous, next) => previous != next,
                      builder: (BuildContext context, selectPaymentId, Widget? child) {
                        return  PaymentMethodView(
                          key: Key("2"),
                            paymentMethods: paymentMethods,
                            onTapView: (selectPaymentId) {
                              SnacksBloc snacksBloc = Provider.of(context, listen: false);
                              snacksBloc.onTapPaymentMethod(selectPaymentId);
                            });
                      },
                    );
                  },
                ),
                SizedBox(
                  height: SIZED_BOX_HEIGHT_100,
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:  Selector<SnacksBloc, double?>(
          selector: (context, bloc) => bloc.payTotalPrice,
          shouldRebuild: (previous, next) => previous != next,
          builder:
              (BuildContext context, payTotalPrice,
              Widget? child) {
            return  FloatingButtonView(
              onTapView: () {
                SnacksBloc snacksBloc = Provider.of(context, listen: false);
                snacksBloc.savedSelectedSnacks();

                if (snacksBloc.selectPaymentId != null) {
                  _navigateToPaymentPage(context);
                } else {
                  _showToast(context, "Please select Payment!");
                }
              },
              text: 'Pay \$$payTotalPrice.00',
            );
          },
        ),
      ),
    );
  }

  _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  _navigateToPaymentPage(BuildContext context) {
    SnacksBloc snacksBloc = Provider.of(context, listen: false);
    if (snacksBloc.selectPaymentId != null && snacksBloc.boughtSnacks != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>
          PaymentPage(
              bookingDate: bookingDate,
              timeSlotId: timeSlotId,
              timeSlot: timeSlot,
              cinemaId: cinemaId,
              cinemaName: cinemaName,
              movieId: movieId,
              movieName: movieName,
              moviePoster: moviePoster,
              totalPrice: snacksBloc.payTotalPrice,
              seatRow: seatRow,
              seatName: seatName,
              cardId: snacksBloc.selectPaymentId ?? 0,
          boughtSnacks: snacksBloc.boughtSnacks)));
    }
  }
}

class PaymentItemLists {
  IconData icon;
  String title;
  String genre;

  PaymentItemLists(
      {required this.icon, required this.title, required this.genre});
}

class PaymentMethodView extends StatelessWidget {
  List<PaymentItemLists> paymentItems = [
    PaymentItemLists(
      icon: Icons.credit_card_outlined,
      title: "Credit card",
      genre: "Visa, master card, JCB",
    ),
    PaymentItemLists(
      icon: Icons.credit_card_outlined,
      title: "Internet banking (ATM card)",
      genre: "Visa, master card, JCB",
    ),
    PaymentItemLists(
      icon: Icons.credit_card_outlined,
      title: "E-wallet",
      genre: "Paypal",
    ),
  ];

  final List<PaymentVO>? paymentMethods;
  final Function(int) onTapView;

  PaymentMethodView({Key? key, required this.paymentMethods, required this.onTapView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (paymentMethods != null)
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: paymentMethods?.length ?? 0,
              itemBuilder: (context, index) {
                return CardRowView(paymentMethod: paymentMethods?[index], onTapView: onTapView);
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class CardRowView extends StatefulWidget {
  final PaymentVO? paymentMethod;
  final Function(int) onTapView;

  CardRowView({Key? key, required this.paymentMethod, required this.onTapView}) : super(key: key);

  @override
  State<CardRowView> createState() => _CardRowViewState();
}

class _CardRowViewState extends State<CardRowView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onTapView(widget.paymentMethod?.id ?? 0);
        });
      },
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.credit_card_outlined,
                color: (widget.paymentMethod?.isSelected == true) ? SPLASH_SCREEN_BACKGROUND_COLOR : CHECK_OUT_PAGE_LABEL_COLOR,
                size: CARD_ICON_SIZE,
              ),
              SizedBox(
                width: SIZED_BOX_HEIGHT_10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.paymentMethod?.paymentName ?? "",
                    style: TextStyle(
                      color: (widget.paymentMethod?.isSelected == true) ? SPLASH_SCREEN_BACKGROUND_COLOR : CHECK_OUT_PAGE_TITLE_COLOR,
                      fontSize: FONT_SIZE_16,
                    ),
                  ),
                  SizedBox(
                    height: SIZED_BOX_HEIGHT_3,
                  ),
                  Text(
                    widget.paymentMethod?.paymentDetail ?? "",
                    style: TextStyle(
                      color: (widget.paymentMethod?.isSelected == true) ? SPLASH_SCREEN_BACKGROUND_COLOR : CHECK_OUT_PAGE_LABEL_COLOR,
                      fontSize: FONT_SIZE_14,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: SIZED_BOX_HEIGHT_20,
          ),
        ],
      ),
    );
  }
}

class PromoCodeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: "Enter promo code",
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: SPLASH_SCREEN_BACKGROUND_COLOR),
            ),
            hintStyle: TextStyle(
              color: CHECK_OUT_PAGE_LABEL_COLOR,
              fontSize: FONT_SIZE_18,
              fontStyle: FontStyle.italic,
            ),
          ),
          keyboardType: TextInputType.text,
        ),
        SizedBox(
          height: SIZED_BOX_HEIGHT_10,
        ),
        RichText(
          text: TextSpan(
            style: TextStyle(
                color: CHECK_OUT_PAGE_LABEL_COLOR, fontSize: FONT_SIZE_16),
            children: <TextSpan>[
              TextSpan(
                  text: 'Don\'t have any promo code ? ',
                  style: TextStyle(color: CHECK_OUT_PAGE_LABEL_COLOR)),
              TextSpan(
                  text: 'Get it now',
                  style: TextStyle(color: CHECK_OUT_PAGE_TITLE_COLOR)),
            ],
          ),
        )
      ],
    );
  }
}

class ComboItemLists {
  String title;
  String description;
  String price;

  ComboItemLists(
      {required this.title, required this.description, required this.price});
}

class SelectComboSetView extends StatefulWidget {
  final List<SnacksVO>? snacks;
  final Function(SnacksVO snack) onTapIncrease;
  final Function(SnacksVO snack) onTapDecrease;

  SelectComboSetView(
      {required this.snacks,
      required this.onTapIncrease,
      required this.onTapDecrease});

  @override
  State<SelectComboSetView> createState() => _SelectComboSetViewState();
}

class _SelectComboSetViewState extends State<SelectComboSetView> {
  List<ComboItemLists> comboItems = [
    ComboItemLists(
      title: "Combo set M",
      description: "Combo size M 22oz. Coke (X1) \nand medium popcorn (X1)",
      price: "15\$",
    ),
    ComboItemLists(
      title: "Combo set L",
      description: "Combo size M 32oz. Coke (X1) \nand large popcorn (X1)",
      price: "18\$",
    ),
    ComboItemLists(
      title: "Combo for 2",
      description: "Combo size 2 32oz. Coke (X2) \nand large popcorn (X1)",
      price: "20\$",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (widget.snacks != null)
          ? ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: widget.snacks?.length ?? 0,
              itemBuilder: (context, index) {
                return ComboSetRowViewItem(
                    snack: widget.snacks?[index],
                    onTapIncrease: widget.onTapIncrease,
                    onTapDecrease: widget.onTapDecrease);
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class ComboSetRowViewItem extends StatelessWidget {
  final SnacksVO? snack;
  final Function(SnacksVO) onTapIncrease;
  final Function(SnacksVO) onTapDecrease;

  ComboSetRowViewItem(
      {required this.snack,
      required this.onTapIncrease,
      required this.onTapDecrease});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                this.snack?.snackName ?? "",
                style: TextStyle(
                  color: CHECK_OUT_PAGE_TITLE_COLOR,
                  fontSize: FONT_SIZE_16,
                ),
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_10,
              ),
              Text(
                this.snack?.snackDetail ?? "",
                style: TextStyle(
                  color: CHECK_OUT_PAGE_LABEL_COLOR,
                  fontSize: FONT_SIZE_14,
                ),
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_10,
              ),
            ],
          ),
        ),
        Spacer(),
        Column(
          children: [
            Text(
              "\$ ${snack?.snackPrice.toString()}",
              style: TextStyle(
                color: CHECK_OUT_PAGE_TITLE_COLOR,
                fontSize: FONT_SIZE_16,
              ),
            ),
            SizedBox(
              height: SIZED_BOX_HEIGHT_15,
            ),
            IncreaseAndDecreaseView(
              snack: snack!,
              onTapIncrease: this.onTapIncrease,
              onTapDecrease: this.onTapDecrease,
            ),
            SizedBox(
              height: SIZED_BOX_HEIGHT_20,
            ),
          ],
        ),
      ],
    );
  }
}

class IncreaseAndDecreaseView extends StatefulWidget {
  final SnacksVO snack;
  final Function(SnacksVO) onTapIncrease;
  final Function(SnacksVO) onTapDecrease;

  IncreaseAndDecreaseView(
      {required this.snack,
      required this.onTapIncrease,
      required this.onTapDecrease});

  @override
  State<IncreaseAndDecreaseView> createState() => _IncreaseAndDecreaseViewState();
}

class _IncreaseAndDecreaseViewState extends State<IncreaseAndDecreaseView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: CHECK_OUT_PAGE_ROW_VIEW_CONTAINER_WIDTH,
            height: CHECK_OUT_PAGE_ROW_VIEW_CONTAINER_HEIGHT,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(BORDER_RADIUS),
                bottomLeft: Radius.circular(BORDER_RADIUS),
              ),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: 1),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.onTapDecrease(widget.snack);
                });
              },
              child: Center(
                child: Icon(
                  Icons.remove,
                  size: CHECK_OUT_PAGE_ICON_SIZE,
                ),
              ),
            ),
          ),
          Container(
            width: CHECK_OUT_PAGE_ROW_VIEW_CONTAINER_WIDTH,
            height: CHECK_OUT_PAGE_ROW_VIEW_CONTAINER_HEIGHT,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: 1),
              ],
            ),
            child: Center(
              child: Text(
                  ((widget.snack.quantity) == null) ? "0" : widget.snack.quantity.toString(),
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
          Container(
            width: CHECK_OUT_PAGE_ROW_VIEW_CONTAINER_WIDTH,
            height: CHECK_OUT_PAGE_ROW_VIEW_CONTAINER_HEIGHT,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(BORDER_RADIUS),
                  bottomRight: Radius.circular(BORDER_RADIUS)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(color: Colors.grey, spreadRadius: 1),
              ],
            ),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  widget.onTapIncrease(widget.snack);
                });
              },
              child: Center(
                key: Key("Snacks ${widget.snack.id}"),
                child: Icon(
                  Icons.add,
                  size: CHECK_OUT_PAGE_ICON_SIZE,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/*
class CheckOutPage extends StatefulWidget {
  final String bookingDate;
  final int timeSlotId;
  final String timeSlot;
  final int cinemaId;
  final String cinemaName;
  final int movieId;
  final String movieName;
  final String moviePoster;
  final double subTotal;
  final String seatRow;
  final String seatName;

  CheckOutPage(
      {
        required this.bookingDate,
        required this.timeSlotId,
        required this.timeSlot,
        required this.cinemaId,
        required this.cinemaName,
        required this.movieId,
        required this.movieName,
        required this.moviePoster,
        required this.subTotal,
        required this.seatRow,
        required this.seatName});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  List<SnacksVO>? snacks;
  List<PaymentVO>? paymentMethods;

  double subTotal = 0;
  double payTotalPrice = 0;
  int? quantity;
  int? selectPaymentId;

  List<SnacksVO> boughtSnacks = [];

  CinemaModel cinemaModel = CinemaModelImpl();

  @override
  void initState() {

    cinemaModel.getSnacksFromDatabase().listen((snacksList) {
      setState(() {
        snacks = snacksList;
        subTotal = widget.subTotal;
        payTotalPrice = subTotal;
      });
    });

    cinemaModel.getPaymentMethodsFromDatabase().listen((paymentMethods) {
      setState(() {
        this.paymentMethods = paymentMethods;
      });
    }).onError((error) => debugPrint(error.toString()));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => SnacksBloc(subTotal),
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
                size: CHEVRON_LEFT_ICON_SIZE,
              ),
            ),
          ),
        ),
        body: Container(
          margin: EdgeInsets.all(MARGIN_20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Selector<SnacksBloc, List<SnacksVO>?>(
                  selector: (context, bloc) => bloc.snacks,
                  builder:
                      (BuildContext context, snacks,
                      Widget? child) {
                    return  SelectComboSetView(
                      snacks: snacks,
                      onTapIncrease: (snack) {
                        SnacksBloc snacksBloc = Provider.of(context, listen: false);
                        snacksBloc.onTapIncrease(snack);
                      },
                      onTapDecrease: (snack) {
                        SnacksBloc snacksBloc = Provider.of(context, listen: false);
                        snacksBloc.onTapDecrease(snack);
                      },
                    );
                  },
                ),
                SizedBox(
                  height: SIZED_BOX_HEIGHT_10,
                ),
                PromoCodeView(),
                SizedBox(
                  height: SIZED_BOX_HEIGHT_20,
                ),
                Text(
                  "Sub total : ${widget.subTotal}\$",
                  style: TextStyle(color: Colors.green, fontSize: FONT_SIZE_18),
                ),
                SizedBox(
                  height: SIZED_BOX_HEIGHT_40,
                ),
                Text(
                  "Payment method",
                  style: TextStyle(
                    color: CHECK_OUT_PAGE_TITLE_COLOR,
                    fontWeight: FontWeight.bold,
                    fontSize: FONT_SIZE_20,
                  ),
                ),
                SizedBox(
                  height: SIZED_BOX_HEIGHT_20,
                ),
                Selector<SnacksBloc, List<PaymentVO>?>(
                  selector: (context, bloc) => bloc.paymentMethods,
                  builder:
                      (BuildContext context, paymentMethods,
                      Widget? child) {
                    return   PaymentMethodView(
                        paymentMethods: paymentMethods,
                        onTapView: (cardId) {
                          SnacksBloc snacksBloc = Provider.of(context, listen: false);
                          snacksBloc.onTapPaymentMethod(cardId);
                        });
                  },
                ),
                SizedBox(
                  height: SIZED_BOX_HEIGHT_100,
                ),
              ],
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton:  Selector<SnacksBloc, double?>(
          selector: (context, bloc) => bloc.payTotalPrice,
          builder:
              (BuildContext context, payTotalPrice,
              Widget? child) {
            return  FloatingButtonView(
              onTapView: () {
                SnacksBloc snacksBloc = Provider.of(context, listen: false);
                snacksBloc.savedSelectedSnacks();

                if (snacksBloc.selectPaymentId != null) {
                  _navigateToPaymentPage(context, snacksBloc.selectPaymentId, snacksBloc.boughtSnacks);
                } else {
                  _showToast(context, "Please select Payment!");
                }
              },
              text: 'Pay \$$payTotalPrice.00',
            );
          },
        ),
      ),
    );
  }

  _showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  _navigateToPaymentPage(BuildContext context, int? paymentId, List<SnacksVO>? boughtSnacks) {
    if (paymentId != null && boughtSnacks != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) =>
          PaymentPage(
              bookingDate: widget.bookingDate,
              timeSlotId: widget.timeSlotId,
              timeSlot: widget.timeSlot,
              cinemaId: widget.cinemaId,
              cinemaName: widget.cinemaName,
              movieId: widget.movieId,
              movieName: widget.movieName,
              moviePoster: widget.moviePoster,
              totalPrice: payTotalPrice,
              seatRow: widget.seatRow,
              seatName: widget.seatName,
              cardId: paymentId,
              boughtSnacks: boughtSnacks)));
    }
  }
}*/
