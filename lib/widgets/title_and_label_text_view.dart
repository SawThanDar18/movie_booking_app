import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';
import 'package:movie_booking_app/widgets/text_view.dart';

class TitleAndLabelTextView extends StatelessWidget {
  final label_1, label_2, label_3;
  final bool isVisible;

  TitleAndLabelTextView(this.label_1, this.label_2,
      {this.label_3, this.isVisible = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: TextView(
            label_1,
            Colors.black,
            FONT_SIZE_25,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: SIZED_BOX_HEIGHT_5,
        ),
        Center(
          child: TextView(
            label_2,
            SEATING_CHART_TEXT_COLOR,
            FONT_SIZE_16,
          ),
        ),
        SizedBox(
          height: SIZED_BOX_HEIGHT_5,
        ),
        Visibility(
          visible: isVisible,
          child: Center(
            child: TextView(
              label_3,
              SEATING_CHART_TEXT__2_COLOR,
              FONT_SIZE_18,
            ),
          ),
        )
      ],
    );
  }
}
