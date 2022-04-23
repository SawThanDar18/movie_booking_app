import 'package:flutter_test/flutter_test.dart';
import 'package:movie_booking_app/data/models/cinema_model_impl.dart';
import 'package:movie_booking_app/data/vos/movies/movie_vo.dart';

import '../../persistence/actor_dao_impl_mock.dart';
import '../../persistence/card_dao_impl_mock.dart';

void main() {
  group("Cinema Model Impl Test", () {
    var movieModel = CinemaModelImpl();

    setUp(() {
      /*movieModel.setDaosAndDataAgents(
        ActorDaoImplMock(),
        //userDao,
        CardDaoImplMock(),
        cinemaDayTimeDao,
        movieDao,
        paymentDao,
        snacksDao,
        cinemaDataAgent,
      );*/
    });

    test("Now Playing Movies Test", () {
      expect(
        movieModel.getNowPlayingMoviesFromDatabase(),
        emits([
          MovieVO(
            false,
            "/5P8SmMzSNYikXpxil6BYzJ16611.jpg",
            [80, 9648, 53],
            414906,
            "en",
            "The Batman",
            "In his second year of fighting crime, Batman uncovers corruption in Gotham City that connects to his own family while facing a serial killer known as the Riddler.",
            17796.835,
            "/74xTEgt7R36Fpooo50r9T25onhq.jpg",
            "2022-03-01",
            "The Batman",
            false,
            7.9,
            3500,
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
        ]),
      );
    });

    test("Coming Soon Movies Test", () {
      expect(
        movieModel.getComingSoonMoviesFromDatabase(),
        emits([
          MovieVO(
            false,
            "/cqnVuxXe6vA7wfNWubak3x36DKJ.jpg",
            [28, 12, 18, 14],
            639933,
            "en",
            "The Northman",
            "Prince Amleth is on the verge of becoming a man when his father is brutally murdered by his uncle, who kidnaps the boy's mother. Two decades later, Amleth is now a Viking who's on a mission to save his mother, kill his uncle and avenge his father.",
            565.73,
            "/zhLKlUaF1SEpO58ppHIAyENkwgw.jpg",
            "2022-04-07",
            "The Northman",
            false,
            8.1,
            108,
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

    test("Movie Details Test", () {
      expect(
        movieModel.getMovieDetailsFromDatabase(639933),
        emits([
          MovieVO(
            false,
            "/cqnVuxXe6vA7wfNWubak3x36DKJ.jpg",
            [28, 12, 18, 14],
            639933,
            "en",
            "The Northman",
            "Prince Amleth is on the verge of becoming a man when his father is brutally murdered by his uncle, who kidnaps the boy's mother. Two decades later, Amleth is now a Viking who's on a mission to save his mother, kill his uncle and avenge his father.",
            565.73,
            "/zhLKlUaF1SEpO58ppHIAyENkwgw.jpg",
            "2022-04-07",
            "The Northman",
            false,
            8.1,
            108,
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

    test("Credits By Movie Test", () {
      expect(
        movieModel.getCreditsByMovieFromDatabase(639933),
        emits([
          //actorToDatabaseMock();
        ]),
      );
    });
    
  });
}
