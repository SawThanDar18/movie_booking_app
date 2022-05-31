import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/movies/movie_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

abstract class MovieDao {

  void saveMovies(List<MovieVO> movies);

  void saveSingleMovie(MovieVO movie);

  List<MovieVO> getAllMovies();

  MovieVO? getMovieById(int movieId);

  Stream<MovieVO?> getMovieByIdStream(int movieId);

  Stream<void> getAllMoviesEventStream();

  Stream<List<MovieVO>> getNowPlayingMoviesStream();

  List<MovieVO> getNowPlayingMovies();

  Stream<List<MovieVO>> getComingSoonMoviesStream();

  List<MovieVO> getComingSoonMovies();
}