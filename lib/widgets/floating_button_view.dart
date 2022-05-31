import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';

import '../config/config_value.dart';
import '../config/environment_config.dart';

class FloatingButtonView extends StatelessWidget {
  final Function onTapView;
  final String text;

  FloatingButtonView({required this.onTapView, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTapView();
      },
      child: Container(
        margin: EdgeInsets.only(
          left: MARGIN_16,
          right: MARGIN_16,
          bottom: MARGIN_30,
        ),
        width: MediaQuery.of(context).size.width,
        height: FLOATING_BUTTON_HEIGHT,
        child: FloatingActionButton.extended(
          backgroundColor: THEME_COLOR[EnvironmentConfig.CONFIG_THEME_COLOR],
          label: Text(
            text,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS)),
          ),
          onPressed: () {
            this.onTapView();
          },
        ),
      ),
    );
  }
}
