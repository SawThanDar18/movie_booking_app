import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/text_view.dart';

class TextRowView extends StatelessWidget {
  final String text_1, text_2;
  final double textSize;

  TextRowView(this.text_1, this.text_2, {this.textSize = FONT_SIZE_18});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: MARGIN_16,
        ),
        TextView(
          text_1,
          SEATING_CHART_TEXT_COLOR,
          textSize,
        ),
        Spacer(),
        TextView(
          text_2,
          SEATING_CHART_TEXT__2_COLOR,
          textSize,
        ),
        SizedBox(
          width: MARGIN_16,
        ),
      ],
    );
  }
}
