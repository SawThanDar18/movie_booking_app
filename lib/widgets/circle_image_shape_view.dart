import 'package:flutter/material.dart';
import 'package:movie_booking_app/resources/dimens.dart';

class CircleImageShapeView extends StatelessWidget {
  final String imageURL;

  CircleImageShapeView(this.imageURL);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: CIRCLE_IMAGE_WIDTH,
      height: CIRCLE_IMAGE_HEIGHT,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage(imageURL),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
