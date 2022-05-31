import 'package:flutter/foundation.dart';
import 'package:movie_booking_app/data/models/cinema_model.dart';
import 'package:movie_booking_app/data/models/cinema_model_impl.dart';
import 'package:movie_booking_app/data/vos/movies/actor_vo.dart';
import 'package:movie_booking_app/data/vos/movies/movie_vo.dart';

class MovieDetailsBloc extends ChangeNotifier{

  CinemaModel cinemaModel = CinemaModelImpl();

  MovieVO? movieDetails;
  List<ActorVO>? cast;

  MovieDetailsBloc(int movieId, [CinemaModel? mCinemaModel]) {
    if (mCinemaModel != null) {
      cinemaModel = mCinemaModel;
    }

    cinemaModel.getMovieDetailsFromDatabase(movieId).listen((event) {
      movieDetails = event;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    cinemaModel.getCreditsByMovieFromDatabase(movieId).listen((event) {
      cast = event;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

  }

}