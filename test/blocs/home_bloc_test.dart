
import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/blocs/home_bloc.dart';

import '../data/model/cinema_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  HomeBloc? homeBloc;

  group('HomeBlocTest', () {
    setUp(() {
      homeBloc = HomeBloc(CinemaModelImplMock());
    });

    test('Profile Test', (){
      expect(homeBloc?.users, getMockProfile());
    });

    test('Now playing movies Test', () {
      expect(
          homeBloc?.nowPlayingMovies
              ?.contains(getMockMovieListForTest()?.first),
          true);
    });

    test('Coming Soon movies Test', () {
      expect(
          homeBloc?.comingSoonMovies
              ?.contains(getMockMovieListForTest()?.last),
          true);
    });
  });
}
