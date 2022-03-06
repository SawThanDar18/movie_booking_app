import 'package:movie_booking_app/data/models/cinema_model.dart';
import 'package:movie_booking_app/data/vos/cinema/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/cinema_day_time_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/day_time_slots_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/payment_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/seats_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/user_booking_vo.dart';
import 'package:movie_booking_app/data/vos/movies/actor_vo.dart';
import 'package:movie_booking_app/data/vos/movies/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movies/movie_vo.dart';
import 'package:movie_booking_app/data/vos/users/card_vo.dart';
import 'package:movie_booking_app/data/vos/users/user_vo.dart';
import 'package:movie_booking_app/network/dataagents/cinema_data_agent.dart';
import 'package:movie_booking_app/network/dataagents/retrofit_cinema_data_agent_impl.dart';
import 'package:movie_booking_app/persistence/daos/actor_dao.dart';
import 'package:movie_booking_app/persistence/daos/card_dao.dart';
import 'package:movie_booking_app/persistence/daos/cinema_day_time_dao.dart';
import 'package:movie_booking_app/persistence/daos/genre_dao.dart';
import 'package:movie_booking_app/persistence/daos/movie_dao.dart';
import 'package:movie_booking_app/persistence/daos/payment_dao.dart';
import 'package:movie_booking_app/persistence/daos/snacks_dao.dart';
import 'package:movie_booking_app/persistence/daos/user_dao.dart';
import 'package:stream_transform/stream_transform.dart';

class CinemaModelImpl extends CinemaModel {
  static final CinemaModelImpl _singleton = CinemaModelImpl._internal();

  factory CinemaModelImpl() {
    return _singleton;
  }

  CinemaModelImpl._internal();

  CinemaDataAgent _dataAgent = RetrofitCinemaDataAgentImpl();

  UserDao userDao = UserDao();
  MovieDao movieDao = MovieDao();
  GenreDao genreDao = GenreDao();
  ActorDao actorDao = ActorDao();
  SnacksDao snacksDao = SnacksDao();
  PaymentDao paymentDao = PaymentDao();
  CinemaDayTimeDao cinemaDayTimeDao = CinemaDayTimeDao();
  CardDao cardDao = CardDao();

  @override
  Future<String?> registerWithEmail(
      String name,
      String email,
      String phoneNumber,
      String password,
      String googleAccessToken,
      String facebookAccessToken) {
    return _dataAgent
        .registerWithEmail(name, email, phoneNumber, password,
            googleAccessToken, facebookAccessToken)
        .then((response) {
      UserVO user = response.first as UserVO;
      user.token = response[1] as String;

      userDao.saveUsers(user);
      return Future.value(response[2] as String);
    });
  }

  @override
  Future<String?> logInWithEmail(String email, String password) {
    return _dataAgent.logInWithEmail(email, password).then((response) {
      UserVO user = response.first as UserVO;
      user.token = response[1] as String;

      userDao.saveUsers(user);
      return Future.value(response[2] as String);
    });
  }

  @override
  Future<String?> logInWithGoogle(String googleToken) {
    return _dataAgent.logInWithGoogle(googleToken).then((response) {
      UserVO user = response.first as UserVO;
      user.token = response[1] as String;

      userDao.saveUsers(user);
      return Future.value(response[2] as String);
    });
  }

  @override
  Future<String?> logInWithFacebook(String facebookToken) {
    return _dataAgent.logInWithFacebook(facebookToken).then((response) {
      UserVO user = response.first as UserVO;
      user.token = response[1] as String;

      userDao.saveUsers(user);
      return Future.value(response[2] as String);
    });
  }

  @override
  Future<String?> userLogOut() {
      return _dataAgent.userLogOut("Bearer ${userDao.getUserToken()}").then((value) {
        userDao.deleteUsers();
        return Future.value(value);
      });
  }

  @override
  void getNowPlayingMovies(int page) {
    _dataAgent.getNowPlayingMovies(page).then((movies) async {
      List<MovieVO> nowPlayingMovies = movies!.map((movie) {
        movie.isNowPlaying = true;
        movie.isComingSoon = false;
        return movie;
      }).toList();
      movieDao.saveMovies(nowPlayingMovies);
    });
  }

  @override
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase() {
    this.getNowPlayingMovies(1);
    return movieDao
        .getAllMoviesEventStream()
        .startWith(movieDao.getNowPlayingMoviesStream())
        .map((event) => movieDao.getNowPlayingMovies());
  }

