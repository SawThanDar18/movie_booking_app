
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

  Future<String?> registerWithEmail(String name, String email, String phoneNumber, String password, String googleAccessToken, String facebookAccessToken);
  Future<String?> logInWithEmail(String email, String password);
  Future<String?> logInWithGoogle(String googleToken);
  Future<String?> logInWithFacebook(String facebookToken);
  Future<String?> userLogOut();
  Stream<List<UserVO>> getUsersFromDatabase();
  Future<void> deleteUserFromDatabase();

  void getNowPlayingMovies(int page);
  Stream<List<MovieVO>?> getNowPlayingMoviesFromDatabase();
  void getComingSoonMovies(int page);
  Stream<List<MovieVO>?> getComingSoonMoviesFromDatabase();
  Future<List<GenreVO>?> getGenres();
  void getMovieDetails(int movieId);
  Stream<MovieVO?> getMovieDetailsFromDatabase(int movieId);
  void getCreditsByMovie(int movieId);
  Stream<List<ActorVO>?> getCreditsByMovieFromDatabase(int movieId);
  Future<List<GenreVO>?> getGenresFromDatabase();
  Future<List<ActorVO>?> getAllActorsFromDatabase();

  void getCinemaDayTimeSlots(int movieId, String date);
  Stream<List<DayTimeSlotsVO>?> getCinemaDayTimeSlotsFromDatabase(int movieId, String date);
  Future<List<dynamic>?> getCinemaSeatingPlan(int timeSlotId, String bookingDate);
  void getSnacks();
  Stream<List<SnacksVO>?> getSnacksFromDatabase();
  void getPaymentMethods();
  Stream<List<PaymentVO>?> getPaymentMethodsFromDatabase();
  Future<UserVO?> getProfile();
  Future<void> addCard(String cardNumber, String cardHolder, String expirationDate, String cvc);
  Stream<List<CardVO>?> getCardsFromDatabase();
  Future<UserBookingVO?> checkOut(CheckOutVO checkOut);


}