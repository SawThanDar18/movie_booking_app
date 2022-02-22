import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/vos/movies/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movies/movie_vo.dart';
import 'package:movie_booking_app/network/api_constants.dart';
import 'package:movie_booking_app/resources/colors.dart';
import 'package:movie_booking_app/resources/dimens.dart';

class MovieView extends StatelessWidget {
  final Function onTapMovie;
  final MovieVO? movie;
  final List<GenreVO?> genre;

  MovieView({required this.onTapMovie, required this.movie, required this.genre});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            onTapMovie();
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(CIRCLE_IMAGE_BORDER_RADIUS),
            child: Image.network(
              "$IMAGE_BASE_URL${movie?.posterPath ?? ""}",
              height: LIST_VIEW_IMAGE_HEIGHT,
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          height: SIZED_BOX_HEIGHT_10,
        ),
        Center(
          child: Text(
            movie?.title ?? "",
            style: TextStyle(
              color: Colors.black,
              fontSize: FONT_SIZE_16,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: SIZED_BOX_HEIGHT_5,
        ),
        Center(
          child: Text(
            "",
            style: TextStyle(
              color: LABEL_TEXT_COLOR,
              fontSize: FONT_SIZE_12,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
