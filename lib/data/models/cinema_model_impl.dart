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
import 'package:movie_booking_app/persistence/daos/cinema_day_time_dao.dart';
import 'package:movie_booking_app/persistence/daos/genre_dao.dart';
import 'package:movie_booking_app/persistence/daos/movie_dao.dart';
import 'package:movie_booking_app/persistence/daos/snacks_dao.dart';
import 'package:movie_booking_app/persistence/daos/user_dao.dart';

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
  CinemaDayTimeDao cinemaDayTimeDao = CinemaDayTimeDao();

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
    return getUsersFromDatabase().then((user) {
      return _dataAgent.userLogOut("Bearer ${user[0].token}").then((value) {
        userDao.deleteUsers();
        return Future.value(value);
      });
    });
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMovies(int page) {
    return _dataAgent.getNowPlayingMovies(1);
  }

  @override
  Future<List<MovieVO>?> getComingSoonMovies(int page) {
    return _dataAgent.getComingSoonMovies(1);
  }

  @override
  Future<List<GenreVO>?> getGenres() {
    return _dataAgent.getGenres();
  }

  @override
  Future<MovieVO?> getMovieDetails(int movieId) {
    return _dataAgent.getMovieDetails(movieId);
  }

  @override
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId) {
    return _dataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<List<DayTimeSlotsVO>?> getCinemaDayTimeSlots(int movieId, String date) {
    return getUsersFromDatabase().then((user) {
      return _dataAgent.getCinemaDayTimeSlots("Bearer ${user[0].token}", movieId, date).then((cinemaDayTimeSlots) {
        CinemaDayTimeVO cinemaDayTimeVO = CinemaDayTimeVO(cinemaDayTimeSlots);
        cinemaDayTimeDao.saveAllCinemaDayTimeSlots(date, cinemaDayTimeVO);
        return Future.value(cinemaDayTimeSlots);
      });
      //return _dataAgent.getCinemaDayTimeSlots("Bearer ${user[0].token}", movieId, date);
    });
  }

  @override
  Future<List<dynamic>?> getCinemaSeatingPlan(int timeSlotId, String date) {

    return getUsersFromDatabase().then((user) {
      return _dataAgent
          .getCinemaSeatingPlan("Bearer ${user[0].token}", timeSlotId, date)
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
    });

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

  }

  @override
  Future<List<SnacksVO>?> getSnacks() {
    return getUsersFromDatabase().then((user) {
      return _dataAgent.getSnacks("Bearer ${user[0].token}").then((snacks) {
        snacksDao.saveAllSnacks(snacks ?? []);
        return Future.value(snacks);
      });
    });
    // return _dataAgent.getSnacks("Bearer $token")
    //     .asStream()
    //     .map((snacks) {
    //       snacks?.forEach((snack) {
    //         snack.quantity = 0;
    //       });
    //       return snacks;
    //     }).first;
  }

  @override
  Future<List<PaymentVO>?> getPaymentMethods() {
    return getUsersFromDatabase().then((user) {
      return _dataAgent.getPaymentMethods("Bearer ${user[0].token}")
          .then((response) {
        List<PaymentVO>? getCards = response?.map((data) {
          data.isSelected = false;
          return data;
        }).toList();
        return Future.value(getCards);
      });
    });
  }

  @override
  Future<UserVO?> getProfile() {
    return getUsersFromDatabase().then((user) {
      return _dataAgent.getProfile("Bearer ${user[0].token}");
    });
  }

  @override
  Future<void> addCard(String cardNumber, String cardHolder, String expirationDate, String cvc) {
    return getUsersFromDatabase().then((user) {
      return _dataAgent.addCard("Bearer ${user[0].token}", cardNumber, cardHolder, expirationDate, cvc);
    });
  }

  @override
  Future<UserBookingVO?> checkOut(CheckOutVO checkOut) {
    return getUsersFromDatabase().then((user) {
      return _dataAgent.checkOut("Bearer ${user[0].token}", checkOut);
    });
  }

  @override
  Future<List<UserVO>> getUsersFromDatabase() {
    return Future.value(userDao.getUsers());
  }

  @override
  Future<void> deleteUserFromDatabase() async {
    userDao.deleteUsers();
  }

  @override
  Future<List<MovieVO>?> getNowPlayingMoviesFromDatabase() {
    return Future.value(movieDao
        .getAllMovies()
        .where((movie) => movie.isNowPlaying ?? true)
        .toList());
  }

  @override
  Future<List<MovieVO>?> getComingSoonMoviesFromDatabase() {
    return Future.value(movieDao
        .getAllMovies()
        .where((movie) => movie.isComingSoon ?? true)
        .toList());
  }

  @override
  Future<List<GenreVO>?> getGenresFromDatabase() {
    return Future<List<GenreVO>>.value(genreDao.getAllGenres());
  }

  @override
  Future<List<ActorVO>?> getAllActorsFromDatabase() {
    return Future.value(actorDao.getAllActors());
  }

  @override
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(movieDao.getMovieById(movieId));
  }

  @override
  Future<List<SnacksVO>> getSnacksFromDatabase() {
    return Future.value(snacksDao.getAllSnacks());
  }

  @override
  Future<List<DayTimeSlotsVO>?> getCinemaDayTimeSlotsFromDatabase(String date) {
    return Future.value(cinemaDayTimeDao.getCinemaDayTimeSlots(date)?.cinemaDayTimeList);
  }

}

//List<SeatsVO> seatList =
// value!.expand((element) => element).toList().map((each) {
// each.isSelected = false;
// return each;
// }).toList();
// return Future.value(value);
