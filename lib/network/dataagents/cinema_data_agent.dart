
import 'package:movie_booking_app/data/vos/cinema/checkout_vo.dart';
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

abstract class CinemaDataAgent {

  Future<List<dynamic>> registerWithEmail(String name, String email, String phoneNumber, String password, String googleAccessToken, String facebookAccessToken);
  Future<List<dynamic>> logInWithEmail(String email, String password);
  Future<List<dynamic>> logInWithGoogle(String googleToken);
  Future<List<dynamic>> logInWithFacebook(String facebookToken);
  Future<String?> userLogOut(String token);

  Future<List<MovieVO>?> getNowPlayingMovies(int page);
  Future<List<MovieVO>?> getComingSoonMovies(int page);
  Future<List<GenreVO>?> getGenres();
  Future<MovieVO?> getMovieDetails(int movieId);
  Future<List<List<ActorVO>?>> getCreditsByMovie(int movieId);

  Future<List<DayTimeSlotsVO>?> getCinemaDayTimeSlots(String token, int movieId, String date);
  Future<List<List<SeatsVO>>?> getCinemaSeatingPlan(String token, int timeSlotId, String date);
  Future<List<SnacksVO>?> getSnacks(String token);
  Future<List<PaymentVO>?> getPaymentMethods(String token);
  Future<UserVO?> getProfile(String token);
  Future<List<CardVO>?> addCard(String token, String cardNumber, String cardHolder, String expirationDate, String cvc);
  Future<UserBookingVO?> checkOut(String token, CheckOutVO checkOut);

}