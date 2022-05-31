import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/blocs/movie_details_bloc.dart';

import '../data/model/cinema_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main() {
  MovieDetailsBloc? detailsBloc;

  group('Movie Details Bloc Test', (){
    setUp((){
      detailsBloc = MovieDetailsBloc(2, CinemaModelImplMock());
    });

    test('Movie details', (){
      expect(detailsBloc?.movieDetails, getMockMovieListForTest()?.first);
    });

    test('Actors', (){
      expect(detailsBloc?.cast, getMockActors().first);
    });
  });
}