  @override
  void getComingSoonMovies(int page) {
    _dataAgent.getComingSoonMovies(page).then((movies) async {
      List<MovieVO> comingSoonMovies = movies!.map((movie) {
        movie.isComingSoon = true;
        movie.isNowPlaying = false;
        return movie;
      }).toList();
      movieDao.saveMovies(comingSoonMovies);
    });
  }

  @override
  Stream<List<MovieVO>?> getComingSoonMoviesFromDatabase() {
    this.getComingSoonMovies(1);
    return movieDao
        .getAllMoviesEventStream()
        .startWith(movieDao.getComingSoonMoviesStream())
        .map((event) => movieDao.getComingSoonMovies());
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return _dataAgent.getGenres();
  }

  @override
  void getMovieDetails(int movieId) {
    _dataAgent.getMovieDetails(movieId).then((value) {
      movieDao.saveSingleMovie(value!);
    });
  }

  @override
  Stream<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    this.getMovieDetails(movieId);
    return movieDao.getAllMoviesEventStream()
        .startWith(movieDao.getMovieByIdStream(movieId))
        .map((event) => movieDao.getMovieById(movieId));
  }

  @override
  void getCreditsByMovie(int movieId) {
    _dataAgent.getCreditsByMovie(movieId).then((value) {
      List<ActorVO>? actorList = value.first;
      actorDao.saveAllActors(actorList!);
    });
  }

  @override
  Stream<List<ActorVO>?> getCreditsByMovieFromDatabase(int movieId) {
    this.getCreditsByMovie(movieId);
    return actorDao.getAllActorsEventStream()
        .startWith(actorDao.getActorStream())
        .map((event) => actorDao.getAllActors());
  }

  @override
  void getCinemaDayTimeSlots(int movieId, String date) {
    _dataAgent.getCinemaDayTimeSlots("Bearer ${userDao.getUserToken()}", movieId, date).then((value) {
            CinemaDayTimeVO cinemaDayTimeVO = CinemaDayTimeVO(value);
            cinemaDayTimeDao.saveAllCinemaDayTimeSlots(date, cinemaDayTimeVO);
    });
  }

  @override
  Stream<List<DayTimeSlotsVO>?> getCinemaDayTimeSlotsFromDatabase(int movieId, String date) {
    this.getCinemaDayTimeSlots(movieId, date);
    return cinemaDayTimeDao.getCinemaDayTimeSlotsEventStream()
        .startWith(cinemaDayTimeDao.getCinemaDayTimeSlotsStream(date))
        .map((event) => cinemaDayTimeDao.getCinemaDayTimeSlots(date)?.cinemaDayTimeList);
  }

  @override
  Future<List<dynamic>?> getCinemaSeatingPlan(int timeSlotId, String date) {
     return _dataAgent
          .getCinemaSeatingPlan("Bearer ${userDao.getUserToken()}", timeSlotId, date)
          .asStream()
          .map((seats) {
        List<SeatsVO>? movieSeats = [];
        seats?.forEach((seatData) {
          seatData.forEach((seat) {
            seat.isSelected = false;
          });
          movieSeats.addAll(seatData);
        });
        return [movieSeats, seats![0].length];
      }).first;

  }

  @override
  void getSnacks() {
      _dataAgent.getSnacks("Bearer ${userDao.getUserToken()}").then((snacks) async {
        List<SnacksVO> snacksList = snacks!.map((snack) {
          return snack;
        }).toList();
        snacksDao.saveAllSnacks(snacksList);
      });
  }

  @override
  Stream<List<SnacksVO>?> getSnacksFromDatabase() {
    this.getSnacks();
    return snacksDao
        .getAllSnacksEventStream()
        .startWith(snacksDao.getSnacksStream())
        .map((event) => snacksDao.getAllSnacks());
  }

  @override
  void getPaymentMethods() {
    _dataAgent.getPaymentMethods("Bearer ${userDao.getUserToken()}")
        .then((response) {
      List<PaymentVO>? getCards = response?.map((data) {
        data.isSelected = false;
        return data;
      }).toList();
      paymentDao.saveAllPayments(getCards);
    });
  }

  @override
  Stream<List<PaymentVO>?> getPaymentMethodsFromDatabase() {
    getPaymentMethods();
    return paymentDao.getAllPaymentEventStream()
        .startWith(paymentDao.getPaymentStream())
        .map((event) => paymentDao.getAllPayments());
  }

  @override
  Future<UserVO?> getProfile() {
      return _dataAgent.getProfile("Bearer ${userDao.getUserToken()}").then((value) {
        cardDao.saveAllCards(value?.cards);
      });
  }

  @override
  Stream<List<CardVO>?> getCardsFromDatabase() {
    getProfile();
    return cardDao.getAllCardEventStream()
        .startWith(cardDao.getCardStream())
        .map((event) => cardDao.getAllCards());
  }

  @override
  Future<void> addCard(String cardNumber, String cardHolder, String expirationDate, String cvc) {
    return _dataAgent.addCard("Bearer ${userDao.getUserToken()}", cardNumber, cardHolder, expirationDate, cvc);
  }

  @override
  Future<UserBookingVO?> checkOut(CheckOutVO checkOut) {
    return _dataAgent.checkOut("Bearer ${userDao.getUserToken()}", checkOut);
  }

  @override
  Stream<List<UserVO>> getUsersFromDatabase() {
    return userDao.getAllUsersEventStream()
        .startWith(userDao.getUsersStream())
        .map((event) => userDao.getUsers());
  }

  @override
  Future<void> deleteUserFromDatabase() async {
    userDao.deleteUsers();
  }

  @override
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future<List<GenreVO>>.value(genreDao.getAllGenres());
  }

  @override
  Future<List<ActorVO>?> getAllActorsFromDatabase() {
    return Future.value(actorDao.getAllActors());
  }

}

