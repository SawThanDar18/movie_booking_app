import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/data/models/cinema_model_impl.dart';
import 'package:movie_booking_app/data/vos/cinema/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';
import 'package:movie_booking_app/data/vos/movies/movie_vo.dart';
import '../../mock_data/mock_data.dart';
import '../../network/cinema_data_agent_impl_mock.dart';
import '../../persistence/actor_dao_impl_mock.dart';
import '../../persistence/card_dao_impl_mock.dart';
import '../../persistence/cinema_day_time_dao_impl_mock.dart';
import '../../persistence/movie_dao_impl_mock.dart';
import '../../persistence/payment_dao_impl_mock.dart';
import '../../persistence/snacks_dao_impl_mock.dart';
import '../../persistence/user_dao_impl_mock.dart';

void main() {
  group("Cinema Model Impl Test", () {
    var movieModel = CinemaModelImpl();

    setUp(() {
      movieModel.setDaosAndDataAgents(
        ActorDaoImplMock(),
        CardDaoImplMock(),
        CinemaDayTimeDaoImplMock(),
        MovieDaoImplMock(),
        PaymentDaoImplMock(),
        SnacksDaoImplMock(),
        UserDaoImplMock(),
        CinemaDataAgentImplMock(),
      );
    });

    test('Now Playing Movies Test', () {
      expect(
          movieModel.getNowPlayingMoviesFromDatabase(),
          emits([
            MovieVO(
              false,
              ' /cTTggc927lEPCMsWUsdugSj6wAY.jpg',
              [28, 12],
              335787,
              'en',
              'Uncharted',
              ' A young street-smart, Nathan Drake and his wisecracking partner Victor “Sully” Sullivan embark on a dangerous pursuit of “the greatest treasure never found” while also tracking clues that may lead to Nathan’s long-lost brother.',
              677.833,
              '/sqLowacltbZLoCa4KYye64RvvdQ.jpg',
              '2022-02-10',
              'Uncharted',
              false,
              7.1,
              903,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              null,
              true,
              false,
            ),
          ]));
    });

    test("Coming Soon Movies Test", () {
      expect(
        movieModel.getComingSoonMoviesFromDatabase(),
        emits([
          MovieVO(
            false,
            ' /cTTggc927lEPCMsWUsdugSj6wAY.jpg',
            [28, 12],
            335787,
            'en',
            'The Longest Day',
            'World War II movie based on Normandy Landing',
            677.833,
            '/sqLowacltbZLoCa4KYye64RvvdQ.jpg',
            '1952-02-10',
            'The Longest Day',
            false,
            7.1,
            903,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            null,
            false,
            true,
          ),
        ]),
      );
    });

    test('Genres Test', () {
      expect(
        movieModel.getGenres(),
        completion(
          equals(
            getMockGenres(),
          ),
        ),
      );
    });

    test('Genres From Database Test', () {
      expect(
        movieModel.getGenres(),
        completion(
          equals(
            getMockGenres(),
          ),
        ),
      );
    });

    test('Credits By Movie Test', () {
      expect(movieModel.getCreditsByMovieFromDatabase(0),
          emits(getMockActors().first));
    });

    test('Movie Details Test', () {
      expect(movieModel.getMovieDetailsFromDatabase(0),
          emits(getMockMovieListForTest()?.first));
    });

    test('CinemaDayTime From Database Test', () {
      expect(
        movieModel.getCinemaDayTimeSlotsFromDatabase(294793, '2022-04-30'),
        emits(
          getMockCinemaVOList(),
        ),
      );
    });

    test('SnackList From Database Test', () {
      expect(
        movieModel.getSnacksFromDatabase(),
        emits(
          getMockSnackList(),
        ),
      );
    });

    test('Add Card Test', () {
      expect(
        movieModel.addCard('1234567890123', 'Saw', '08/23', '123'),
        completion(
          equals(getMockCardList()),
        ),
      );
    });

    test('PaymentMethod From Database Test', () {
      expect(
        movieModel.getPaymentMethodsFromDatabase(),
        emits(
          getMockPaymentMethodList(),
        ),
      );
    });

    test('CheckOut Test', () {
      expect(
        movieModel.checkOut(
            CheckOutVO(2, 'E', 'E-1,E-2', '2022-04-30', 17, 294793, 2, 2, [
          SnacksVO(2, 'Smoothies', 'Snack Description', 3, null, 1),
        ])),
        completion(
          equals(getMockCheckOut()),
        ),
      );
    });

    test('Profile From Database Test', () {
      expect(
        movieModel.getUsersFromDatabase(),
        emits(
          getMockProfile(),
        ),
      );
    });
  });
}

/*test('Cinema Seating Plan Test', () {
      expect(
        movieModel.getCinemaSeatingPlan(1, '2022-04-30'),
        completion(
          equals(
            getMockMovieSeatList()?.expand((seat) => seat).toList().map((seat) {
              seat.isSelected = false;
              return seat;
            }).toList(),
          ),
        ),
      );
    });*/
