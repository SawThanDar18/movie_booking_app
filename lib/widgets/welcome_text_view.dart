import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/resources/strings.dart';

class WelcomeTextView extends StatelessWidget {
  final Color colors;

  WelcomeTextView(this.colors);

  @override
  Widget build(BuildContext context) {
    return Text(
      WELCOME_TEXT,
      style: TextStyle(
        color: colors,
        fontWeight: FontWeight.bold,
        fontSize: WELCOME_TEXT_SIZE,
      ),
    );
  }
}
