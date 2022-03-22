import 'package:flutter/material.dart';
import 'package:movie_booking_app/blocs/add_new_card_bloc.dart';
import 'package:movie_booking_app/data/models/cinema_model.dart';
import 'package:movie_booking_app/data/models/cinema_model_impl.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/floating_button_view.dart';
import 'package:movie_booking_app/widgets/text_field_label_view.dart';
import 'package:movie_booking_app/widgets/text_field_view.dart';
import 'package:provider/provider.dart';

class AddCardPage extends StatelessWidget {

  TextEditingController cardNumberTextController = TextEditingController();
  TextEditingController cardHolderNameTextController = TextEditingController();
  TextEditingController cardExpirationDateTextController = TextEditingController();
  TextEditingController cardCvcTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => AddNewCardBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context, false),
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
          margin:
              EdgeInsets.only(top: MARGIN_20, left: MARGIN_20, right: MARGIN_20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserInputForCardView("Card number", "1234.5678.9101.8014", cardNumberTextController),
              SizedBox(
                height: SIZED_BOX_HEIGHT_20,
              ),
              UserInputForCardView(
                "Card holder",
                "Lily Johnson",
                cardHolderNameTextController,
                textInputType: TextInputType.text,
              ),
              SizedBox(
                height: SIZED_BOX_HEIGHT_20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserInputForCardView("Expiration date", "08/21", cardExpirationDateTextController),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: SIZED_BOX_HEIGHT_20,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UserInputForCardView("CVC", "150", cardCvcTextController),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Builder(
          builder: (context) => FloatingButtonView(
            onTapView: () {
              AddNewCardBloc addNewCardBloc = Provider.of(context, listen: false);
              addNewCardBloc.addCard(cardNumberTextController.text, cardHolderNameTextController.text, cardExpirationDateTextController.text, cardCvcTextController.text).then((value) {
                Navigator.pop(context, true);
              }).catchError((error) {
                debugPrint(error.toString());
              });
              },
            text: 'Confirm',
          ),
        ),
      ),
    );
  }
}

class UserInputForCardView extends StatefulWidget {
  final String label;
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController controller;

  UserInputForCardView(this.label, this.hintText, this.controller,
      {this.textInputType = TextInputType.number});

  @override
  State<UserInputForCardView> createState() => _UserInputForCardViewState();
}

class _UserInputForCardViewState extends State<UserInputForCardView> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFieldLabelView(
          widget.label,
          labelSize: FONT_SIZE_18,
        ),
        TextFieldView(
          hintText: widget.hintText,
          textInputType: widget.textInputType,
          textStyle: TextStyle(
            color: TEXT_FIELD_HINT_COLOR,
            fontSize: FONT_SIZE_14,
            fontWeight: FontWeight.bold,
          ),
          textEditingController: widget.controller,
        )
      ],
    );
  }
}


/*
class AddCardPage extends StatefulWidget {

  @override
  State<AddCardPage> createState() => _AddCardPageState();
}

class _AddCardPageState extends State<AddCardPage> {
  TextEditingController cardNumberTextController = TextEditingController();
  TextEditingController cardHolderNameTextController = TextEditingController();
  TextEditingController cardExpirationDateTextController = TextEditingController();
  TextEditingController cardCvcTextController = TextEditingController();

  CinemaModel cinemaModel = CinemaModelImpl();

  _addCard(String cardNumber, String cardHolderName, String expirationDate, String cvc) {
    cinemaModel.addCard(cardNumber, cardHolderName, expirationDate, cvc)
        .then((value) {
      cinemaModel.getProfile();
    })
        .catchError((error) => debugPrint(error.toString()));
  }

  @override
  void initState() {

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
          onTap: () => Navigator.pop(context, false),
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
        margin:
        EdgeInsets.only(top: MARGIN_20, left: MARGIN_20, right: MARGIN_20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserInputForCardView("Card number", "1234.5678.9101.8014", cardNumberTextController),
            SizedBox(
              height: SIZED_BOX_HEIGHT_20,
            ),
            UserInputForCardView(
              "Card holder",
              "Lily Johnson",
              cardHolderNameTextController,
              textInputType: TextInputType.text,
            ),
            SizedBox(
              height: SIZED_BOX_HEIGHT_20,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserInputForCardView("Expiration date", "08/21", cardExpirationDateTextController),
                    ],
                  ),
                ),
                SizedBox(
                  width: SIZED_BOX_HEIGHT_20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UserInputForCardView("CVC", "150", cardCvcTextController),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingButtonView(
        onTapView: () {
          AddNewCardBloc addNewCardBloc = Provider.of(context, listen: false);
          addNewCardBloc.addCard(cardNumberTextController.text, cardHolderNameTextController.text, cardExpirationDateTextController.text, cardCvcTextController.text).then((value) {
            Navigator.pop(context, true);
          }).catchError((error) {
            debugPrint(error.toString());
          });
        },
        text: 'Confirm',
      ),
    );
  }
}*/
