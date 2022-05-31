import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimens.dart';

class LabelTextView extends StatelessWidget {
  final String text;
  final Color color;

  LabelTextView(this.text, this.color);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: LABEL_TEXT_SIZE,
      ),
    );
  }
}
