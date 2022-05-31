import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/models/cinema_model.dart';
import 'package:movie_booking_app/data/models/cinema_model_impl.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';
import 'package:movie_booking_app/data/vos/movies/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movies/movie_vo.dart';
import 'package:movie_booking_app/data/vos/users/user_vo.dart';

class HomeBloc extends ChangeNotifier {
  CinemaModel cinemaModel = CinemaModelImpl();

  List<MovieVO>? nowPlayingMovies;
  List<MovieVO>? comingSoonMovies;
  List<SnacksVO>? snacksList;
  List<GenreVO>? genres;

  List<UserVO>? users;

  int currentIndex = 0;

  HomeBloc([CinemaModel? mCinemaModel]) {
    if (mCinemaModel != null) {
      cinemaModel = mCinemaModel;
    }

    cinemaModel.getUsersFromDatabase().listen((user) {
      users = user;
      notifyListeners();
    }).onError((error) => debugPrint(error));

    cinemaModel.getNowPlayingMoviesFromDatabase().listen((movieList) {
      nowPlayingMovies = movieList;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    cinemaModel.getComingSoonMoviesFromDatabase().listen((movieList) {
      comingSoonMovies = movieList;
      notifyListeners();
    }).onError((error) {
      debugPrint(error.toString());
    });

    cinemaModel.getGenres().then((genres) {
      this.genres = genres;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

    cinemaModel.getGenresFromDatabase().then((genres) {
      this.genres = genres;
      notifyListeners();
    }).catchError((error) {
      debugPrint(error.toString());
    });

    cinemaModel.getSnacks();

    // cinemaModel.getSnacksFromDatabase().listen((snacksList) {
    //     this.snacksList = snacksList;
    //     notifyListeners();
    //     print("SnacksList>> ${snacksList?.length}");
    // }).onError((error) => debugPrint(error.toString()));
  }

  int chooseTab(int index) {
    currentIndex = index;
    notifyListeners();
    return currentIndex;
  }

  Future<String?> onTapLogOut() {
    return cinemaModel.userLogOut();
  }
}
