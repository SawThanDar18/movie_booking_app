import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_booking_app/data/models/cinema_model.dart';
import 'package:movie_booking_app/data/models/cinema_model_impl.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';
import 'package:movie_booking_app/data/vos/movies/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movies/movie_vo.dart';
import 'package:movie_booking_app/pages/splash_page.dart';

class HomeBloc extends ChangeNotifier{

  CinemaModel cinemaModel = CinemaModelImpl();

  List<MovieVO>? nowPlayingMovies;
  List<MovieVO>? comingSoonMovies;
  List<SnacksVO>? snacksList;
  List<GenreVO>? genres;

  String? name;
  String? email;
  String? token;

  HomeBloc() {

    cinemaModel.getUsersFromDatabase().listen((user) {
        name = user[0].name;
        email = user[0].email;
        token = user[0].token;
        print("userToken>> $token");
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

    cinemaModel.getSnacksFromDatabase().listen((snacksList) {
        this.snacksList = snacksList;
        notifyListeners();
        print("SnacksList>> ${snacksList?.length}");
    }).onError((error) => debugPrint(error.toString()));

  }

  _userLogOut(BuildContext context) {
    cinemaModel.userLogOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => SplashPage()));
    });
  }

}