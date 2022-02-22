
import 'package:movie_booking_app/data/vos/cinema/checkout_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/cinema_day_time_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/day_time_slots_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/payment_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/snacks_vo.dart';
import 'package:movie_booking_app/data/vos/cinema/user_booking_vo.dart';
import 'package:movie_booking_app/data/vos/movies/actor_vo.dart';
import 'package:movie_booking_app/data/vos/movies/genre_vo.dart';
import 'package:movie_booking_app/data/vos/movies/movie_vo.dart';
import 'package:movie_booking_app/data/vos/users/card_vo.dart';
import 'package:movie_booking_app/data/vos/users/user_vo.dart';

abstract class CinemaModel {

  /// Network
  Future<String?> registerWithEmail(String name, String email, String phoneNumber, String password, String googleAccessToken, String facebookAccessToken);
  Future<String?> logInWithEmail(String email, String password);
  Future<String?> logInWithGoogle(String googleToken);
  Future<String?> logInWithFacebook(String facebookToken);
  Future<String?> userLogOut();

  Future<List<MovieVO>?> getNowPlayingMovies(int page);
  Future<List<MovieVO>?> getComingSoonMovies(int page);
  Future<List<GenreVO>?> getGenres();
  Future<MovieVO?> getMovieDetails(int movieId);
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId);

  Future<List<DayTimeSlotsVO>?> getCinemaDayTimeSlots(int movieId, String date);
  Future<List<dynamic>?> getCinemaSeatingPlan(int timeSlotId, String bookingDate);
  Future<List<SnacksVO>?> getSnacks();
  Future<List<PaymentVO>?> getPaymentMethods();
  Future<UserVO?> getProfile();
  Future<void> addCard(String cardNumber, String cardHolder, String expirationDate, String cvc);
  Future<UserBookingVO?> checkOut(CheckOutVO checkOut);

  /// Database
  Future<List<UserVO>> getUsersFromDatabase();
  Future<void> deleteUserFromDatabase();

  Future<List<MovieVO>?> getNowPlayingMoviesFromDatabase();
  Future<List<MovieVO>?> getComingSoonMoviesFromDatabase();
  Future<List<GenreVO>?> getGenresFromDatabase();
  Future<List<ActorVO>?> getAllActorsFromDatabase();
  Future<MovieVO?> getMovieDetailsFromDatabase(int movieId);

  Future<List<SnacksVO>> getSnacksFromDatabase();
  Future<List<DayTimeSlotsVO>?> getCinemaDayTimeSlotsFromDatabase(String date);

}