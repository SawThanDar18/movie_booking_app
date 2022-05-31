import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';

class TextFieldLabelView extends StatelessWidget {
  final String label;
  final double labelSize;

  TextFieldLabelView(this.label, {this.labelSize = FONT_SIZE_12});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: LABEL_TEXT_COLOR,
        fontSize: labelSize,
      ),
    );
  }
}