//List<SeatsVO> seatList =
// value!.expand((element) => element).toList().map((each) {
// each.isSelected = false;
// return each;
// }).toList();
// return Future.value(value);

// return getUsersFromDatabase().then((user) {
//   return _dataAgent
//       .getCinemaSeatingPlan("Bearer ${user[0].token}", timeSlotId, date)
//       .then((data) {
//         List<SeatsVO> seatingPlan = data!.expand((seats) => seats).toList().map((seat) {
//           seat.isSelected = false;
//           return seat;
//         }).toList();
//         return Future.value(seatingPlan);
//   });
// });

//comingsoonfromdb
// return Future.value(movieDao
//     .getAllMovies()
//     .where((movie) => movie.isComingSoon ?? true)
//     .toList());


// @override
// Future<List<SnacksVO>> getSnacksFromDatabase() {
//   return Future.value(snacksDao.getAllSnacks());
// }

// @override
// Future<List<SnacksVO>?> getSnacks() {
//   return getUsersFromDatabase().then((user) {
//     return _dataAgent.getSnacks("Bearer ${user[0].token}").then((snacks) {
//       snacksDao.saveAllSnacks(snacks ?? []);
//       return Future.value(snacks);
//     });
//   });
//   // return _dataAgent.getSnacks("Bearer $token")
//   //     .asStream()
//   //     .map((snacks) {
//   //       snacks?.forEach((snack) {
//   //         snack.quantity = 0;
//   //       });
//   //       return snacks;
//   //     }).first;
// }


// @override
// Future<MovieVO?> getMovieDetails(int movieId) {
//   return _dataAgent.getMovieDetails(movieId);
// }

// @override
// Future<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
//   return Future.value(movieDao.getMovieById(movieId));
// }

// @override
// Future<List<UserVO>> getUsersFromDatabase() {
//   return Future.value(userDao.getUsers());
// }


// @override
// Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
//   return _dataAgent.getCreditsByMovie(movieId);
// }

// List<DayTimeSlotsVO> cinemaDayTime = value!.map((dayTime) {
//   dayTime.timeSlots.map((time) {
//     time?.isSelected = false;
//     return time;
//   }).toList();
//   return dayTime;
// }).toList();
// CinemaDayTimeVO cinemaList = CinemaDayTimeVO(cinemaDayTime);
// cinemaDayTimeDao.saveAllCinemaDayTimeSlots(date, cinemaList);
// @override
// Future<List<DayTimeSlotsVO>?> getCinemaDayTimeSlots(int movieId, String date) {
//     return _dataAgent.getCinemaDayTimeSlots(userDao.getUserToken() ?? "", movieId, date).then((cinemaDayTimeSlots) {
//       CinemaDayTimeVO cinemaDayTimeVO = CinemaDayTimeVO(cinemaDayTimeSlots);
//       cinemaDayTimeDao.saveAllCinemaDayTimeSlots(date, cinemaDayTimeVO);
//       return Future.value(cinemaDayTimeSlots);
//     });
// }
//
// @override
// Future<List<DayTimeSlotsVO>?> getCinemaDayTimeSlotsFromDatabase(String date) {
//   return Future.value(cinemaDayTimeDao.getCinemaDayTimeSlots(date)?.cinemaDayTimeList);
// }


// @override
// Future<List<PaymentVO>?> getPaymentMethods() {
//     return _dataAgent.getPaymentMethods(userDao.getUserToken() ?? "")
//         .then((response) {
//       List<PaymentVO>? getCards = response?.map((data) {
//         data.isSelected = false;
//         return data;
//       }).toList();
//       return Future.value(getCards);
//     });
// }