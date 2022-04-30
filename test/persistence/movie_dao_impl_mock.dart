import 'package:movie_booking_app/data/vos/movies/movie_vo.dart';
import 'package:movie_booking_app/persistence/daos/movie_dao.dart';

import '../mock_data/mock_data.dart';

class MovieDaoImplMock extends MovieDao {
  Map<int, MovieVO> moviesFromDatabaseMock = {};

  @override
  List<MovieVO> getAllMovies() {
    return getMockMovieListForTest() ?? [];
  }

  @override
  Stream<void> getAllMoviesEventStream() {
    return Stream.value(null);
  }

  @override
  List<MovieVO> getComingSoonMovies() {
    if (getMockMovieListForTest()?.isNotEmpty ?? false) {
      if (getMockMovieListForTest() != null) {
        return getMockMovieListForTest()!
            .where((element) => element.isComingSoon ?? false)
            .toList();
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  @override
  Stream<List<MovieVO>> getComingSoonMoviesStream() {
    return Stream.value(getComingSoonMovies());
  }

  @override
  MovieVO? getMovieById(int movieId) {
    return getMockMovieListForTest()?.first;
  }

  @override
  Stream<MovieVO?> getMovieByIdStream(int movieId) {
    return Stream.value(null);
  }

  @override
  List<MovieVO> getNowPlayingMovies() {
    if (getMockMovieListForTest()?.isNotEmpty ?? false) {
      if (getMockMovieListForTest() != null) {
        return getMockMovieListForTest()!
            .where((element) => element.isNowPlaying ?? false)
            .toList();
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesStream() {
    return Stream.value(getNowPlayingMovies());
  }

  @override
  void saveMovies(List<MovieVO> movies) {
    movies.forEach((movie) {
      moviesFromDatabaseMock[movie.id ?? 0] = movie;
    });
  }

  @override
  void saveSingleMovie(MovieVO movie) {
    moviesFromDatabaseMock[movie.id ?? 0] = movie;
  }
  
}