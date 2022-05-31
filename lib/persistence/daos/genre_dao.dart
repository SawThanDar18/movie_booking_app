import 'package:hive/hive.dart';
import 'package:movie_booking_app/data/vos/movies/genre_vo.dart';
import 'package:movie_booking_app/persistence/hive_constants.dart';

abstract class GenreDao {

  void saveAllGenres(List<GenreVO> genreList);

  List<GenreVO> getAllGenres();

}